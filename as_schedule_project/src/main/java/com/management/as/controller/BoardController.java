package com.management.as.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.management.as.domain.BoardAttachVO;
import com.management.as.domain.BoardVO;
import com.management.as.domain.Criterai;
import com.management.as.domain.PageDTO;
import com.management.as.service.BoardService;	// 다른 패키지에 있으므로 import 시켜준다.

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/admin/*")
@AllArgsConstructor		// lombok 의 언어테이션 = 생성자를 자동으로 만들어줌
public class BoardController {
	
	private BoardService service;
	
	@GetMapping("/index")
	public String index() {
		log.info("------------------------/customer/index로 이동-------------------------");
		return "/admin/index";
	}

	// 게시판 리스트 목록 보기 화면으로 이동	
	
	@GetMapping("/list")
	public void list(Criterai cri, Model model) {
		log.info("게시판 리스트 목록 보기 화면으로 이동");
		
		model.addAttribute("list", service.getListWithPaging(cri));
		int total = service.getTotalCount(cri);
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}
	
	// 목록 리스트에서 제목을 클릭하여 상세내용 화면으로 이동
	
	@GetMapping("/get")
	public void get(@RequestParam("bno") int bno, Model model) {
		
		log.info("숫자가 제대로 나오는가 : " + bno);
		
		model.addAttribute("admin", service.get(bno));
		
	}
	
	// 수정 버튼을 클릭하면 수정 할 수 있는 화면으로 이동
	
	@GetMapping("/modify")
	public void modify(@RequestParam("bno") int bno, Model model) {
		
		model.addAttribute("admin", service.get(bno));
		
	}
	
	// 게시판 번호, 수정된 제목, 수정된 내용으로 update 하기 위한 controller
	@PostMapping("/modify")
	public String modifypost(BoardVO board, RedirectAttributes rttr) {
		
		service.modify(board);	// update
		
		// 상세페이지로 화면 이동
		//return "/board/get";	다이렉트로 가면 DB 를 거치지 않아서 정보가 나오지 않음
		//rttr.addFlashAttribute("bno", board.getBno());	// bno 를 숨겨서 보내게 되어 오류가 나옴
		rttr.addAttribute("bno", board.getBno());
		
		return "redirect:/admin/get";
	}
	
	// 삭제 버튼을 클릭
	@GetMapping("remove")
	public String remove(@RequestParam("bno") int bno) {
		
		service.remove(bno);	// delete
		
		// 삭제를 하고 나면 list.jsp 로 이동해라
		return "redirect:/admin/list";
		
	}
	
	// 글쓰기 화면으로 이동
	@GetMapping("write")
	public void write(HttpSession session) {
		session.setAttribute("writer", "김인아");	// 로그인 값이 없어서 잠시 이렇게 사용
												// 로그인 작업이 되었다면, 사용자 이름을 정자바에 작성
		
	}		
	
	@PostMapping("write")
	public String writepost(BoardVO board, HttpSession session) {

		String writer = (String)session.getAttribute("writer");
		board.setWriter(writer);
		
		if(board.getAttachList() != null ) {	// 글쓰기에서 첨부파일이 있으면,
			
			board.getAttachList().forEach(attach -> log.info(attach));
			
		}
		
		
		log.info("board : " + board);
		
		service.register(board);	// insert
		
		// 글쓰기 완료 후 리스트로 이동
		return "redirect:/admin/list";
	}
	
	@GetMapping(value="/getAttachList" , produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<BoardAttachVO>> getAttachList(int bno){
		
		log.info("getAttachList " + bno);
		
									// select
		return new ResponseEntity<>(service.getAttachlist(bno), HttpStatus.OK);
	}
	
	
	
	
	
	
	
	
	
	
	
}

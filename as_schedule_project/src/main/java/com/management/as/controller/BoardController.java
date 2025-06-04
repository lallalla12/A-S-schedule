package com.management.as.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.management.as.domain.BoardVO;
import com.management.as.domain.Criterai;
import com.management.as.domain.PageDTO;
import com.management.as.service.BoardService;	// 다른 패키지에 있으므로 import 시켜준다.

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/admin/board/*")
@AllArgsConstructor		// lombok 의 언어테이션 = 생성자를 자동으로 만들어줌
public class BoardController {
	
	private BoardService service;

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
		model.addAttribute("board", service.get(bno));
	}
	
	// 수정 버튼을 클릭하면 수정 할 수 있는 화면으로 이동
	
	@GetMapping("/modify")
	public void modify(@RequestParam("bno") int bno, Model model) {
		
		model.addAttribute("board", service.get(bno));
		
	}
	
	// 게시판 번호, 수정된 제목, 수정된 내용으로 update 하기 위한 controller
	@PostMapping("/modify")
	public String modifypost(BoardVO board, RedirectAttributes rttr) {
		
		service.modify(board);	// update
		
		// 상세페이지로 화면 이동
		//return "/board/get";	다이렉트로 가면 DB 를 거치지 않아서 정보가 나오지 않음
		//rttr.addFlashAttribute("bno", board.getBno());	// bno 를 숨겨서 보내게 되어 오류가 나옴
		rttr.addAttribute("bno", board.getBno());
		
		return "redirect:/admin/board/get";
	}
	
	// 삭제 버튼을 클릭
	@GetMapping("remove")
	public String remove(@RequestParam("bno") int bno) {
		service.remove(bno);	// delete
		// 삭제를 하고 나면 list.jsp 로 이동해라
		return "redirect:/admin/board/list";
		
	}
	
	// 글쓰기 화면으로 이동
	@GetMapping("write")
	public void write(HttpSession session) {
		session.setAttribute("writer", "관리자");
	}		
	
	@PostMapping("write")
	public String writepost(BoardVO board, HttpSession session) {
		String writer = (String)session.getAttribute("writer");
		board.setWriter(writer);
		log.info("board : " + board);
		
		service.register(board);	// insert
		
		// 글쓰기 완료 후 리스트로 이동
		return "redirect:/admin/board/list";
	}
	
	@PostMapping("/assignEngineer")
	@ResponseBody
	public ResponseEntity<String> assignEngineer(@RequestBody Map<String, String> data) {
	    String eno = data.get("eno");
	    String receiptNo = data.get("receiptNo");

	    log.info("기사 배정 요청: eno=" + eno + ", receiptNo=" + receiptNo);

	    service.assignEngineer(eno, receiptNo); // service 호출
	    return ResponseEntity.ok("success");
	}
	
	
}

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
import com.management.as.service.BoardService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/admin/board/*")
@AllArgsConstructor
public class BoardController {
	
	private BoardService service;

	// 게시판 리스트 목록 화면으로 이동	
	@GetMapping("/list")
	public void list(Criterai cri, Model model) {
		log.info("게시판 리스트 목록 화면으로 이동");
		model.addAttribute("list", service.getListWithPaging(cri));
		int total = service.getTotalCount(cri);
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}
	
	// 목록 리스트에서 제목을 클릭하여 상세내용 화면으로 이동
	@GetMapping("/get")
	public void get(@RequestParam("bno") int bno, Model model) {
		model.addAttribute("board", service.get(bno));
	}
	
	// 수정 버튼을 클릭하면 수정할 수 있는 화면으로 이동
	@GetMapping("/modify")
	public void modify(@RequestParam("bno") int bno, Model model) {
		model.addAttribute("board", service.get(bno));
	}
	
	// 게시판 번호, 수정된 제목, 수정된 내용을 update 하기 위한 controller
	@PostMapping("/modify")
	public String modifypost(BoardVO board, RedirectAttributes rttr) {
		service.modify(board); // update
		rttr.addAttribute("bno", board.getBno());
		return "redirect:/admin/board/get";
	}
	
	// 삭제 버튼을 클릭
	@GetMapping("remove")
	public String remove(@RequestParam("bno") int bno) {
		service.remove(bno); // delete
		return "redirect:/admin/board/list";
	}
	
	// 글쓰기 화면으로 이동
	@GetMapping("write")
	public void write(HttpSession session) {
		session.setAttribute("writer", "관리자");
	}		
	
	// 글쓰기 등록 처리
	@PostMapping("write")
	public String writepost(BoardVO board, HttpSession session) {
		String writer = (String)session.getAttribute("writer");
		board.setWriter(writer);
		log.info("board : " + board);
		service.register(board); // insert
		return "redirect:/admin/board/list";
	}
	
}
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
import com.management.as.service.BoardService;	// �떎瑜� �뙣�궎吏��뿉 �엳�쑝誘�濡� import �떆耳쒖��떎.

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/admin/board/*")
@AllArgsConstructor		// lombok �쓽 �뼵�뼱�뀒�씠�뀡 = �깮�꽦�옄瑜� �옄�룞�쑝濡� 留뚮뱾�뼱以�
public class BoardController {
	
	private BoardService service;

	// 寃뚯떆�뙋 由ъ뒪�듃 紐⑸줉 蹂닿린 �솕硫댁쑝濡� �씠�룞	
	
	@GetMapping("/list")
	public void list(Criterai cri, Model model) {
		log.info("寃뚯떆�뙋 由ъ뒪�듃 紐⑸줉 蹂닿린 �솕硫댁쑝濡� �씠�룞");
		model.addAttribute("list", service.getListWithPaging(cri));
		int total = service.getTotalCount(cri);
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}
	
	// 紐⑸줉 由ъ뒪�듃�뿉�꽌 �젣紐⑹쓣 �겢由��븯�뿬 �긽�꽭�궡�슜 �솕硫댁쑝濡� �씠�룞
	
	@GetMapping("/get")
	public void get(@RequestParam("bno") int bno, Model model) {
		model.addAttribute("board", service.get(bno));
	}
	
	// �닔�젙 踰꾪듉�쓣 �겢由��븯硫� �닔�젙 �븷 �닔 �엳�뒗 �솕硫댁쑝濡� �씠�룞
	
	@GetMapping("/modify")
	public void modify(@RequestParam("bno") int bno, Model model) {
		
		model.addAttribute("board", service.get(bno));
		
	}
	
	// 寃뚯떆�뙋 踰덊샇, �닔�젙�맂 �젣紐�, �닔�젙�맂 �궡�슜�쑝濡� update �븯湲� �쐞�븳 controller
	@PostMapping("/modify")
	public String modifypost(BoardVO board, RedirectAttributes rttr) {
		
		service.modify(board);	// update
		
		// �긽�꽭�럹�씠吏�濡� �솕硫� �씠�룞
		//return "/board/get";	�떎�씠�젆�듃濡� 媛�硫� DB 瑜� 嫄곗튂吏� �븡�븘�꽌 �젙蹂닿� �굹�삤吏� �븡�쓬
		//rttr.addFlashAttribute("bno", board.getBno());	// bno 瑜� �닲寃⑥꽌 蹂대궡寃� �릺�뼱 �삤瑜섍� �굹�샂
		rttr.addAttribute("bno", board.getBno());
		
		return "redirect:/admin/board/get";
	}
	
	// �궘�젣 踰꾪듉�쓣 �겢由�
	@GetMapping("remove")
	public String remove(@RequestParam("bno") int bno) {
		service.remove(bno);	// delete
		// �궘�젣瑜� �븯怨� �굹硫� list.jsp 濡� �씠�룞�빐�씪
		return "redirect:/admin/board/list";
		
	}
	
	// 湲��벐湲� �솕硫댁쑝濡� �씠�룞
	@GetMapping("write")
	public void write(HttpSession session) {
		session.setAttribute("writer", "愿�由ъ옄");
	}		
	
	@PostMapping("write")
	public String writepost(BoardVO board, HttpSession session) {
		String writer = (String)session.getAttribute("writer");
		board.setWriter(writer);
		log.info("board : " + board);
		
		service.register(board);	// insert
		
		// 湲��벐湲� �셿猷� �썑 由ъ뒪�듃濡� �씠�룞
		return "redirect:/admin/board/list";
	}
	
	@PostMapping("/assignEngineer")
	@ResponseBody
	public ResponseEntity<String> assignEngineer(@RequestBody Map<String, String> data) {
	    String eno = data.get("eno");
	    String receiptNo = data.get("receiptNo");

	    log.info("湲곗궗 諛곗젙 �슂泥�: eno=" + eno + ", receiptNo=" + receiptNo);

	    service.assignEngineer(eno, receiptNo); // service �샇異�
	    return ResponseEntity.ok("success");
	}
	
	
	
}

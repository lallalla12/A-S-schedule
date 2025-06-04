package com.management.as.controller;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
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

import com.management.as.domain.Criterai;
import com.management.as.domain.CustomerVO;
import com.management.as.domain.PageDTO;
import com.management.as.domain.ProductVO;
import com.management.as.service.BoardService;
import com.management.as.service.CustomerService;
import com.management.as.domain.UserVO;

@Controller
@RequestMapping("/customer")
public class CustomerController {
	private static final Logger log = LoggerFactory.getLogger(HomeController.class);
	
	@Autowired
	private CustomerService service;
	@Autowired
	private BoardService boardService;
	
	@GetMapping("/index")
	public String index(RedirectAttributes redirectAttributes, HttpSession session) {
		log.info("------------------------/customer/index濡� �씠�룞-------------------------");
		// �궗�슜�옄 �젙蹂� 議고쉶
		String user_id = (String) session.getAttribute("user_id"); 
		if (user_id ==null) { 
			redirectAttributes.addFlashAttribute("message", "濡쒓렇�씤�씠 �븘�슂�빀�땲�떎.");
			return "redirect:/login"; 
		}
		
		int count = service.idCheck(user_id);
		if(count > 0 ) {
			return "/customer/index";
		} else {
			redirectAttributes.addFlashAttribute("message", "怨좉컼�젙蹂닿� �뾾�뒿�땲�떎.");
			session.invalidate();
			return "redirect:/login";
		}
	}
	
	@GetMapping("/join")
	public String join() {
		return "/customer/join";
	}
	
	@PostMapping("/login")
	public String login(@RequestParam String id, @RequestParam String password, RedirectAttributes redirectAttributes, HttpSession session) {
		UserVO user = service.findByUserId(id); // �궗�슜�옄 �젙蹂� 議고쉶
	    
	    if (user != null && user.getPassword().equals(password)) {
	        session.setAttribute("user_id", user.getUser_id());
	        session.setAttribute("uid", user.getUid());
	        redirectAttributes.addFlashAttribute("message", "濡쒓렇�씤�릺�뿀�뒿�땲�떎.");
	        return "redirect:/customer/index";
	    } else {
	        redirectAttributes.addFlashAttribute("message", "�븘�씠�뵒 諛� 鍮꾨�踰덊샇媛� �씪移섑븯吏� �븡�뒿�땲�떎.");
	        return "redirect:/login";
	    }
	}
	
	
	@PostMapping("/join")
	public String join(UserVO vo, HttpSession session, RedirectAttributes redirectAttributes) {
		service.join(vo);
	    
		redirectAttributes.addFlashAttribute("message", "�쉶�썝媛��엯�씠 �셿猷뚮릺�뿀�뒿�땲�떎.");
		
		return "redirect:/login";
	}
	
	@GetMapping(value="/idCheck")
	@ResponseBody
	public int idCheck(@RequestParam("user_id") String id) {
		return service.idCheck(id);
	}
	
	@GetMapping("/register")
	public String register(Model model, HttpSession session, RedirectAttributes redirectAttributes) {
		List<ProductVO> productList = service.productList();
		
		// �궗�슜�옄 �젙蹂� 議고쉶
		String user_id = (String) session.getAttribute("user_id");
		if (user_id ==null) { 
			redirectAttributes.addFlashAttribute("message", "濡쒓렇�씤�씠 �븘�슂�빀�땲�떎.");
			return "redirect:/login"; 
		}
		UserVO userInfo = service.findByUserId(user_id);
		String phone_formated = userInfo.getPhone().replaceFirst("(\\d{3})(\\d{4})(\\d{4})", "$1-$2-$3");
		model.addAttribute("productList", productList);
		model.addAttribute("userInfo", userInfo);
		model.addAttribute("phone_formated", phone_formated);
		return "/customer/register";
	}
	
	@PostMapping("/register")
	public String register(CustomerVO vo, RedirectAttributes redirectAttributes) {
		service.register(vo);
		redirectAttributes.addFlashAttribute("message", "�젒�닔媛� �셿猷뚮릺�뿀�뒿�땲�떎.");
		return "redirect:/customer/index";
	}
	
	@GetMapping("/mypage")
	public String list(@RequestParam(required = false) String type, @RequestParam(defaultValue = "1") int page, @RequestParam(required = false) String keyword, @RequestParam(required = false) String status_keyword, 
			HttpSession session, Model model, RedirectAttributes redirectAttributes) {
		// �궗�슜�옄 �젙蹂� 議고쉶
		String user_id = (String) session.getAttribute("user_id"); 
		if (user_id ==null) { 
			redirectAttributes.addFlashAttribute("message", "濡쒓렇�씤�씠 �븘�슂�빀�땲�떎.");
			return "redirect:/login"; 
		}
		// �럹�씠吏� �떆�옉
		int pageSize = 10;  // �븳 �럹�씠吏��뿉 10媛쒖뵫 蹂댁뿬二쇨린
		int totalCount = service.totalCount(user_id, type, keyword, status_keyword);
		// �쟾泥� �럹�씠吏� �닔 怨꾩궛
	    int totalPages = (int) Math.ceil((double) totalCount / pageSize);
	    // 議고쉶 �떆�옉 �쐞移�(offset) 怨꾩궛
	    int offset = (page - 1) * pageSize;
			    
		List<CustomerVO> list = service.list(user_id, type, keyword, status_keyword, offset, pageSize);
		model.addAttribute("clist", list);
		model.addAttribute("type", type);
	    model.addAttribute("keyword", keyword);
	    model.addAttribute("currentPage", page);
	    model.addAttribute("totalPages", totalPages);
	    model.addAttribute("status_keyword", status_keyword);
		return "/customer/list";
	}
	
	@GetMapping("/comment/add")
	public String popup(@RequestParam("cnum") int cnum, Model model) {
		model.addAttribute("cnum", cnum);
		return "/customer/comment/add";
	}
	
	@PostMapping("/comment/add")
	public String update(CustomerVO vo, RedirectAttributes redirectAttributes) {
		service.update(vo);
		redirectAttributes.addFlashAttribute("message", "�썑湲곌� �벑濡앸릺�뿀�뒿�땲�떎.");
		return "redirect:/customer/mypage";
	}
	
	@GetMapping("/logout")
	public String logout(HttpSession session, RedirectAttributes redirectAttributes) {
	    session.invalidate();
	    redirectAttributes.addFlashAttribute("message", "濡쒓렇�븘�썐 �릺�뿀�뒿�땲�떎.");
	    return "redirect:/";
	}
	
	// 怨듭��궗�빆
	@GetMapping("/board/list")
	public String list(Criterai cri, Model model) {
		log.info("寃뚯떆�뙋 由ъ뒪�듃 紐⑸줉 蹂닿린 �솕硫댁쑝濡� �씠�룞(怨좉컼)");
		cri.setBoardType("C");
		log.info("Criterai: {}", cri);
		model.addAttribute("list", boardService.getListWithPaging(cri));
		int total = boardService.getTotalCount(cri);
		model.addAttribute("pageMaker", new PageDTO(cri, total));
		model.addAttribute("keyword", cri.getKeyword());
		return "/customer/board/list";
	}
	
	// 紐⑸줉 由ъ뒪�듃�뿉�꽌 �젣紐⑹쓣 �겢由��븯�뿬 �긽�꽭�궡�슜 �솕硫댁쑝濡� �씠�룞
	@GetMapping("/board/get")
	public String get(@RequestParam("bno") int bno, Model model) {
		model.addAttribute("board", boardService.get(bno));
		return "/customer/board/view";
	}
	
	@PostMapping("/updateEndDate")
	public ResponseEntity<?> updateEndDate(@RequestBody Map<String, String> payload) {
	    int cnum = Integer.parseInt(payload.get("cnum"));
	    String endDateStr = payload.get("endDate");

	    try {
	        LocalDate endDate = LocalDate.parse(endDateStr);
	        service.updateEndDate(cnum, endDate); // DB 처리
	        return ResponseEntity.ok().build();
	    } catch (Exception e) {
	        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("오류 발생");
	    }
	}
}

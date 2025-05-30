package com.management.as.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.management.as.domain.CustomerVO;
import com.management.as.domain.ProductVO;
import com.management.as.service.CustomerService;

@Controller
@RequestMapping("/customer")
public class CustomerController {
	private static final Logger log = LoggerFactory.getLogger(HomeController.class);
	
	@Autowired
	private CustomerService service;
	
	@GetMapping("/index")
	public String index() {
		log.info("------------------------/customer/index로 이동-------------------------");
		return "/customer/index";
	}
	
	@GetMapping("/register")
	public String register(Model model) {
		List<ProductVO> productList = service.productList();
		model.addAttribute("productList", productList);
		return "/customer/register";
	}
	
	@PostMapping("/register")
	public String register(CustomerVO vo, RedirectAttributes redirectAttributes) {
		service.register(vo);
		redirectAttributes.addFlashAttribute("message", "접수가 완료되었습니다.");
		return "redirect:/customer/index";
	}
	
	@GetMapping("/mypage")
	public String list(@RequestParam(required = false) String type, @RequestParam(defaultValue = "1") int page, @RequestParam(required = false) String keyword, @RequestParam(required = false) String status_keyword, 
			HttpSession session, Model model, RedirectAttributes redirectAttributes) {
		// 사용자 정보 조회
		/*
		 * String id = (String) session.getAttribute("userId"); if (id == null) {
		 * redirectAttributes.addFlashAttribute("message", "로그인이 필요합니다."); return
		 * "redirect:/"; }
		 *  UserVO에서 userId값 가져와서 조회해야함.
		 */
		String cname = "김인아";
		// 페이징 시작
		int pageSize = 10;  // 한 페이지에 10개씩 보여주기
		int totalCount = service.totalCount(cname, type, keyword, status_keyword);
		// 전체 페이지 수 계산
	    int totalPages = (int) Math.ceil((double) totalCount / pageSize);
	    // 조회 시작 위치(offset) 계산
	    int offset = (page - 1) * pageSize;
			    
		List<CustomerVO> list = service.list(cname, type, keyword, status_keyword, offset, pageSize);
		model.addAttribute("clist", list);
		model.addAttribute("type", type);
	    model.addAttribute("keyword", keyword);
	    model.addAttribute("currentPage", page);
	    model.addAttribute("totalPages", totalPages);
	    model.addAttribute("status_keyword", status_keyword);
		return "/customer/list";
	}
	
	@GetMapping("/comment")
	public String get(@RequestParam("cnum") int cnum, Model model, RedirectAttributes redirectAttributes) {
		CustomerVO vo = service.get(cnum);
		model.addAttribute("vo", vo);
		return "/customer/comment";
	}
	
	@PostMapping("/comment")
	public String update(CustomerVO vo, RedirectAttributes redirectAttributes) {
		service.update(vo);
		redirectAttributes.addFlashAttribute("message", "후기가 등록되었습니다.");
		return "redirect:/customer/mypage";
	}
}

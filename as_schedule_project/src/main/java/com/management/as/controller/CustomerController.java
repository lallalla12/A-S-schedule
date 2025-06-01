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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.management.as.domain.CustomerVO;
import com.management.as.domain.ProductVO;
import com.management.as.service.CustomerService;
import com.management.as.domain.UserVO;

@Controller
@RequestMapping("/customer")
public class CustomerController {
	private static final Logger log = LoggerFactory.getLogger(HomeController.class);
	
	@Autowired
	private CustomerService service;
	
	@GetMapping("/index")
	public String index(RedirectAttributes redirectAttributes, HttpSession session) {
		log.info("------------------------/customer/index로 이동-------------------------");
		// 사용자 정보 조회
		String user_id = (String) session.getAttribute("user_id"); 
		if (user_id ==null) { 
			redirectAttributes.addFlashAttribute("message", "로그인이 필요합니다.");
			return "redirect:/login"; 
		}
		return "/customer/index";
	}
	
	@GetMapping("/join")
	public String join() {
		return "/customer/join";
	}
	
	@PostMapping("/login")
	public String login(@RequestParam String id, @RequestParam String password, RedirectAttributes redirectAttributes, HttpSession session) {
		UserVO user = service.findByUserId(id); // 사용자 정보 조회
	    
	    if (user != null && user.getPassword().equals(password)) {
	        session.setAttribute("user_id", user.getUser_id());
	        session.setAttribute("uid", user.getUid());
	        redirectAttributes.addFlashAttribute("message", "로그인되었습니다.");
	        return "redirect:/customer/index";
	    } else {
	        redirectAttributes.addFlashAttribute("message", "아이디 및 비밀번호가 일치하지 않습니다.");
	        return "redirect:/login";
	    }
	}
	
	
	@PostMapping("/join")
	public String join(UserVO vo, HttpSession session, RedirectAttributes redirectAttributes) {
		service.join(vo);
	    
		redirectAttributes.addFlashAttribute("message", "회원가입이 완료되었습니다.");
		
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
		
		// 사용자 정보 조회
		String user_id = (String) session.getAttribute("user_id");
		if (user_id ==null) { 
			redirectAttributes.addFlashAttribute("message", "로그인이 필요합니다.");
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
		redirectAttributes.addFlashAttribute("message", "접수가 완료되었습니다.");
		return "redirect:/customer/index";
	}
	
	@GetMapping("/mypage")
	public String list(@RequestParam(required = false) String type, @RequestParam(defaultValue = "1") int page, @RequestParam(required = false) String keyword, @RequestParam(required = false) String status_keyword, 
			HttpSession session, Model model, RedirectAttributes redirectAttributes) {
		// 사용자 정보 조회
		String user_id = (String) session.getAttribute("user_id"); 
		if (user_id ==null) { 
			redirectAttributes.addFlashAttribute("message", "로그인이 필요합니다.");
			return "redirect:/login"; 
		}
		// 페이징 시작
		int pageSize = 10;  // 한 페이지에 10개씩 보여주기
		int totalCount = service.totalCount(user_id, type, keyword, status_keyword);
		// 전체 페이지 수 계산
	    int totalPages = (int) Math.ceil((double) totalCount / pageSize);
	    // 조회 시작 위치(offset) 계산
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
		redirectAttributes.addFlashAttribute("message", "후기가 등록되었습니다.");
		return "redirect:/customer/mypage";
	}
	
	@GetMapping("/logout")
	public String logout(HttpSession session, RedirectAttributes redirectAttributes) {
	    session.invalidate();
	    redirectAttributes.addFlashAttribute("message", "로그아웃 되었습니다.");
	    return "redirect:/";
	}
}

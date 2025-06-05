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
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
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
		log.info("------------------------/customer/index로 이동-------------------------");
		// 사용자 정보 확인
		String user_id = (String) session.getAttribute("user_id");
		if (user_id == null) {
			redirectAttributes.addFlashAttribute("message", "로그인이 필요합니다.");
			return "redirect:/login?gubun=customer";
		}

		int count = service.idCheck(user_id);
		if (count > 0) {
			return "/customer/index";
		} else {
			redirectAttributes.addFlashAttribute("message", "고객정보가 없습니다.");
			session.invalidate();
			return "redirect:/login?gubun=customer";
		}
	}

	@GetMapping("/join")
	public String join() {
		return "/customer/join";
	}

	@PostMapping("/login")
	public String login(@RequestParam String id, @RequestParam String password, RedirectAttributes redirectAttributes,
			HttpSession session) {
		UserVO user = service.findByUserId(id); // 사용자 정보 확인
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		
		if (user != null && encoder.matches(password, user.getPassword())) {
			session.setAttribute("user_id", user.getUser_id());
			session.setAttribute("uid", user.getUid());
			redirectAttributes.addFlashAttribute("message", "로그인되었습니다.");
			return "redirect:/customer/index";
		} else {
			redirectAttributes.addFlashAttribute("message", "아이디 또는 비밀번호가 일치하지 않습니다.");
			return "redirect:/login?gubun=customer";
		}
	}

	@PostMapping("/join")
	public String join(UserVO vo, HttpSession session, RedirectAttributes redirectAttributes) {
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		vo.setPassword(encoder.encode(vo.getPassword()));
		service.join(vo);
		redirectAttributes.addFlashAttribute("message", "회원가입이 완료되었습니다.");
		return "redirect:/login?gubun=customer";
	}

	@GetMapping(value = "/idCheck")
	@ResponseBody
	public int idCheck(@RequestParam("user_id") String id) {
		return service.idCheck(id);
	}

	@GetMapping("/register")
	public String register(Model model, HttpSession session, RedirectAttributes redirectAttributes) {
		List<ProductVO> productList = service.productList();

		// 사용자 정보 확인
		String user_id = (String) session.getAttribute("user_id");
		if (user_id == null) {
			redirectAttributes.addFlashAttribute("message", "로그인이 필요합니다.");
			return "redirect:/login?gubun=customer";
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
	public String list(@RequestParam(required = false) String type,
			@RequestParam(defaultValue = "1") int page,
			@RequestParam(required = false) String keyword,
			@RequestParam(required = false) String status_keyword,
			HttpSession session, Model model, RedirectAttributes redirectAttributes) {

		// 사용자 정보 확인
		String user_id = (String) session.getAttribute("user_id");
		if (user_id == null) {
			redirectAttributes.addFlashAttribute("message", "로그인이 필요합니다.");
			return "redirect:/login?gubun=customer";
		}

		// 페이지 시작
		int pageSize = 10;
		int totalCount = service.totalCount(user_id, type, keyword, status_keyword);
		int totalPages = (int) Math.ceil((double) totalCount / pageSize);
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
	
	@GetMapping("/detail")
	public String detail(@RequestParam("cnum") int cnum, Model model) {
		model.addAttribute("customer", service.get(cnum));
		return "/customer/detail";
	}
	
	@PostMapping("/detailUpdate")
	public String detailUpdate(CustomerVO vo, RedirectAttributes redirectAttributes) {
		service.detailUpdate(vo);
		redirectAttributes.addFlashAttribute("message", "수정되었습니다.");
		return "redirect:/customer/mypage";
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
		redirectAttributes.addFlashAttribute("message", "로그아웃되었습니다.");
		return "redirect:/";
	}

	// 공지사항
	@GetMapping("/board/list")
	public String list(Criterai cri, Model model) {
		log.info("게시판 리스트 목록 출력 화면으로 이동(고객)");
		cri.setBoardType("C");
		log.info("Criterai: {}", cri);
		model.addAttribute("list", boardService.getListWithPaging(cri));
		int total = boardService.getTotalCount(cri);
		model.addAttribute("pageMaker", new PageDTO(cri, total));
		model.addAttribute("keyword", cri.getKeyword());
		return "/customer/board/list";
	}

	// 목록 리스트에서 제목을 클릭하여 상세내용 화면으로 이동
	@GetMapping("/board/get")
	public String get(@RequestParam("bno") int bno, Model model) {
		model.addAttribute("board", boardService.get(bno));
		return "/customer/board/view";
	}

	@PostMapping("/updateEndDate")
	public ResponseEntity<?> updateEndDate(@RequestBody Map<String, String> payload) {
		int cnum = Integer.parseInt(payload.get("cnum"));
		String endDateStr = payload.get("endDate");
		String cmt = payload.get("cmt");

		try {
			LocalDate endDate = LocalDate.parse(endDateStr);
			service.updateEndDate(cnum, endDate, cmt); // DB 처리
			return ResponseEntity.ok().build();
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("오류 발생");
		}
	}
}
package com.management.as.controller;


import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.management.as.domain.Criterai;
import com.management.as.domain.EmployeeVO;
import com.management.as.domain.PageDTO;
import com.management.as.service.BoardService;
import com.management.as.service.EmployeeService;


import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/employee/*")
@AllArgsConstructor
public class EmployeeController {

	@Autowired
	private EmployeeService service;
	
	@Autowired
	private BoardService boardService;

	@GetMapping("/schedule")
	public void schedule(HttpSession session, Model model) {
		EmployeeVO emp = (EmployeeVO) session.getAttribute("loginEmp");
		
		String eno = emp.getEno();
		
		model.addAttribute("schedule", service.getSchedule(eno));
	} 
	
	@GetMapping("/index")
	public String index(HttpSession session, RedirectAttributes redirectAttributes){
		log.info("------------------------/employee/index로 이동-------------------------");
		EmployeeVO emp = (EmployeeVO) session.getAttribute("loginEmp");
		if (emp == null) {
			redirectAttributes.addFlashAttribute("message", "권한이 없습니다.");
            return "redirect:/login?gubun=employee"; 
        }
		String user_id = emp.getEno();
		if (user_id == null) {
			redirectAttributes.addFlashAttribute("message", "권한이 없습니다.");
			return "redirect:/login?gubun=employee"; 
		}
		
		int count = service.idCheck(user_id);
		if(count > 0 ) {
			return "/employee/index";
		} else {
			redirectAttributes.addFlashAttribute("message", "아이디 또는 비밀번호가 올바르지 않습니다.");
			session.invalidate();
			return "redirect:/login?gubun=employee";
		}
	}

	@PostMapping("/login")
	public String login(@RequestParam String id,
	                    @RequestParam String password,
	                    HttpSession session,
	                    RedirectAttributes redirectAttributes) {
	    
	    EmployeeVO emp = service.findById(id); // 비밀번호 비교를 위해 전체가 아닌 findById만

	    if (emp != null) {
	        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
	        
	        // 입력한 비밀번호와 암호화된 비밀번호 비교
	        if (encoder.matches(password, emp.getPassword())) {
	            session.setAttribute("loginEmp", emp);
	            session.setAttribute("user_id", emp.getEno());
	            return "redirect:/employee/index"; 
	        }
	    }

	    redirectAttributes.addFlashAttribute("error", "아이디 또는 비밀번호가 올바르지 않습니다.");
	    return "redirect:/login?gubun=employee"; 
	}
	
	// 공지사항
	@GetMapping("/board/list")
	public String list(Criterai cri, Model model) {
		cri.setBoardType("E");
		model.addAttribute("list", boardService.getListWithPaging(cri));
		int total = boardService.getTotalCount(cri);
		model.addAttribute("pageMaker", new PageDTO(cri, total));
		model.addAttribute("keyword", cri.getKeyword());
		return "/employee/board/list";
	}
	
	// 목록 리스트에서 제목을 클릭하여 상세내용 화면으로 이동
	@GetMapping("/board/get")
	public String get(@RequestParam("bno") int bno, Model model) {
		model.addAttribute("board", boardService.get(bno));
		return "/employee/board/view";
	}
	

	
	 
}

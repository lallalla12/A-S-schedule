package com.management.as.controller;


import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.management.as.domain.EmployeeVO;
import com.management.as.service.EmployeeService;


import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/employee/*")
@AllArgsConstructor
public class EmployeeController {

	private EmployeeService service;

	@GetMapping("/schedule")
	public void schedule(Model model) {
		model.addAttribute("schedule", service.getSchedule());
	}
	
	@GetMapping("/index")
	public String index(){
		log.info("------------------------/employee/index로 이동-------------------------");
		return"/employee/index";
	}
	
	
	@PostMapping("/login")
	public String login(@RequestParam String id,
					    @RequestParam String password,
					    HttpSession session,
					    RedirectAttributes redirectAttributes) {
		
		EmployeeVO emp = service.login(id,password);
		
		if (emp != null) {
            session.setAttribute("loginEmp", emp);
            return "redirect:schedule"; 
        } else {
            redirectAttributes.addFlashAttribute("error", "아이디 또는 비밀번호가 올바르지 않습니다.");
            return "redirect:/login"; 
        }
	}
	

	

}

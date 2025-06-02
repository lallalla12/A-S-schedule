package com.management.as.controller;


import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;


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

	

}

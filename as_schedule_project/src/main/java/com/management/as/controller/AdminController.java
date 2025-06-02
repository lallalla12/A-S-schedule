package com.management.as.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.management.as.service.BoardService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/admin/*")
@AllArgsConstructor	
public class AdminController {
	
	@GetMapping("/index")
	public String index() {
		log.info("------------------------/customer/index로 이동-------------------------");
		return "/admin/index";
	}
}

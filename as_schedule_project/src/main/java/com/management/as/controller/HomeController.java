package com.management.as.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "index";
	}
	
	@GetMapping("/login")
	public String login() {
		return "login";
	}
	
	@PostMapping("/login")
	public String login(@RequestParam("gubun") String gubun, @RequestParam("id") String id, @RequestParam("password") String password
			, HttpSession session, RedirectAttributes redirectAttributes) {
		if(gubun.equals("adm")) {
			if(!(id.equals("admin") && password.equals("admin1234"))) {
				redirectAttributes.addFlashAttribute("message", "아이디 및 비밀번호가 일치하지 않습니다.");
				return "redirect:/login";
			} else {
				session.setAttribute("user_id", "admin");
				return "redirect:/admin/index";
			}
		} else {
			redirectAttributes.addFlashAttribute("message", "잘못된 요청입니다.");
			return "redirect:/login";
		}
	}
}

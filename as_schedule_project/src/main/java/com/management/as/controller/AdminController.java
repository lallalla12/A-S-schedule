package com.management.as.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.management.as.domain.EmployeeVO;
import com.management.as.service.EmployeeService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/admin/*")
@AllArgsConstructor	
public class AdminController {
	
	private EmployeeService service;
	
	@GetMapping("/index")
	public String index(HttpSession session, RedirectAttributes redirectAttributes) {
		log.info("------------------------/admin/index로 이동-------------------------");
		// 사용자 정보 조회
		String user_id = (String) session.getAttribute("user_id"); 
		if (!"admin".equals(user_id)) { 
			redirectAttributes.addFlashAttribute("message", "권한이 없습니다.");
			return "redirect:/login"; 
		}
		return "/admin/index";
	}
	
	@GetMapping("/employee/list")
	public String list(
	        @RequestParam(value = "keyword", required = false) String keyword,
	        @RequestParam(value = "type", required = false) String type,
	        @RequestParam(value = "page", defaultValue = "1") int page,
	        Model model) {
		
		// 한 페이지에 표시할 직원 수
	    int size = 10; 
	    int offset = (page - 1) * size;

	    // 직원 목록 + 총 개수
	    List<EmployeeVO> list = service.getPagedListWithSearch(keyword, type, offset, size);
	    int totalCount = service.getTotalCount(keyword, type);

	    int totalPage = (int) Math.ceil((double) totalCount / size);
	    int startPage = Math.max(1, page - 2);
	    int endPage = Math.min(totalPage, page + 2);

	    model.addAttribute("employeeList", list);
	    model.addAttribute("currentPage", page);
	    model.addAttribute("totalPage", totalPage);
	    model.addAttribute("startPage", startPage);
	    model.addAttribute("endPage", endPage);
	    model.addAttribute("hasPrev", startPage > 1);
	    model.addAttribute("hasNext", endPage < totalPage);
	    model.addAttribute("keyword", keyword);
	    model.addAttribute("type", type);

	    return "admin/employee/list";
	}
	

	@GetMapping("/employee/list/json")
	@ResponseBody
	public List<EmployeeVO> getEmployeeListJson() {
	    return service.getEngineerList();  // 직원 전체 리스트를 가져오는 서비스 메서드 필요
	}


	@GetMapping("/employee/register")
	public String form(Model model) {
		model.addAttribute("employee", new EmployeeVO());
		return "admin/employee/register";
	}

	@PostMapping("/employee/register")
	public String save(@ModelAttribute EmployeeVO employee) {
		service.insert(employee);
		return "redirect:/admin/employee/list";
	}
}

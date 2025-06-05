package com.management.as.controller;

import java.nio.charset.StandardCharsets;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
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
			return "redirect:/login?gubun=admin"; 
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
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		employee.setPassword(encoder.encode(employee.getPassword()));
		service.insert(employee);
		return "redirect:/admin/employee/list";
	}
	
	@PostMapping("/service/assignEngineer/{receiptNo}/{selectedEngineer}/{visitdate}/{visittime}")
	@ResponseBody
	//public ResponseEntity<?> assignEngineer(@RequestBody EmployeeVo employee) {
	public ResponseEntity<?> assignEngineer(@PathVariable("receiptNo") int receiptNo,
			@PathVariable("selectedEngineer") String selectedEngineer, @PathVariable("visitdate") String visitdate, @PathVariable("visittime") String visittime) {
	    try {
	    	//int receiptNo = (Integer) payload.get("receiptNo");
	        //int engineerNo = (Integer) payload.get("engineerNo");
	    	
	    	int count = service.assignCountCheck(selectedEngineer, visitdate, visittime);
	    	if(count == 0) {
	    		service.assignEngineer(receiptNo, selectedEngineer);
	    		return ResponseEntity.ok().build();
	    	} else {
	    		return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
	    				.contentType(new MediaType("text", "plain", StandardCharsets.UTF_8))
	    				.body("이미 배정된 시간입니다. 다시 선택해주세요.");
	    	}
	        //service.assignEngineer(Integer.parseInt(receiptNo), Integer.parseInt(selectedEngineer));  // 서비스 내에서 DB 업데이트 수행
	        
	    } catch (Exception e) {
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
	        		.contentType(new MediaType("text", "plain", StandardCharsets.UTF_8))
	        		.body("기사 배정 중 오류가 발생했습니다.");
	    }
	}

}


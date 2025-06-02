package com.management.as.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.management.as.domain.CustomerVO;
import com.management.as.service.YahooService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/admin/service/*")
public class YahooController {

    @Autowired
    private YahooService yahooService;

   
	/*
	 * public String index() { return "/admin/service/asindex"; }
	 */
    @GetMapping("/asindex")
    public String list(
        @RequestParam(value = "pageNum", defaultValue = "1") int page, // 이름을 맞추자
        @RequestParam(required = false) String type,
        @RequestParam(required = false) String keyword,
        @RequestParam(required = false) String status_keyword,
        HttpSession session,
        Model model,
        RedirectAttributes redirectAttributes
    ){
        int pageSize = 10;
        int totalCount = yahooService.totalCount(type, keyword, status_keyword);
        int totalPages = (int) Math.ceil((double) totalCount / pageSize);
        int offset = (page - 1) * pageSize;

        List<CustomerVO> list = yahooService.list(type, keyword, status_keyword, offset, pageSize);

        model.addAttribute("clist", list);
        model.addAttribute("type", type);
        model.addAttribute("keyword", keyword);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("status_keyword", status_keyword);

        return "/admin/service/asindex";
    }
}




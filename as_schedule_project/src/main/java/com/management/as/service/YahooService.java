package com.management.as.service;

import java.util.List;

import com.management.as.domain.CustomerVO;

public interface YahooService {
	
    List<CustomerVO> list(String type, String keyword, String status_keyword, int offset, int pageSize);
    int totalCount(String type, String keyword, String status_keyword);
}
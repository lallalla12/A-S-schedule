package com.management.as.service;

import java.util.List;

import com.management.as.domain.CustomerVO;
import com.management.as.domain.ProductVO;

public interface CustomerService {
	public List<ProductVO> productList();

	public void register(CustomerVO vo);

	public List<CustomerVO> list(String cname, String type, String keyword, String status_keyword, int offset, int pageSize);

	public int totalCount(String cname, String type, String keyword, String status_keyword);

	public CustomerVO get(int cnum);

	public void update(CustomerVO vo);
}

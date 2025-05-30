package com.management.as.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.management.as.domain.CustomerVO;
import com.management.as.domain.ProductVO;
import com.management.as.mapper.CustomerMapper;

@Service
public class CustomerServiceImpl implements CustomerService {
	
	@Autowired
	private CustomerMapper mapper;
	
	@Override
	public List<ProductVO> productList() {
		return mapper.productList();
	}

	@Override
	public void register(CustomerVO vo) {
		mapper.register(vo);
	}

	@Override
	public List<CustomerVO> list(String cname, String type, String keyword, String status_keyword, int offset, int pageSize) {
		return mapper.list(cname, type, keyword, status_keyword, offset, pageSize);
	}

	@Override
	public int totalCount(String cname, String type, String keyword, String status_keyword) {
		return mapper.totalCount(cname, type, keyword, status_keyword);
	}

	@Override
	public CustomerVO get(int cnum) {
		return mapper.get(cnum);
	}

	@Override
	public void update(CustomerVO vo) {
		mapper.update(vo);
	}
}

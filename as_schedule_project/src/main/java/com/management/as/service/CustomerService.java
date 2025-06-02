package com.management.as.service;

import java.time.LocalDate;
import java.util.List;

import com.management.as.domain.CustomerVO;
import com.management.as.domain.ProductVO;
import com.management.as.domain.UserVO;

public interface CustomerService {
	public List<ProductVO> productList();

	public void register(CustomerVO vo);

	public List<CustomerVO> list(String user_id, String type, String keyword, String status_keyword, int offset, int pageSize);

	public int totalCount(String user_id, String type, String keyword, String status_keyword);

	public CustomerVO get(int cnum);

	public void update(CustomerVO vo);

	public void join(UserVO vo);

	public UserVO findByUserId(String user_id);

	public int idCheck(String id);
	
	//enddate 업데이트
	public void updateEndDate(String username, LocalDate endDate);
}

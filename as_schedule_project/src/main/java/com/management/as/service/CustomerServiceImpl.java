package com.management.as.service;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.management.as.domain.CustomerVO;
import com.management.as.domain.ProductVO;
import com.management.as.domain.UserVO;
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
	public List<CustomerVO> list(String user_id, String type, String keyword, String status_keyword, int offset, int pageSize) {
		mapper.initRowNum();
		return mapper.list(user_id, type, keyword, status_keyword, offset, pageSize);
	}

	@Override
	public int totalCount(String user_id, String type, String keyword, String status_keyword) {
		return mapper.totalCount(user_id, type, keyword, status_keyword);
	}

	@Override
	public CustomerVO get(int cnum) {
		return mapper.get(cnum);
	}

	@Override
	public void update(CustomerVO vo) {
		mapper.update(vo);
	}

	@Override
	public void join(UserVO vo) {
		mapper.join(vo);
	}

	@Override
	public UserVO findByUserId(String user_id) {
		return mapper.findByUserId(user_id);
	}

	@Override
	public int idCheck(String id) {
		return mapper.idCheck(id);
	}

	@Override // enddate 업데이트
	public void updateEndDate(int cnum, LocalDate endDate, String cmt) {
		mapper.updateEndDate(cnum, endDate, cmt);
	}

	@Override
	public void detailUpdate(CustomerVO vo) {
		mapper.detailUpdate(vo);
	}

	@Override
	public List<CustomerVO> getReviewsByBoardId(String eno, int cnum) {
		// TODO Auto-generated method stub
		return mapper.getReviewsByBoardId(eno, cnum);
	}


	
}
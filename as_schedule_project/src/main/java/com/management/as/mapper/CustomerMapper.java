package com.management.as.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.management.as.domain.CustomerVO;
import com.management.as.domain.ProductVO;

public interface CustomerMapper {
	public List<ProductVO> productList();

	public void register(CustomerVO vo);

	public List<CustomerVO> list(@Param("cname") String cname, @Param("type") String type, @Param("keyword") String keyword, @Param("status_keyword") String status_keyword, @Param("offset") int offset, @Param("pageSize") int pageSize);

	public int totalCount(@Param("cname") String cname, @Param("type") String type, @Param("keyword") String keyword, @Param("status_keyword") String status_keyword);

	public CustomerVO get(@Param("cnum") int cnum);

	public void update(CustomerVO vo);
}

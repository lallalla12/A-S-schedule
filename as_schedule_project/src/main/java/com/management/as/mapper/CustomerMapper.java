package com.management.as.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.management.as.domain.CustomerVO;
import com.management.as.domain.ProductVO;
import com.management.as.domain.UserVO;

public interface CustomerMapper {
	public List<ProductVO> productList();

	public void register(CustomerVO vo);

	public List<CustomerVO> list(@Param("user_id") String user_id, @Param("type") String type, @Param("keyword") String keyword, @Param("status_keyword") String status_keyword, @Param("offset") int offset, @Param("pageSize") int pageSize);

	public int totalCount(@Param("user_id") String user_id, @Param("type") String type, @Param("keyword") String keyword, @Param("status_keyword") String status_keyword);

	public CustomerVO get(@Param("cnum") int cnum);

	public void update(CustomerVO vo);

	public void join(UserVO vo);

	public UserVO findByUserId(@Param("user_id") String user_id);

	public int idCheck(@Param("id") String id);

	public void initRowNum();
	
    // 게시글 목록 조회
    List<CustomerVO> alllist(
        @Param("type") String type,
        @Param("keyword") String keyword,
        @Param("status_keyword") String status_keyword,
        @Param("offset") int offset,
        @Param("pageSize") int pageSize);

    // 전체 게시글 수 조회
    int alltotalCount(
        @Param("type") String type,
        @Param("keyword") String keyword,
        @Param("status_keyword") String status_keyword);
}

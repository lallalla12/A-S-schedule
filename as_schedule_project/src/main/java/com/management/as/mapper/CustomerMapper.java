package com.management.as.mapper;

import java.time.LocalDate;
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
	
	//enddate 업데이트
	void updateEndDate(@Param("cnum") int cnum, @Param("endDate") LocalDate endDate);
	
    // 寃뚯떆湲� 紐⑸줉 議고쉶
    public List<CustomerVO> alllist(
        @Param("type") String type,
        @Param("keyword") String keyword,
        @Param("status_keyword") String status_keyword,
        @Param("offset") int offset,
        @Param("pageSize") int pageSize);

    // �쟾泥� 寃뚯떆湲� �닔 議고쉶
    public int alltotalCount(
        @Param("type") String type,
        @Param("keyword") String keyword,
        @Param("status_keyword") String status_keyword);
}

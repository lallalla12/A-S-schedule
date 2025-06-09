package com.management.as.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.management.as.domain.CustomerVO;
import com.management.as.domain.EmployeeVO;
import com.management.as.domain.ScheduleVO;

public interface EmployeeMapper {
	public List<ScheduleVO> getSchedule(String eno);

	public List<EmployeeVO> selectAll();

	public List<EmployeeVO> selectByKeyword(@Param("keyword") String keyword, @Param("type") String type);

	public void insert(EmployeeVO employee);

	public int getTotalCount(@Param("type") String type, @Param("keyword") String keyword);

	public List<EmployeeVO> getPagedListWithSearch(@Param("keyword") String keyword, @Param("type") String type, @Param("offset") int offset, @Param("size") int size);

	public EmployeeVO findById(String id);
	
	public List<EmployeeVO> getEngineerList();

	public int idCheck(@Param("id") String id);
	
	public void assignEngineer(@Param("receiptNo") int receiptNo, @Param("engineerNo") String engineerNo , @Param("status") String status);

	public int assignCountCheck(@Param("selectedEngineer") String selectedEngineer, @Param("visitdate") String visitdate, @Param("visittime") String visittime);

	public EmployeeVO getEmployeeById(String eno);

	public List<CustomerVO> selectCustomersByEmployeeId(@Param("eno") String eno);

	public List<CustomerVO> searchByEmployeeAndField(@Param("eno") String eno, @Param("searchField") String searchField, @Param("keyword") String keyword);

	public List<ScheduleVO> getASSchedule();
	
//    void updateProStatus(@Param("receiptNo") int receiptNo, @Param("status") String status);
	
	
    
	  
}

package com.management.as.service;

import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import com.management.as.domain.ScheduleVO;
import com.management.as.domain.CustomerVO;
import com.management.as.domain.EmployeeVO;

public interface EmployeeService {
	
	public List<ScheduleVO> getSchedule(String eno);
	
	public List<EmployeeVO> getAll();
	
	public void insert(EmployeeVO employee);

	public List<EmployeeVO> getAllWithSearch(String keyword, String type);

	public List<EmployeeVO> getPagedListWithSearch(String keyword, String type, int offset, int size);

	public int getTotalCount(String keyword, String type);

	EmployeeVO login(String id, String password);
	
	public List<EmployeeVO> getEngineerList();

	public int idCheck(String id);

	public EmployeeVO findById(String id);
	
	public void assignEngineer(int receiptNo, String engineerNo);

	public int assignCountCheck(String selectedEngineer, String visitdate, String visittime);

	public EmployeeVO getEmployeeById(String eno);

	public List<CustomerVO> getCustomerByEmployeeId(String eno); 
	 
}

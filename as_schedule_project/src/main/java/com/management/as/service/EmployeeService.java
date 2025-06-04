package com.management.as.service;

import java.util.List;

import com.management.as.domain.ScheduleVO;
import com.management.as.domain.EmployeeVO;

public interface EmployeeService {
	
	public List<ScheduleVO> getSchedule();
	
	public List<EmployeeVO> getAll();
	
	public void insert(EmployeeVO employee);

	public List<EmployeeVO> getAllWithSearch(String keyword, String type);

	public List<EmployeeVO> getPagedListWithSearch(String keyword, String type, int offset, int size);

	public int getTotalCount(String keyword, String type);

	EmployeeVO login(String id, String password);
	
	public List<EmployeeVO> getEngineerList();
	
	
	 
	
}

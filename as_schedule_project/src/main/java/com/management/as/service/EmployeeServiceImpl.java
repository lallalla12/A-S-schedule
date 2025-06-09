package com.management.as.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.management.as.domain.CustomerVO;
import com.management.as.domain.EmployeeVO;
import com.management.as.domain.ScheduleVO;
import com.management.as.mapper.EmployeeMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class EmployeeServiceImpl implements EmployeeService{
	@Setter(onMethod_ = @Autowired)
	private EmployeeMapper mapper;
	
	
	@Override
	public List<ScheduleVO> getSchedule(String eno) {
		// TODO Auto-generated method stub
		return mapper.getSchedule(eno);
	}
	
	// 목록 조회
	@Override
	public List<EmployeeVO> getAll() {
		// TODO Auto-generated method stub
		return mapper.selectAll();
	}
	
	// 등록
	@Override
	public void insert(EmployeeVO employee) {
		mapper.insert(employee);
		
	} 
	
	@Override
	public List<EmployeeVO> getAllWithSearch(String keyword, String type) {
	    if (keyword == null || keyword.trim().isEmpty()) {
	        return mapper.selectAll();
	    } else {
	        return mapper.selectByKeyword(keyword, type);
	    }
	}

	@Override
	public List<EmployeeVO> getPagedListWithSearch(String keyword, String type, int offset, int size) {
		// TODO Auto-generated method stub
		return mapper.getPagedListWithSearch(keyword,type,offset,size);
	}

	@Override
	public int getTotalCount(String keyword, String type) {
		// TODO Auto-generated method stub
		return mapper.getTotalCount(keyword,type);
	}

	@Override
	public EmployeeVO login(String id, String password) {
		EmployeeVO emp = mapper.findById(id);
        if (emp != null && emp.getPassword().equals(password)) {
            return emp;
        }
        return null;
	}
	
	public List<EmployeeVO> getEngineerList() {
        return mapper.getEngineerList();
	}

	@Override
	public int idCheck(String id) {
		return mapper.idCheck(id);
	}

	@Override
	public EmployeeVO findById(String id) {
		// TODO Auto-generated method stub
		return mapper.findById(id);
	}
	

	@Transactional
	@Override
	public void assignEngineer(int receiptNo, String engineerNo) {
	    mapper.assignEngineer(receiptNo, engineerNo, "P");
//	    mapper.updateProStatus(receiptNo, "P");
	}

	@Override
	public int assignCountCheck(String selectedEngineer, String visitdate, String visittime) {
		return mapper.assignCountCheck(selectedEngineer, visitdate, visittime);
	}

	@Override
	public EmployeeVO getEmployeeById(String eno) {
		// TODO Auto-generated method stub
		return mapper.getEmployeeById(eno);
	}

	@Override
	public List<CustomerVO> getCustomerByEmployeeId(String eno) {
		// TODO Auto-generated method stub
		return mapper.selectCustomersByEmployeeId(eno);
	}

	@Override
	public List<CustomerVO> searchByEmployeeAndField(String eno, String searchField, String keyword) {
		// TODO Auto-generated method stub
		return mapper.searchByEmployeeAndField(eno, searchField, keyword);
	}

	@Override
	public List<ScheduleVO> getASSchedule() {
		return mapper.getASSchedule();
	}

}

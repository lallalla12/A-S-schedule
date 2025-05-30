package com.management.as.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
	public List<ScheduleVO> getSchedule() {
		// TODO Auto-generated method stub
		return mapper.getSchedule();
	}

}

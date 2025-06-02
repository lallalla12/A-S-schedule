package com.management.as.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.management.as.domain.EmployeeVO;
import com.management.as.domain.ScheduleVO;

public interface EmployeeMapper {
	public List<ScheduleVO> getSchedule();

	public List<EmployeeVO> selectAll();

	public List<EmployeeVO> selectByKeyword(@Param("keyword") String keyword, @Param("type") String type);

	public void insert(EmployeeVO employee);

	public int getTotalCount(@Param("type") String type, @Param("keyword") String keyword);

	public List<EmployeeVO> getPagedListWithSearch(@Param("keyword") String keyword, @Param("type") String type, @Param("offset") int offset, @Param("size") int size);

}

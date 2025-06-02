package com.management.as.domain;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class EmployeeVO {
	private String eno;
	private String password;
	private String ename;
	private String ephone;
	@DateTimeFormat(pattern = "yyyy-MM-dd") 
	private Date hiredate;
	private String position;
	
}

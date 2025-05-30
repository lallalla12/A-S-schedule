package com.management.as.domain;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class CustomerVO {
	private int cnum;
	private String cname;
	private String cphone;
	private String address;
	private String unit;
	private String model;
	private String issue;
	private String detail;
	
	@DateTimeFormat(pattern = "yyyy-MM-dd") 
	private Date visitdate;
	
	private Date visitend;
	private int yn;
	private String prostatus;
	private int star;
	private Date regdate;
	private String proname;
	private String visittime;
	private String comment;
	
	private int rownum;
	
	/* 검색 조건 */
	private String type;
	private String keyword;
	
}

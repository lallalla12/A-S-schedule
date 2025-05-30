package com.management.as.domain;

import java.util.Date;

import lombok.Data;

@Data
public class ScheduleVO {
	private String cname;
	private String address;
	private String unit;
	
	private Date vistitdate;
	private Date visitend;
}

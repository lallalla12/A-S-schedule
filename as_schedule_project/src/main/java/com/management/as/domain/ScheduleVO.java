package com.management.as.domain;

import java.text.SimpleDateFormat;
import java.util.Date;

import lombok.Data;

@Data
public class ScheduleVO {
	private int cnum;
	private int star;
	private String comment;
	private String username;
	private String address;
	private String detail;
	private String prostatus;
	
	private Date visitdate;
	private String visittime;
	
	public String getVisitDateTime() {
		// 1. ��¥ ����: yyyy-MM-dd
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		String datePart = dateFormat.format(visitdate); // ��: "2025-06-12"

		// 2. ����
		return datePart + "T" + visittime + ":00"; // ��: "2025-06-12T13:00:00"
	}
}

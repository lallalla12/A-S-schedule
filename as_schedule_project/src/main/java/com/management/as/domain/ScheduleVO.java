package com.management.as.domain;

import java.text.SimpleDateFormat;
import java.util.Date;

import lombok.Data;

@Data
public class ScheduleVO {
	private int cnum;
	private String username;
	private String address;
	private String detail;
	
	private Date visitdate;
	private String visittime;
	
	public String getVisitDateTime() {
		// 1. 날짜 포맷: yyyy-MM-dd
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		String datePart = dateFormat.format(visitdate); // 예: "2025-06-12"

		// 2. 결합
		return datePart + "T" + visittime + ":00"; // 예: "2025-06-12T13:00:00"
	}
}

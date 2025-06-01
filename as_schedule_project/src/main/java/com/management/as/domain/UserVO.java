package com.management.as.domain;

import lombok.Data;

@Data
public class UserVO {
	private int uid;
	private String user_id;
	private String password;
	private String username;
	private String phone;
	private String address;
	private String detail;
}

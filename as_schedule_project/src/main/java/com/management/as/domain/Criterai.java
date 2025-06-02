package com.management.as.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Criterai {
	
	private int pageNum;		// 사용자가 클릭한 페이지 번호
	private int amount;			// 한 페이지당 게시물
	
	private String type;		// 어떤걸 기준으로 검색(type)
	private String keyword;		// 검색 키워드
	
	private String boardType; // 공지사항 타입(관리자, 기사 고객)
	
	
	
	public Criterai() {
		// pageNum = 1, amount = 10	
		this(1,10);	// 시작 초기값이 1번에 위치하며, 10개까지 보여주기
	}
	
	public Criterai(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
}

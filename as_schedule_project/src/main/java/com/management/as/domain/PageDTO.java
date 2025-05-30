package com.management.as.domain;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class PageDTO {
	
	private int startPage;
	private int endPage;
	private boolean prev,next;
	
	private int total;
	private Criterai cri;		// 검색 클래스
	
	public PageDTO(Criterai cri, int total) {
		
		this.cri = cri;
		this.total = total;
		
		// 1페이지일때 1 / 10 = 0.1 이 되는데 int 작업으로 1이됨 1 * 10 = 10 
		// 3페이지일때 3 / 10 = 0.3 이 되는데 int 작업으로 1이됨 1 * 10 = 10 (9페이지도 마찬가지)
		// 11페이지일땐 11 / 10 = 1.1이되며, int 작업으로 2가됨 2 * 10 = 20 (11 ~ 20이 보임)
		this.endPage = (int)(Math.ceil(cri.getPageNum() / 10.0)) * 10;
		
		
		this.startPage = this.endPage - 9;
		
		// 만약 토탈 123개의 게시물이 있다면 123 * 1 / 10 이 작업이되며 Math.ceil 은 무조건 +1
		// 123 * 1 = 123 / 10 = 12.3 형변환 int 로 소숫점이 떼지는데 Math.ceil 효과로 13이 됨
		int realEnd = (int)(Math.ceil((total * 1.0 / cri.getAmount())));
		
		if(realEnd < this.endPage) {
			this.endPage = realEnd;
		}
		
		this.prev = this.startPage > 1;
		
		this.next = this.endPage < realEnd;
	}
	
}

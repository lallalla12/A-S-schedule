package com.management.as.service;

import java.util.List;

import com.management.as.domain.ReplyVO;

public interface ReplyService {
	
	// 글쓰기를 위한 비즈니스 영역
	public void register(ReplyVO vo);
	
	// 댓글 목록리스트를 위한 비즈니스 영역
	public List<ReplyVO> list(long bno);
	
	// 댓글 수정을 위한 비즈니스 영역
	public void modify(ReplyVO vo);
	
	// 댓글 삭제를 위한 비즈니스 영역
	public void delete(long rno);
	
	
}

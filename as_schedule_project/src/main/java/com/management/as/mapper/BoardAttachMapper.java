package com.management.as.mapper;

import java.util.List;

import com.management.as.domain.BoardAttachVO;

public interface BoardAttachMapper {
	
	// 첨부파일에 대한 파일정보(파일업로드 경로, 파일명..등등)을 DB에 저장하기 위한 insert
	public void insert(BoardAttachVO vo);
	
	// 게시판에 첨부파일을 보여주기 위해 DB에 저장되어 있는 데이터를 웹브라우저로 가져오기 위한 select
	public List<BoardAttachVO> findByBno(int bno);
}

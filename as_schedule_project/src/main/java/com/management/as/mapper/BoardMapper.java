package com.management.as.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.management.as.domain.BoardVO;
import com.management.as.domain.Criterai;
public interface BoardMapper {
	
	// 게시판 리스트 목록 메소드(pageing 처리가 안되어 있는거)
	public List<BoardVO> list();	// VO 에 있는 열에다 넣어라.
	
	// 게시판 리스트 목록 메소드 (pageing 처리가 되어있는거)
	public List<BoardVO> getListWithPaging(Criterai cri);
	
	// tbl_board 테이블 전체 갯수
	public int getTotalCount(Criterai cri);
	
	// 목록 리스트에서 제목을 클릭하면 상세 내용 화면 이동
	public BoardVO read(int bno);

	// 목록 리스트에서 제목을 클릭하면 조회수 1 씩 증가.
	public void CountUpdate(int bno);
	
	// 게시판번호, 수정된 제목과 내용을 업데이트 하기 위한 mapper
	public void update(BoardVO board);
	
	// 게시판 삭제
	public void delete(int bno);
	
	// 글쓰기 버튼 클릭
	public void insert(BoardVO board);

	public void insertSelectKey(BoardVO board);
	
	
	void updateEngineerAssignment(@Param("eno") String eno, @Param("receiptNo") String receiptNo);
}



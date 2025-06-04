package com.management.as.service;


import java.util.List;

import com.management.as.domain.BoardVO;
import com.management.as.domain.Criterai;

public interface BoardService {		// 설계 클래쓰 -> BoardServiceImpl 구현
	
	// 게시판 리스트 목록 메소드(pageing 처리가 안되어 있는거)
	public List<BoardVO> list();	// VO 에 있는 열에다 넣어라.
	
	// 게시판 리스트 목록 메소드 (pageing 처리가 되어있는거)
	public List<BoardVO> getListWithPaging(Criterai cri);
	
	// tbl_board 테이블 전체 갯수
	public int getTotalCount(Criterai cri);
	
	// 목록 리스트에서 제목을 클릭하여 상세내용 화면으로 이동 메소드
	public BoardVO get(int bno);
	
	// 게시판 번호, 수정된 제목, 수정된 내용으로 업데이트를 하기 위한 controller
	public void modify(BoardVO board);
	
	// 게시판 삭제
	public void remove(int bno);
	
	// 게시판 글쓰기 버튼 클릭
	public void register(BoardVO board);
	
	// 기사님들 목록 불러오기
	public void assignEngineer(String eno, String receiptNo);
	
}

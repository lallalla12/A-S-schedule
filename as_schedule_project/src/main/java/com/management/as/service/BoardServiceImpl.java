package com.management.as.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.management.as.domain.BoardVO;
import com.management.as.domain.Criterai;
import com.management.as.mapper.BoardMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;


@Log4j
@Service
@AllArgsConstructor	// Autowired 를 대신해줍니다.(lombok)

public class BoardServiceImpl implements BoardService {	// 구현 하는 클래쓰 -> Mapper 의 메소드로 보냄
	
	private BoardMapper mapper;
	
	
	// paging 처리 X
	public List<BoardVO> list() {
		return mapper.list();
	}
	
	// paging 처리 O
	public List<BoardVO> getListWithPaging(Criterai cri){
		return mapper.getListWithPaging(cri);
	}
	
	// tbl_board 테이블 전체 갯수
	public int getTotalCount(Criterai cri) {
		return mapper.getTotalCount(cri);
	}
	
	// 목록 리스트에서 제목을 클릭하여 상세내용 화면으로 이동 메소드
	@Transactional
	public BoardVO get(int bno) {
		// 조회수를 1씩 증가하기 위한 DataBase 작업
		//mapper.CountUpdate(bno);
		// 제목을 클릭하면 상세내용을 select 하기 위한 DataBase 작업
		return mapper.read(bno);
	}
	
	// 게시판번호, 수정된 제목과 내용을 업데이트 구현
	public void modify(BoardVO board) {
		mapper.update(board);
	}
	
	// 게시판 삭제
	public void remove(int bno) {
		mapper.delete(bno);
	}
	
	@Transactional
	// 글쓰기 
	public void register(BoardVO board) {
		// tbl_board 테이블에 insert
		mapper.insertSelectKey(board);
	}

	@Override
	public void assignEngineer(String eno, String receiptNo) {
	    mapper.updateEngineerAssignment(eno, receiptNo);
	} 
}

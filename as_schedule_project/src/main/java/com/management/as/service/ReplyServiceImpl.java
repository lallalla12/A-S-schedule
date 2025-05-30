package com.management.as.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.management.as.domain.BoardVO;
import com.management.as.domain.ReplyVO;
import com.management.as.mapper.ReplyMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;


@Service
@Log4j
public class ReplyServiceImpl implements ReplyService {
	
	@Setter(onMethod_=@Autowired)
	private ReplyMapper mapper;
	
	// 글쓰기를 위한 비즈니스 영역
	public void register(ReplyVO vo) {
		mapper.insert(vo);
		
	}
	
	// 댓글 목록리스트를 위한 비즈니스 영역
	public List<ReplyVO> list(long bno) {
		return mapper.list(bno);
	}
	
	// 댓글 수정을 위한 비즈니스 영역
	public void modify(ReplyVO vo) {
		mapper.update(vo);
	}
	
	// 댓글 삭제를 위한 비즈니스 영역
	public void delete(long rno) {
		mapper.delete(rno);
	}
	
}

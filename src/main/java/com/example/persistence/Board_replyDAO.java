package com.example.persistence;

import java.util.List;

import com.example.domain.Board_replyVO;

public interface Board_replyDAO {
	public List<Board_replyVO> rlist(int board_bno) throws Exception;
	public int totalCount(int board_bno) throws Exception;
	public void insert(Board_replyVO vo) throws Exception;
	public void delete(int board_rno) throws Exception;
	public Board_replyVO read(int board_rno) throws Exception;
}

package com.example.service;

import com.example.domain.Board_replyVO;

public interface Board_replyService {
	public void insert(Board_replyVO vo) throws Exception;
	public void delete(int board_rno) throws Exception;
}

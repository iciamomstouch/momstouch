package com.example.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.domain.Board_replyVO;
import com.example.persistence.BoardDAO;
import com.example.persistence.Board_replyDAO;

@Service
public class Board_replyServiceImpl implements Board_replyService{
	@Autowired
	BoardDAO dao;
	
	@Autowired
	Board_replyDAO rdao;
	
	@Transactional
	@Override
	public void insert(Board_replyVO vo) throws Exception {
		dao.updateReply(vo.getBoard_bno(), 1);
		rdao.insert(vo);
		
	}
	
	@Transactional
	@Override
	public void delete(int board_rno) throws Exception {
		Board_replyVO vo = rdao.read(board_rno);
		dao.updateReply(vo.getBoard_bno(), -1);	
		rdao.delete(board_rno);
			
	}

}

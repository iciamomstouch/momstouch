package com.example.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.domain.BoardVO;
import com.example.persistence.BoardDAO;

@Service
public class BoardServiceImpl implements BoardService{
	
	@Autowired
	BoardDAO dao;
	
	@Transactional
	@Override
	public BoardVO read(int board_bno) throws Exception {
		dao.updateViewCnt(board_bno);
		BoardVO vo = dao.read(board_bno);		
		return vo;
	}

}

package com.example.service;

import com.example.domain.BoardVO;

public interface BoardService {
	public BoardVO read(int board_bno) throws Exception;	
}

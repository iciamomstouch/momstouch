package com.example.persistence;

import java.util.List;

import com.example.domain.Board_replyVO;
import com.example.domain.Recipe_replyVO;

public interface Board_replyDAO {
	public List<Board_replyVO> rlist(int board_bno) throws Exception;
}

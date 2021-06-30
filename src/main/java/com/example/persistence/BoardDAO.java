package com.example.persistence;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.example.domain.BoardVO;
import com.example.domain.Criteria;


public interface BoardDAO {
	public List<BoardVO> list(Criteria cri) throws Exception;
	public int totalCount(Criteria cri) throws Exception;
	public void insert(BoardVO vo) throws Exception;
	public BoardVO read(int board_bno) throws Exception;
	public void delete(int board_bno) throws Exception;
	public void update(BoardVO vo) throws Exception;
	public void updateViewCnt(int board_bno);
	public void updateReply(@Param("board_bno")int board_bno, @Param("amount") int amount);
	public List<BoardVO> ulist(@Param("pageStart")int pageStart, @Param("perPageNum")int perPageNum, @Param("board_writer")String board_writer) throws Exception;
	
}

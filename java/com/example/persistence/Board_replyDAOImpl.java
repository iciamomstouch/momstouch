package com.example.persistence;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.domain.Board_replyVO;

@Repository
public class Board_replyDAOImpl implements Board_replyDAO{
	String namespace="com.example.mapper.Board_replyMapper";
	
	@Autowired
	SqlSession session;

	@Override
	public List<Board_replyVO> rlist(int board_bno) throws Exception {		
		return session.selectList(namespace + ".rlist", board_bno);
	}

	@Override
	public int totalCount(int board_bno) throws Exception {		
		return session.selectOne(namespace + ".totalCount", board_bno);
	}

	@Override
	public void insert(Board_replyVO vo) throws Exception {
		session.insert(namespace + ".insert", vo);		
	}

	@Override
	public void delete(int board_rno) throws Exception {
		session.delete(namespace + ".delete", board_rno);		
	}

	@Override
	public Board_replyVO read(int board_rno) throws Exception {		
		return session.selectOne(namespace + ".read", board_rno);
	}

	@Override
	public List<Board_replyVO> ulist(String board_replyer) throws Exception {
		return session.selectList(namespace + ".ulist", board_replyer);
	}
}

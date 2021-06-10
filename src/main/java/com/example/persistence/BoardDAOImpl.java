package com.example.persistence;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.domain.BoardVO;
import com.example.domain.Criteria;



@Repository
public class BoardDAOImpl implements BoardDAO{
	String namespace="com.example.mapper.BoardMapper";
	@Autowired
	SqlSession session;
	
	@Override
	public List<BoardVO> list(Criteria cri) throws Exception {
		
		return  session.selectList(namespace+ ".list", cri);
	}

	@Override
	public void insert(BoardVO vo) throws Exception {
		session.insert(namespace + ".insert", vo);
		
	}

	@Override
	public BoardVO read(int board_bno) throws Exception {
		
		 return session.selectOne(namespace + ".read",board_bno);
	}
	
	
	@Override
	public void delete(int board_bno) throws Exception {
		session.delete(namespace + ".delete", board_bno);
		
	}

	@Override
	public void update(BoardVO vo) throws Exception {
		session.update(namespace + ".update", vo);
		
	}

	@Override
	public void updateViewCnt(int board_bno) {
		session.update(namespace + ".updateViewCnt", board_bno);
		
	}

	
	
	

	
}

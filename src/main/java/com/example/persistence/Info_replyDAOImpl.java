package com.example.persistence;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.domain.Info_replyVO;

@Repository
public class Info_replyDAOImpl implements Info_replyDAO{
	String namespace="com.example.mapper.Info_replyMapper";
	
	@Autowired
	SqlSession session;

	@Override
	public List<Info_replyVO> rlist(int info_bno) throws Exception {		
		return session.selectList(namespace + ".rlist", info_bno);
	}

	@Override
	public int totalCount(int info_bno) throws Exception {		
		return session.selectOne(namespace + ".totalCount", info_bno);
	}

	@Override
	public void insert(Info_replyVO vo) throws Exception {
		session.insert(namespace + ".insert", vo);		
	}

	@Override
	public void delete(int info_rno) throws Exception {
		session.delete(namespace + ".delete", info_rno);		
	}

	@Override
	public Info_replyVO read(int info_rno) throws Exception {		
		return session.selectOne(namespace + ".read", info_rno);
	}

	@Override
	public List<Info_replyVO> ulist(String info_replyer) throws Exception {		
		return session.selectList(namespace + ".ulist", info_replyer);
	}

}

package com.example.persistence;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.domain.Criteria;
import com.example.domain.InfoVO;

@Repository
public class InfoDAOImpl implements InfoDAO{
	String namespace="com.example.mapper.InfoMapper";
	
	@Autowired
	SqlSession session;
	
	@Override
	public List<InfoVO> list(Criteria cri) throws Exception {
		return  session.selectList(namespace+ ".list", cri);
	}
	
	@Override
	public void insert(InfoVO vo) throws Exception {
		session.insert(namespace + ".insert", vo);
		
	}
	
	@Override
	public InfoVO read(int info_bno) throws Exception {		
		return session.selectOne(namespace+ ".read", info_bno);
	}
	
	@Override
	public void delete(int info_bno) throws Exception {
		session.insert(namespace + ".delete", info_bno);
		
	}
	
	@Override
	public void update(InfoVO vo) throws Exception {
		session.insert(namespace + ".update", vo);		
	}
	
	@Override
	public void updateViewCnt(int info_bno) {
		session.update(namespace + ".updateViewCnt", info_bno);
	}
	@Override
	public int totalCount(Criteria cri) throws Exception {		
		return session.selectOne(namespace + ".totalCount", cri);
	}

	@Override
	public void updateReply(int info_bno, int amount) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("info_bno", info_bno);
		map.put("amount", amount);
		session.update(namespace + ".updateReply", map);		
	}
	

	
	
	

	
}

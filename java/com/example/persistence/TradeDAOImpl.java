package com.example.persistence;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.domain.Criteria;
import com.example.domain.TradeVO;
import com.example.domain.Trade_attachVO;
import com.example.domain.User_keepVO;

@Repository
public class TradeDAOImpl implements TradeDAO{
	String namespace="com.example.mapper.TradeMapper";
	
	@Autowired
	SqlSession session;
	
	@Override
	public List<TradeVO> list(Criteria cri) throws Exception {
		return session.selectList(namespace + ".list",cri);
	}
	
	@Override
	public int totalCount(Criteria cri) throws Exception {
		return session.selectOne(namespace + ".totalCount", cri);
	}
	
	@Override
	public TradeVO read(int trade_bno) throws Exception {
		return session.selectOne(namespace + ".read", trade_bno);
	}

	@Override
	public void insert(TradeVO vo) throws Exception {
		session.insert(namespace + ".insert",vo);
	}

	@Override
	public void delete(int trade_bno) throws Exception {
		session.delete(namespace + ".delete",trade_bno);
		
	}

	@Override
	public void update(TradeVO vo) throws Exception {
		session.update(namespace + ".update",vo);
		
	}

	@Override
	public List<Trade_attachVO> getAttach(int trade_bno) throws Exception {
		return session.selectList(namespace + ".getAttach", trade_bno);
	}

	@Override
	public void addAttach(String trade_attach_image, int trade_bno) throws Exception {
		HashMap<String,Object> map = new HashMap<>();
		map.put("trade_attach_image", trade_attach_image);
		map.put("trade_bno", trade_bno);
		session.insert(namespace + ".addAttach", map);
		
	}

	@Override
	public void updateViewcnt(int trade_bno) throws Exception {
		session.update(namespace + ".updateViewcnt", trade_bno);
		
	}

	@Override
	public int lastBno() throws Exception {		
		return session.selectOne(namespace + ".lastBno");
	}

	@Override
	public List<User_keepVO> keep(int trade_bno) throws Exception {
		return session.selectList(namespace + ".keep", trade_bno);
	}



}

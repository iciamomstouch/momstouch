package com.example.persistence;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.domain.ChatVO;
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
	public void delAttach(int trade_bno) throws Exception {
		session.delete(namespace + ".delAttach", trade_bno);		
	}

	@Override
	public void delAttach2(String trade_attach_image) throws Exception {		
		session.delete(namespace + ".delAttach2", trade_attach_image);
	}

	@Override
	public List<TradeVO> ulist(int pageStart, int perPageNum, String trade_writer) throws Exception {
		HashMap<String, Object> map = new HashMap<>();
		map.put("pageStart", pageStart);
		map.put("perPageNum", perPageNum);
		map.put("trade_writer", trade_writer);		
		return session.selectList(namespace + ".ulist", map);
	}

	@Override
	public User_keepVO keepRead(int trade_bno, String user_id) throws Exception {
		HashMap<String, Object> map = new HashMap<>();
		map.put("trade_bno", trade_bno);
		map.put("user_id", user_id);
		return session.selectOne(namespace + ".keepRead", map);
	}

	@Override
	public void keepInsert(User_keepVO vo) throws Exception {
		session.insert(namespace + ".keepInsert", vo);
	}

	@Override
	public void keepUpdate(User_keepVO vo) throws Exception {
		session.update(namespace + ".keepUpdate", vo);
	}

	@Override
	public List<TradeVO> klist(int pageStart, int perPageNum, String user_id) throws Exception {
		HashMap<String, Object> map = new HashMap<>();
		map.put("pageStart", pageStart);
		map.put("perPageNum", perPageNum);
		map.put("user_id", user_id);		
		return session.selectList(namespace + ".klist", map);
	}

	@Override
	public String nextNum(int trade_bno) throws Exception {
		return session.selectOne(namespace + ".nextNum", trade_bno);
	}

	@Override
	public String preNum(int trade_bno) throws Exception {
		return session.selectOne(namespace + ".preNum", trade_bno);
	}

	@Override
	public String maxNum() throws Exception {
		return session.selectOne(namespace + ".maxNum");
	}

	@Override
	public String minNum() throws Exception {
		return session.selectOne(namespace + ".minNum");
	}

	@Override
	public List<ChatVO> clist(String user_id) throws Exception {
		return session.selectList(namespace + ".clist", user_id);
	}
}

package com.example.persistence;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.domain.Criteria;
import com.example.domain.QuestionVO;

@Repository
public class QuestionDAOImpl implements QuestionDAO{
	String namespace="com.example.mapper.QuestionMapper";
	
	@Autowired
	SqlSession session;

	@Override
	public List<QuestionVO> list(Criteria cri) throws Exception {	
		return session.selectList(namespace + ".list", cri);
	}

	@Override
	public int totalCount(Criteria cri) throws Exception {		
		return session.selectOne(namespace + ".totalCount", cri);
	}

	@Override
	public void insert(QuestionVO vo) throws Exception {
		session.insert(namespace + ".insert", vo);
		
	}

	@Override
	public QuestionVO read(int question_bno) throws Exception {		
		return session.selectOne(namespace + ".read", question_bno);
	}

	@Override
	public void update(QuestionVO vo) throws Exception {
		session.update(namespace + ".update", vo);		
	}

	@Override
	public void delete(int question_bno) throws Exception {
		session.delete(namespace + ".delete", question_bno);
	}

	@Override
	public int lastBno() throws Exception {		
		return session.selectOne(namespace + ".lastBno");
	}

	@Override
	public void insert2(QuestionVO vo) throws Exception {
		session.insert(namespace + ".insert2", vo);
	}

	@Override
	public void updateViewCnt(int question_bno) throws Exception {
		session.update(namespace + ".updateViewCnt", question_bno);
	}

	@Override
	public List<QuestionVO> ulist(int pageStart, int perPageNum, String question_writer) throws Exception {
		HashMap<String, Object> map = new HashMap<>();
		map.put("pageStart", pageStart);
		map.put("perPageNum", perPageNum);
		map.put("question_writer", question_writer);		
		return session.selectList(namespace + ".ulist", map);
	}

}

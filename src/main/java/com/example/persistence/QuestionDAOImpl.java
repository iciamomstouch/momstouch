package com.example.persistence;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.domain.QuestionVO;

@Repository
public class QuestionDAOImpl implements QuestionDAO{
	String namespace="com.example.mapper.QuestionMapper";
	
	@Autowired
	SqlSession session;

	@Override
	public List<QuestionVO> list() throws Exception {	
		return session.selectList(namespace + ".list");
	}

	@Override
	public int totalCount() throws Exception {		
		return session.selectOne(namespace + ".totalCount");
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

}

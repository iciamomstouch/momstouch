package com.example.persistence;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.domain.Criteria;
import com.example.domain.QuestionReplyVO;

@Repository
public class QuestionReplyDAOImpl implements QuestionReplyDAO{
	String namespace="com.example.mapper.QuestionReplyMapper";
	
	@Autowired
	SqlSession session;

	@Override
	public List<QuestionReplyVO> list(int question_bno) {		
		return session.selectList(namespace + ".list", question_bno);
	}

	@Override
	public void insert(QuestionReplyVO vo) {
		session.insert(namespace + ".insert", vo);		
	}

	@Override
	public QuestionReplyVO read(int question_rno) {		
		return session.selectOne(namespace + ".read", question_rno);
	}

	@Override
	public void delete(int question_rno) {
		session.delete(namespace + ".delete", question_rno);
	}

	@Override
	public void update(QuestionReplyVO vo) {
		session.update(namespace + ".update", vo);		
	}

}

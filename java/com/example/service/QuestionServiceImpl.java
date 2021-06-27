package com.example.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.domain.QuestionVO;
import com.example.persistence.QuestionDAO;

@Service
public class QuestionServiceImpl implements QuestionService{
	
	@Autowired
	QuestionDAO dao;
	
	@Transactional
	@Override
	public QuestionVO read(int question_bno) throws Exception {
		dao.updateViewCnt(question_bno);
		QuestionVO vo = dao.read(question_bno);		
		return vo;
	}

}

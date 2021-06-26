package com.example.service;

import com.example.domain.QuestionVO;

public interface QuestionService {
	public QuestionVO read(int question_bno) throws Exception;	
}

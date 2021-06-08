package com.example.mapper;

import java.util.List;

import com.example.domain.QuestionVO;

public interface QuestionMapper {
	public List<QuestionVO> list();
	public int totalCount(); 
	 public void insert(QuestionVO vo);
	 public QuestionVO read(int qbno);
	 public void update(QuestionVO vo);
	 public void delete(int qbno); 
}

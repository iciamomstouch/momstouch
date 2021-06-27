package com.example.persistence;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.example.domain.Criteria;
import com.example.domain.QuestionReplyVO;

public interface QuestionReplyDAO {
	public List<QuestionReplyVO> list(int question_bno);
	 public void insert(QuestionReplyVO vo);
	 public QuestionReplyVO read(int question_rno);
	 public void delete(int question_rno);
	 public void update(QuestionReplyVO vo);
}

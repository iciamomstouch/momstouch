package com.example.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.example.domain.Criteria;
import com.example.domain.QuestionReplyVO;

public interface QuestionReplyMapper {
	public interface ReplyMapper {
		 public List<QuestionReplyVO> list(@Param("cri") Criteria cri, @Param("question_bno") int question_bno);
		 public void insert(QuestionReplyVO vo);
		 public QuestionReplyVO read(int question_rno);
		 public void delete(int question_rno);
		 public void update(QuestionReplyVO question_vo);
		}

}

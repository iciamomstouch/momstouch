package com.example.persistence;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.example.domain.Criteria;
import com.example.domain.QuestionVO;

public interface QuestionDAO {
	public List<QuestionVO> list(Criteria cri) throws Exception;
	public int totalCount(Criteria cri) throws Exception;
	public void insert(QuestionVO vo) throws Exception;
	public void insert2(QuestionVO vo) throws Exception;
	public QuestionVO read(int question_bno) throws Exception;
	public void update(QuestionVO vo) throws Exception;
	public void delete(int question_bno) throws Exception;
	public void updateViewCnt(int question_bno) throws Exception;
	public int lastBno() throws Exception;
	public List<QuestionVO> ulist(@Param("pageStart")int pageStart, @Param("perPageNum")int perPageNum, @Param("question_writer")String question_writer) throws Exception;
	public List<QuestionVO> grpList(int question_grpno) throws Exception;
}

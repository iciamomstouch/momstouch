package com.example.service;

import com.example.domain.Recipe_replyVO;

public interface Recipe_replyService {
	public void insert(Recipe_replyVO vo) throws Exception;
	public void delete(int recipe_rno) throws Exception;
}

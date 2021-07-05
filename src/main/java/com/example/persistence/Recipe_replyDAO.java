package com.example.persistence;

import java.util.List;

import com.example.domain.Recipe_replyVO;

public interface Recipe_replyDAO {
	public List<Recipe_replyVO> rlist(int recipe_bno) throws Exception;
	public void insert(Recipe_replyVO vo) throws Exception;
	public void delete(int recipe_rno) throws Exception;
	public void deleteAll(int recipe_bno) throws Exception;
	public Recipe_replyVO read(int recipe_rno) throws Exception;
	public List<Recipe_replyVO> ulist(String recipe_replyer) throws Exception;
}

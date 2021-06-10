package com.example.persistence;

import java.util.List;

import com.example.domain.Recipe_replyVO;

public interface Recipe_replyDAO {
	public List<Recipe_replyVO> rlist(int recipe_bno) throws Exception;
}

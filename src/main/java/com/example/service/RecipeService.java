package com.example.service;

import com.example.domain.RecipeVO;

public interface RecipeService {
	public RecipeVO read(int recipe_bno) throws Exception;
	public void insert(RecipeVO vo) throws Exception;
	public void update(RecipeVO vo) throws Exception;
}

package com.example.persistence;

import java.util.List;

import com.example.domain.Criteria;
import com.example.domain.RecipeVO;
import com.example.domain.Recipe_attachVO;

public interface RecipeDAO {
	public List<RecipeVO> list(Criteria cri) throws Exception;
	public int totalCount() throws Exception;
	public RecipeVO read(int recipe_bno) throws Exception;
	public void insert(RecipeVO vo) throws Exception;
	public void update(RecipeVO vo) throws Exception;
	public void delete(int recipe_bno) throws Exception;
	public List<Recipe_attachVO> getAttach(int recipe_bno) throws Exception;
}

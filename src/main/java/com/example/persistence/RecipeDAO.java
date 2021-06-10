package com.example.persistence;

import java.util.List;

import com.example.domain.Criteria;
import com.example.domain.RecipeVO;

public interface RecipeDAO {
	public List<RecipeVO> list(Criteria cri) throws Exception;
	public int totalCount() throws Exception;
}

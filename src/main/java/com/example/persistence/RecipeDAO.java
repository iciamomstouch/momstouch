package com.example.persistence;

import java.util.List;

import org.apache.ibatis.annotations.Param;

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
	public void updateViewcnt(int recipe_bno) throws Exception;
	public void addAttach(@Param("recipe_image") String recipe_attach_image, @Param("recipe_bno") int recipe_bno) throws Exception;
	public int lastBno() throws Exception;
}

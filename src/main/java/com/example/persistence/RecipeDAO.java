package com.example.persistence;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.example.domain.Criteria;
import com.example.domain.RecipeVO;
import com.example.domain.Recipe_attachVO;

public interface RecipeDAO {
	public List<RecipeVO> list(Criteria cri) throws Exception;
	public int totalCount(Criteria cri) throws Exception;
	public RecipeVO read(int recipe_bno) throws Exception;
	public void insert(RecipeVO vo) throws Exception;
	public void update(RecipeVO vo) throws Exception;
	public void delete(int recipe_bno) throws Exception;
	public List<Recipe_attachVO> getAttach(int recipe_bno) throws Exception;
	public void updateViewcnt(int recipe_bno) throws Exception;
	public void addAttach(@Param("recipe_attach_no") String recipe_attach_no, @Param("recipe_attach_image") String recipe_attach_image, @Param("recipe_attach_text") String recipe_attach_text, @Param("recipe_bno") int recipe_bno)throws Exception;
	public void addAttach2(Recipe_attachVO attachVO) throws Exception;
	public int lastBno() throws Exception;
	public void updateReply(int recipe_bno, int recipe_rno) throws Exception;
	public void delAttach(int recipe_bno) throws Exception;
	public void delAttach2(@Param("recipe_bno") int recipe_bno, @Param("recipe_attach_no") int recipe_attach_no) throws Exception;
	public void updateUserRating(int recipe_bno) throws Exception;
}

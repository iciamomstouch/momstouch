package com.example.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.domain.Recipe_replyVO;
import com.example.persistence.RecipeDAO;
import com.example.persistence.Recipe_replyDAO;

@Service
public class Recipe_replyServiceImpl implements Recipe_replyService{
	@Autowired
	RecipeDAO dao1;
	
	@Autowired
	Recipe_replyDAO dao2;
	
	@Transactional
	@Override
	public void insert(Recipe_replyVO vo) throws Exception {
		dao2.insert(vo);
		//dao1.updateReply(vo.getRecipe_bno(), 1);		
	}
	
	@Transactional
	@Override
	public void delete(int recipe_rno) throws Exception {
		Recipe_replyVO vo=dao2.read(recipe_rno);
		//dao1.updateReply(vo.getRecipe_bno(), -1);
		dao2.delete(recipe_rno);
		
	}
	

}

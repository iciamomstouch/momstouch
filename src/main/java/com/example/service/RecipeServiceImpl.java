package com.example.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import com.example.domain.RecipeVO;
import com.example.domain.TradeVO;
import com.example.persistence.RecipeDAO;
import com.example.persistence.TradeDAO;

@Service
public class RecipeServiceImpl implements RecipeService {
	@Autowired
	RecipeDAO dao;
	
	@Transactional
	@Override
	public RecipeVO read(int recipe_bno) throws Exception {
		RecipeVO vo = dao.read(recipe_bno);
		dao.updateViewcnt(recipe_bno);
		return vo;

	}
	
	@Transactional
	@Override
	public void insert(RecipeVO vo) throws Exception {
		dao.insert(vo);
		System.out.println(vo.toString());
		ArrayList<String> images = vo.getImages();
		if(images==null) return;
		for(String image:images){
			dao.addAttach(image, vo.getRecipe_bno());
		   }
	}
}

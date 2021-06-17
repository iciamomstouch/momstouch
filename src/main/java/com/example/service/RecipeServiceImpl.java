package com.example.service;

import java.util.ArrayList;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import com.example.domain.RecipeVO;
import com.example.persistence.RecipeDAO;


@Service
public class RecipeServiceImpl implements RecipeService {
	@Autowired
	RecipeDAO dao;
	
	@Resource(name="uploadPath")
	String path;
	
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

	@Override
	public void update(RecipeVO vo) throws Exception {
		dao.update(vo);
		ArrayList<String> images = vo.getImages();
		if(images==null) return;
		for(String image:images){
			dao.addAttach(image, vo.getRecipe_bno());
		}
		
	}
}

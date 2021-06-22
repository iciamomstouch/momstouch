package com.example.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.domain.RecipeVO;
import com.example.domain.Recipe_attachVO;
import com.example.persistence.RecipeDAO;

@Service
public class RecipeServiceImpl implements RecipeService {
	@Autowired
	RecipeDAO dao;	
	
	@Transactional
	@Override
	public RecipeVO read(int recipe_bno) throws Exception {
		dao.updateViewcnt(recipe_bno);
		RecipeVO vo = dao.read(recipe_bno);		
		return vo;
	}
	
	@Transactional
	@Override
	public void insert(RecipeVO vo) throws Exception {
		dao.insert(vo);
		
		ArrayList<HashMap<String, Object>> testList = new ArrayList<>();
		ArrayList<String> noList = vo.getRecipe_attach_no();
		ArrayList<String> imageList = vo.getImages();
		ArrayList<String> textList = vo.getRecipe_attach_text();
		for(int i=0;i<noList.size();i++){
			HashMap<String, Object> map1 = new HashMap<String, Object>();
			map1.put("recipe_attach_no", noList.get(i));
			map1.put("recipe_attach_image", imageList.get(i));
			map1.put("recipe_attach_text", textList.get(i));
			testList.add(map1);
		}
				
		System.out.println(testList.toString());
		if(testList==null) return;
		for(HashMap<String, Object> map:testList){
			Recipe_attachVO attachVO = new Recipe_attachVO();
			attachVO.setRecipe_attach_no((String) map.get("recipe_attach_no"));
			attachVO.setRecipe_attach_image((String) map.get("recipe_attach_image"));
			attachVO.setRecipe_attach_text((String) map.get("recipe_attach_text"));
			dao.addAttach(attachVO.getRecipe_attach_no(), attachVO.getRecipe_attach_image(), attachVO.getRecipe_attach_text(), vo.getRecipe_bno());
		   }
	}
	
	@Transactional
	@Override
	public void update(RecipeVO vo) throws Exception {
		dao.update(vo);
		ArrayList<String> images = vo.getImages();
		if(images==null) return;
		for(String image:images){
			//dao.addAttach(image, vo.getRecipe_bno());
		}
		
	}
	
	@Transactional
	@Override
	public void delete(int recipe_bno) throws Exception {
		dao.delAttach(recipe_bno);
		dao.delete(recipe_bno);		
	}
}

package com.example.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.domain.RecipeVO;
import com.example.domain.Recipe_attachVO;
import com.example.persistence.RecipeDAO;
import com.example.persistence.Recipe_replyDAO;

@Service
public class RecipeServiceImpl implements RecipeService {
	@Autowired
	RecipeDAO dao;
	
	@Autowired
	Recipe_replyDAO rdao;
	
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
			map1.put("recipe_bno", vo.getRecipe_bno());
			testList.add(map1);
		}
				
		System.out.println(testList.toString());
		
		for(HashMap<String, Object> map:testList){
			Recipe_attachVO attachVO = new Recipe_attachVO();
			attachVO.setRecipe_attach_no(Integer.valueOf(((String) map.get("recipe_attach_no"))));
			attachVO.setRecipe_attach_image((String) map.get("recipe_attach_image"));
			attachVO.setRecipe_attach_text((String) map.get("recipe_attach_text"));
			attachVO.setRecipe_bno((int) map.get("recipe_bno"));
			dao.addAttach(attachVO);
		   }
	}
	
	@Transactional
	@Override
	public void update(RecipeVO vo) throws Exception {
		dao.update(vo);
		ArrayList<HashMap<String, Object>> testList = new ArrayList<>();
		ArrayList<String> noList = vo.getRecipe_attach_no();
		ArrayList<String> imageList = vo.getImages();
		ArrayList<String> textList = vo.getRecipe_attach_text();
		for(int i=0;i<noList.size();i++){
			HashMap<String, Object> map1 = new HashMap<String, Object>();
			map1.put("recipe_attach_no", noList.get(i));
			map1.put("recipe_attach_image", imageList.get(i));
			map1.put("recipe_attach_text", textList.get(i));
			map1.put("recipe_bno", vo.getRecipe_bno());
			testList.add(map1);
		}
				
		System.out.println(testList.toString());
		
		for(HashMap<String, Object> map:testList){
			Recipe_attachVO attachVO = new Recipe_attachVO();
			attachVO.setRecipe_attach_no(Integer.valueOf(((String) map.get("recipe_attach_no"))));
			attachVO.setRecipe_attach_image((String) map.get("recipe_attach_image"));
			attachVO.setRecipe_attach_text((String) map.get("recipe_attach_text"));
			attachVO.setRecipe_bno((int) map.get("recipe_bno"));
			dao.addAttach(attachVO);
		   }
	}
	
	@Transactional
	@Override
	public void delete(int recipe_bno) throws Exception {
		dao.delAttach(recipe_bno);
		rdao.deleteAll(recipe_bno);
		dao.delete(recipe_bno);		
	}
}

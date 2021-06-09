package com.example.controller;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.domain.Criteria;
import com.example.domain.PageMaker;
import com.example.domain.RecipeVO;
import com.example.domain.Recipe_attachVO;
import com.example.persistence.RecipeDAO;
import com.example.persistence.UserDAO;

@Controller
@RequestMapping("/recipe/")
public class RecipeController {
	@Autowired
	RecipeDAO dao;
	
	@Resource(name="uploadPath")
	String path;
	
	@RequestMapping("list")
	public String list(Model model, Criteria cri) throws Exception{
		cri.setPerPageNum(5);
		
		PageMaker pm = new PageMaker();
		pm.setCri(cri);
		pm.setTotalCount(dao.totalCount());
		
		model.addAttribute("pm", pm);
		model.addAttribute("cri", cri);
		model.addAttribute("list", dao.list(cri));
		model.addAttribute("pageName", "recipe/list.jsp");
		return "index";
	}
	
	@RequestMapping("read")
	public String read(Model model, int recipe_bno) throws Exception{
		model.addAttribute("vo", dao.read(recipe_bno));
		//model.addAttribute("v", dao.getAttach(recipe_bno));
		model.addAttribute("pageName", "recipe/read.jsp");
		return "index";
	}
	
	@RequestMapping("insert")
	public void insert(){}
	

	@RequestMapping("getAttach.json")
	@ResponseBody
	public HashMap<String, Object> getAttach(int recipe_bno) throws Exception{		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("list", dao.getAttach(recipe_bno));
		return map;
	}
	
}

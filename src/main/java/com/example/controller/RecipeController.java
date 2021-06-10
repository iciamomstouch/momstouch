package com.example.controller;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.domain.Criteria;
import com.example.domain.PageMaker;
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
}

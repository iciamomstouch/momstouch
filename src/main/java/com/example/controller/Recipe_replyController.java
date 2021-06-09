package com.example.controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.persistence.Recipe_replyDAO;

@Controller
@RequestMapping("/recipe/")
public class Recipe_replyController {
	@Autowired
	Recipe_replyDAO dao;
	
	@RequestMapping("reply.json")
	@ResponseBody
	public HashMap<String,Object>list(int recipe_bno) throws Exception{
		HashMap<String,Object> map=new HashMap<String,Object>();		
		map.put("list", dao.list(recipe_bno));		
		return map;
	}
	
	
}

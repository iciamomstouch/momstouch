package com.example.controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.domain.Recipe_replyVO;
import com.example.persistence.Recipe_replyDAO;
import com.example.service.Recipe_replyService;

@Controller
@RequestMapping("/recipe/")
public class Recipe_replyController {
	@Autowired
	Recipe_replyDAO dao;
	
	@Autowired
	Recipe_replyService service;
	
	@RequestMapping("reply.json")
	@ResponseBody
	public HashMap<String,Object> rlist(int recipe_bno) throws Exception{
		HashMap<String,Object> map=new HashMap<String,Object>();		
		map.put("list", dao.rlist(recipe_bno));		
		return map;
	}
	
	@RequestMapping(value="reply/insert", method=RequestMethod.POST)
	@ResponseBody
	public void insert(Recipe_replyVO vo) throws Exception{		
		service.insert(vo);		
	}
	
	@RequestMapping("reply/delete")
	@ResponseBody
	public void delete(int recipe_rno) throws Exception{
		service.delete(recipe_rno);
	}	
	
	
}

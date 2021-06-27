package com.example.controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.domain.Info_replyVO;
import com.example.persistence.Info_replyDAO;
import com.example.service.Info_replyService;

@Controller
@RequestMapping("/info/")
public class Info_replyController {
	@Autowired
	Info_replyDAO dao;
	
	@Autowired
	Info_replyService service;
	
	@RequestMapping("reply.json")
	@ResponseBody
	public HashMap<String,Object> rlist(int info_bno) throws Exception{
		HashMap<String,Object> map=new HashMap<String,Object>();		
		map.put("list", dao.rlist(info_bno));		
		return map;
	}
	
	@RequestMapping(value="reply/insert", method=RequestMethod.POST)
	@ResponseBody
	public void insert(Info_replyVO vo) throws Exception{		
			service.insert(vo);		
	}
	
	@RequestMapping("reply/delete")
	@ResponseBody
	public void delete(int info_rno) throws Exception{
		service.delete(info_rno);
	}	
	
}

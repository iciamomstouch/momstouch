package com.example.controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.domain.Board_replyVO;
import com.example.persistence.Board_replyDAO;
import com.example.service.Board_replyService;

@Controller
@RequestMapping("/board/")
public class Board_replyController {
	@Autowired
	Board_replyDAO dao;
	
	@Autowired
	Board_replyService service;
	
	@RequestMapping("reply.json")
	@ResponseBody
	public HashMap<String,Object> rlist(int board_bno) throws Exception{
		HashMap<String,Object> map=new HashMap<String,Object>();		
		map.put("list", dao.rlist(board_bno));		
		return map;
	}
	
	@RequestMapping("uReply.json")
	@ResponseBody
	public HashMap<String,Object> ulist(String board_replyer) throws Exception{
		HashMap<String,Object> map=new HashMap<String,Object>();		
		map.put("list", dao.ulist(board_replyer));		
		return map;
	}
	
	@RequestMapping(value="reply/insert", method=RequestMethod.POST)
	@ResponseBody
	public void insert(Board_replyVO vo) throws Exception{		
			service.insert(vo);		
	}
	
	@RequestMapping("reply/delete")
	@ResponseBody
	public void delete(int board_rno) throws Exception{
		service.delete(board_rno);
	}	
	
}

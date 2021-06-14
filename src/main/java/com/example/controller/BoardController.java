package com.example.controller;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import com.example.domain.BoardVO;
import com.example.domain.Criteria;
import com.example.domain.PageMaker;

import com.example.persistence.BoardDAO;


@Controller
@RequestMapping("/board/")
public class BoardController {
	@Autowired
	BoardDAO dao;
	
	@Resource(name="uploadPath")
	String path;
	
	@RequestMapping("list")
	public String list(Model model, Criteria cri) throws Exception{
		cri.setPerPageNum(5);
		
		PageMaker pm = new PageMaker();
		pm.setCri(cri);
		model.addAttribute("pm", pm);
		model.addAttribute("cri", cri);
		model.addAttribute("list", dao.list(cri));
		model.addAttribute("pageName", "board/list.jsp");
		return "index";
	}
	@RequestMapping("insert")
	public String insert(Model model){
		model.addAttribute("pageName", "board/insert.jsp");
		
		return "index";
	}
	@RequestMapping(value="insert", method=RequestMethod.POST)
	@ResponseBody
	public String insertPost(BoardVO vo) throws Exception{
		dao.insert(vo);
		return "index";
		}
	
	@RequestMapping("read")
	public void read(int board_bno, Model model) throws Exception{
		model.addAttribute("vo", dao.read(board_bno));
	}
	@RequestMapping("delete")
	public String read(int board_bno) throws Exception{
		dao.delete(board_bno);
		return "redirect:list";
	}
}

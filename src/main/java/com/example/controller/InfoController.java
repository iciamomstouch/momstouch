package com.example.controller;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.domain.Criteria;
import com.example.domain.InfoVO;
import com.example.domain.PageMaker;


import com.example.persistence.InfoDAO;


@Controller
@RequestMapping("/info/")
public class InfoController {
	@Autowired
	InfoDAO dao;
	
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
		model.addAttribute("pageName", "info/list.jsp");
		return "index";
	}
	@RequestMapping("insert")
	public void insert(){
		
	}
	@RequestMapping(value="insert", method=RequestMethod.POST)
	@ResponseBody
	public String insertPost(InfoVO vo) throws Exception{
		dao.insert(vo);
		return "index";
	}
	@RequestMapping("read")
	public void read(int info_bno, Model model) throws Exception{
		model.addAttribute("vo", dao.read(info_bno));
	}
	@RequestMapping("delete")
	public String read(int info_bno) throws Exception{
		dao.delete(info_bno);
		return "redirect:list";
	}
}

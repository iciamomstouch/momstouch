package com.example.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.domain.Criteria;
import com.example.domain.PageMaker;
import com.example.domain.QuestionVO;
import com.example.persistence.QuestionDAO;

@Controller
@RequestMapping("/question/")
public class QuestionController {
	@Autowired
	QuestionDAO dao;
	
	@RequestMapping("list")
	public String list(Model model) throws Exception{
		model.addAttribute("list", dao.list());
		model.addAttribute("pageName", "question/list.jsp");
		return "index";
	}
	
	@RequestMapping("insert")
	public void insert() {
	}
	@RequestMapping(value="insert", method=RequestMethod.POST)
	public String insertPost(QuestionVO vo, RedirectAttributes rttr) throws Exception {
		dao.insert(vo);
	 rttr.addFlashAttribute("result", "SUCCESS");
	 return "redirect:list?result=SUCCESS";
	}
	@RequestMapping("read")
	public void read(int question_bno, Model model) throws Exception {
	 model.addAttribute("vo", dao.read(question_bno));
	}
	@RequestMapping("update")
	public void update(int question_bno, Model model) throws Exception {
	 model.addAttribute("vo", dao.read(question_bno));
	}
	@RequestMapping(value="/update", method=RequestMethod.POST)
	public String updatePost(QuestionVO vo, RedirectAttributes rttr) throws Exception {
		dao.update(vo);
	 rttr.addFlashAttribute("result", "SUCCESS");
	 return "redirect:list";
	}
	@RequestMapping(value="delete", method=RequestMethod.POST)
	public String deletePost(int question_bno, RedirectAttributes rttr) throws Exception {
		dao.delete(question_bno);
	 rttr.addFlashAttribute("result", "SUCCESS");
	 return "redirect:list";
	} 
	
	
	
}

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
import com.example.mapper.QuestionMapper;

@Controller
@RequestMapping("/question/")
public class QuestionController {
	@Autowired
	QuestionMapper questionMapper;
	
	@RequestMapping("/list")
	public String list(Model model){
		model.addAttribute("list", questionMapper.list());
		return "/question/list";
	}
	
	@RequestMapping("/insert")
	public void insert() {
	}
	@RequestMapping(value="insert", method=RequestMethod.POST)
	public String insertPost(QuestionVO vo, RedirectAttributes rttr) {
	 questionMapper.insert(vo);
	 rttr.addFlashAttribute("result", "SUCCESS");
	 return "redirect:list?result=SUCCESS";
	}
	@RequestMapping("/read")
	public void read(int question_bno, Model model) {
	 model.addAttribute("vo", questionMapper.read(question_bno));
	}
	@RequestMapping("/update")
	public void update(int question_bno, Model model) {
	 model.addAttribute("vo", questionMapper.read(question_bno));
	}
	@RequestMapping(value="/update", method=RequestMethod.POST)
	public String updatePost(QuestionVO vo, RedirectAttributes rttr) {
	 questionMapper.update(vo);
	 rttr.addFlashAttribute("result", "SUCCESS");
	 return "redirect:list";
	}
	@RequestMapping(value="/delete", method=RequestMethod.POST)
	public String deletePost(int question_bno, RedirectAttributes rttr) {
	 questionMapper.delete(question_bno);
	 rttr.addFlashAttribute("result", "SUCCESS");
	 return "redirect:list";
	} 
	
	
	
}

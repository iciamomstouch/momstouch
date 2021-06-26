package com.example.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/map/")
public class MapContorller {
	@RequestMapping("list")
	public String list(Model model){
	model.addAttribute("pageName", "map/list.jsp");
	return "index";
	}
	
	@RequestMapping("map")
	public String map(Model model){
	model.addAttribute("pageName", "map/map.jsp");
	return "index";
	}
}

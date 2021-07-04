package com.example.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.example.domain.Criteria;
import com.example.domain.PageMaker;
import com.example.domain.RecipeVO;
import com.example.domain.User_keepVO;
import com.example.persistence.RecipeDAO;
import com.example.service.RecipeService;

@Controller
@RequestMapping("/recipe/")
public class RecipeController {
	@Autowired
	RecipeDAO dao;
	
	@Autowired
	RecipeService service;
	
	@Resource(name="uploadPath")
	String path;
	

	@RequestMapping("list")
	public String list(Model model) throws Exception{
		model.addAttribute("pageName", "recipe/list.jsp");
		return "index";
	}
	
	@RequestMapping("list.json")
	@ResponseBody
	public HashMap<String, Object> listJson(Criteria cri, int perPageNum) throws Exception{
		HashMap<String, Object> map = new HashMap<String, Object>();
		cri.setPerPageNum(perPageNum);
		
		map.put("list", dao.list(cri));	
		PageMaker pm = new PageMaker();
		pm.setCri(cri);
		pm.setTotalCount(dao.totalCount(cri));
		
		map.put("pm", pm);
		map.put("cri", cri);
		
		return map;
	}	
	
	@RequestMapping("getAttach.json")
	@ResponseBody
	public HashMap<String, Object> getAttach(int recipe_bno) throws Exception{		
		HashMap<String, Object> map = new HashMap<>();
		map.put("list", dao.getAttach(recipe_bno));
		System.out.println(map.toString());
		return map;
	}
	
	@RequestMapping("update")
	public String update(Model model, int recipe_bno) throws Exception{
		int lastAttachNo = dao.lastAttachNo(recipe_bno);
		int attachNo = lastAttachNo + 1;
		model.addAttribute("attachNo", attachNo);
		model.addAttribute("vo", dao.read(recipe_bno));
		model.addAttribute("pageName", "recipe/update.jsp");
		return "index";
	}
	
	@RequestMapping(value="update", method=RequestMethod.POST)
	public String update(RecipeVO  vo, MultipartHttpServletRequest multi) throws Exception{
		RecipeVO oldVO = dao.read(vo.getRecipe_bno());		
		
		//파일업로드
		MultipartFile file=multi.getFile("file");
		if(!file.isEmpty()){
			String image=System.currentTimeMillis()+"_"+file.getOriginalFilename();
			file.transferTo(new File(path + "/" + image));
			vo.setRecipe_image(image);
			//예전이미지가 존재하면 삭제
			System.out.println("....." + oldVO.getRecipe_image());
			if(oldVO.getRecipe_image()!=null){
				new File(path +"/"+oldVO.getRecipe_image()).delete();
			}
		}else{
			vo.setRecipe_image(oldVO.getRecipe_image());
		}
		
		//첨부파일 여러개 업로드
		List<MultipartFile> files=multi.getFiles("files");
		String attPath=path + "/" + vo.getRecipe_bno();
		File folder=new File(attPath);
		if(!folder.exists()) folder.mkdir();
		ArrayList<String> images = new ArrayList<String>();
		for(MultipartFile attFile:files){		    
			if(!attFile.isEmpty()){
				String image=System.currentTimeMillis()+"_"+attFile.getOriginalFilename();
				attFile.transferTo(new File(attPath + "/" + image));
				images.add(image);
			}
			vo.setImages(images);			
		}		
		service.update(vo);
		return "redirect:list";
	}
		
	@RequestMapping("delete")
	public String delete(int recipe_bno) throws Exception{
		RecipeVO vo = dao.read(recipe_bno);
		if(vo.getRecipe_image()!=null){
			new File(path + "/" + vo.getRecipe_image()).delete();
		}		
		service.delete(recipe_bno);
		return "redirect:list";
	}
	
	@RequestMapping("insert")
	public String insert(Model model, HttpSession session) throws Exception{
		int lastBno = dao.lastBno();
		int bno = lastBno + 1;
		model.addAttribute("bno", bno);
		model.addAttribute("user_id", session.getAttribute("user_id"));
		model.addAttribute("pageName", "recipe/insert.jsp");
		return "index";
	}
	
	@RequestMapping(value="insert", method=RequestMethod.POST)
	public String insert(RecipeVO vo, MultipartHttpServletRequest multi) throws Exception{
		//파일 업로드
		
		MultipartFile file = multi.getFile("file");
		if(!file.isEmpty()){
			String image = System.currentTimeMillis() + "_" + file.getOriginalFilename();//파일명
			file.transferTo(new File(path + "/" + image));//파일이동
			vo.setRecipe_image(image);
		}
		
		//첨부파일 여러개 업로드
		List<MultipartFile> files=multi.getFiles("files");
		String attPath=path + "/" + vo.getRecipe_bno();
		File folder=new File(attPath);
		if(!folder.exists()) folder.mkdir();
		ArrayList<String> images = new ArrayList<String>();
		for(MultipartFile attFile:files){		    
			if(!attFile.isEmpty()){
				String image=System.currentTimeMillis()+"_"+attFile.getOriginalFilename();
				attFile.transferTo(new File(attPath + "/" + image));
				images.add(image);
			}
			vo.setImages(images);			
		}		
		service.insert(vo);	    
		return "redirect:list";
	}
	
	@RequestMapping("read")
	public String read(Model model, int recipe_bno, HttpSession session) throws Exception{
		String user_id = (String) session.getAttribute("user_id");
		System.out.println("로그인아이디............" + user_id);
		model.addAttribute("keep", dao.keepRead(recipe_bno, user_id));
		model.addAttribute("vo", service.read(recipe_bno));
		model.addAttribute("list", dao.getAttach(recipe_bno));
		
		String next = dao.nextNum(recipe_bno);
		if(next!=null){
			model.addAttribute("next", Integer.valueOf(next));
		}
		
		String pre = dao.preNum(recipe_bno);
		if(pre!=null){
			model.addAttribute("pre", Integer.valueOf(pre));
		}
		
		model.addAttribute("max", dao.maxNum());
		model.addAttribute("min", dao.minNum());
		model.addAttribute("pageName", "recipe/read.jsp");
		return "index";
	}
	
	@RequestMapping("deleteFile")
	public String deleteFile(int recipe_bno, int recipe_attach_no) throws Exception{
		RecipeVO vo = dao.read(recipe_bno);
		if(vo.getRecipe_image()!=null){
			new File(path + "/" + vo.getRecipe_image()).delete();
		}		
		service.delete(recipe_bno);
		return "redirect:list";
	}
	
	@RequestMapping("keepRead.json")
	@ResponseBody
	public User_keepVO keepRead(int recipe_bno, String user_id) throws Exception{		
		return dao.keepRead(recipe_bno, user_id);
	}
	
	@RequestMapping(value="keepInsert", method=RequestMethod.POST)
	@ResponseBody
	public void keepInsert(User_keepVO vo) throws Exception{
		dao.keepInsert(vo);
	}
	
	@RequestMapping(value="keepUpdate", method=RequestMethod.POST)
	@ResponseBody
	public void keepUpdate(User_keepVO vo) throws Exception{
		System.out.println(vo.toString());
		dao.keepUpdate(vo);
	}
	
	@RequestMapping("klist.json")
	@ResponseBody //데이터 자체를 리턴할때
	public HashMap<String, Object> klistJson(Criteria cri, String user_id) throws Exception{
		HashMap<String, Object> map = new HashMap<String, Object>();
		cri.setPerPageNum(6);
		
		map.put("list", dao.klist(cri.getPageStart(), cri.getPerPageNum(), user_id));		
		PageMaker pm = new PageMaker();
		pm.setCri(cri);
		pm.setTotalCount(dao.totalCount(cri));
		
		map.put("pm", pm);
		map.put("cri", cri);
		
		return map;
	}
	
}

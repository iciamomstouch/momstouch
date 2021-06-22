package com.example.controller;


import java.io.File;
import java.util.HashMap;

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
import com.example.domain.QuestionVO;
import com.example.persistence.QuestionDAO;
import com.example.service.QuestionService;

@Controller
@RequestMapping("/question/")
public class QuestionController {
	@Autowired
	QuestionDAO dao;
	
	@Autowired
	QuestionService service;
	
	@Resource(name="uploadPath")
	String path;
	
	@RequestMapping("list")
	public String list(Model model) throws Exception{		
		model.addAttribute("pageName", "question/list.jsp");
		return "index";
	}
	
	@RequestMapping("list.json")
	@ResponseBody //데이터 자체를 리턴할때
	public HashMap<String, Object> listJson(Criteria cri) throws Exception{
		HashMap<String, Object> map = new HashMap<String, Object>();
		cri.setPerPageNum(10);
		
		map.put("list", dao.list(cri));		
		PageMaker pm = new PageMaker();
		pm.setCri(cri);
		pm.setTotalCount(dao.totalCount(cri));
		
		map.put("pm", pm);
		map.put("cri", cri);
		
		return map;
	}
	
	@RequestMapping("insert")
	public String insert(Model model, HttpSession session) throws Exception{
		int lastBno = dao.lastBno();
		int bno = lastBno + 1;
		model.addAttribute("bno", bno);
		model.addAttribute("user_id", session.getAttribute("user_id"));
		model.addAttribute("pageName", "question/insert.jsp");
		return "index";
	}
	
	@RequestMapping(value="insert", method=RequestMethod.POST)	
	public String insert(QuestionVO vo, MultipartHttpServletRequest multi) throws Exception{		
		//파일 업로드
		MultipartFile file = multi.getFile("file");
		if(!file.isEmpty()){
			String image = System.currentTimeMillis() + "_" + file.getOriginalFilename();//파일명
			file.transferTo(new File(path + "/" + image));//파일이동
			vo.setQuestion_image(image);
		}
		dao.insert(vo);
		return "redirect:list";
	}
	
	@RequestMapping("read")
	public String read(int question_bno, Model model) throws Exception {
	 model.addAttribute("vo", service.read(question_bno));
	 model.addAttribute("pageName", "question/read.jsp");
	 return "index";
	}
	
	@RequestMapping("update")
	public String update(int question_bno, Model model) throws Exception {
	 model.addAttribute("vo", dao.read(question_bno));
	 model.addAttribute("pageName", "question/update.jsp");
	 return "index";
	}
	
	@RequestMapping(value="update", method=RequestMethod.POST)
	public String update(QuestionVO vo, MultipartHttpServletRequest multi) throws Exception{
		QuestionVO oldVO = dao.read(vo.getQuestion_bno());
		String oldImage = oldVO.getQuestion_image();
		//대표 이미지 파일 업로드
		MultipartFile file = multi.getFile("file");
		if(!file.isEmpty()){
			String image = System.currentTimeMillis() + "_" + file.getOriginalFilename();//파일명
			file.transferTo(new File(path + "/" + image));//파일이동
			vo.setQuestion_image(image);
			//예전 이미지가 있을 경우에만 삭제			
			if(oldImage!=null){
				new File(path + "/" + oldImage).delete();
			}
		}else{
			vo.setQuestion_image(oldImage);
		}		
		dao.update(vo);
		return "redirect:list";
	}
	
	@RequestMapping(value="delete", method=RequestMethod.POST)
	public String deletePost(int question_bno) throws Exception {
		dao.delete(question_bno);	 
	 return "redirect:list";
	}
	
	@RequestMapping("reply")
	public String reply(int question_bno, Model model) throws Exception {
		model.addAttribute("vo", dao.read(question_bno));
		model.addAttribute("pageName", "question/reply.jsp");
		return "index";
	}
	
	@RequestMapping(value="insert2", method=RequestMethod.POST)	
	public String insert2(QuestionVO vo, MultipartHttpServletRequest multi) throws Exception{
		QuestionVO oldVO = dao.read(vo.getQuestion_bno());
		
		int question_grpord = oldVO.getQuestion_grpord() + 1;
		vo.setQuestion_grpord(question_grpord);
		int question_depth = oldVO.getQuestion_depth() + 1;
		vo.setQuestion_depth(question_depth);
		String question_title = "RE:" + oldVO.getQuestion_title();
		vo.setQuestion_title(question_title);
		
		//파일 업로드
		MultipartFile file = multi.getFile("file");
		if(!file.isEmpty()){
			String image = System.currentTimeMillis() + "_" + file.getOriginalFilename();//파일명
			file.transferTo(new File(path + "/" + image));//파일이동
			vo.setQuestion_image(image);
		}
		dao.insert2(vo);
		return "redirect:list";
	}
	
}

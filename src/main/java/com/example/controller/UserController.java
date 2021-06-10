package com.example.controller;

import java.io.File;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.example.domain.Criteria;
import com.example.domain.PageMaker;
import com.example.domain.UserVO;
import com.example.persistence.UserDAO;

@Controller
@RequestMapping("/user/")
public class UserController {
	@Autowired
	BCryptPasswordEncoder passEncoder;
	
	@Autowired
	UserDAO dao;
	
	@Resource(name="uploadPath")
	String path;
	
	@RequestMapping("list")
	public String list(Model model, Criteria cri) throws Exception{
		cri.setPerPageNum(2);
		
		PageMaker pm = new PageMaker();
		pm.setCri(cri);
		pm.setTotalCount(dao.totalCount());
		
		model.addAttribute("pm", pm);
		model.addAttribute("cri", cri);
		model.addAttribute("list", dao.list(cri));
		model.addAttribute("pageName", "user/list.jsp");
		return "index";
	}
	
	@RequestMapping("insert")
	public void insert(){}
	
	@RequestMapping("read")
	public void read(Model model, String user_id) throws Exception{
		model.addAttribute("vo", dao.read(user_id));
	}
	
	@RequestMapping(value="insert", method=RequestMethod.POST)
	public String insert(UserVO vo, MultipartHttpServletRequest multi) throws Exception{
		String password = passEncoder.encode(vo.getUser_pass());
		vo.setUser_pass(password);
		
		//파일 업로드
		MultipartFile file = multi.getFile("file");
		if(!file.isEmpty()){
			String image = System.currentTimeMillis() + "_" + file.getOriginalFilename();//파일명
			file.transferTo(new File(path + "/" + image));//파일이동
			vo.setUser_image(image);
		}		
		dao.insert(vo);
		return "redirect:list";
	}
	
	@RequestMapping(value="update", method=RequestMethod.POST)
	public String update(UserVO vo, MultipartHttpServletRequest multi) throws Exception{
		UserVO oldVO = dao.read(vo.getUser_id());
		String oldImage = oldVO.getUser_image();
		//대표 이미지 파일 업로드
		MultipartFile file = multi.getFile("file");
		if(!file.isEmpty()){
			String image = System.currentTimeMillis() + "_" + file.getOriginalFilename();//파일명
			file.transferTo(new File(path + "/" + image));//파일이동
			vo.setUser_image(image);
			//예전 이미지가 있을 경우에만 삭제			
			if(oldImage!=null){
				new File(path + "/" + oldImage).delete();
			}
		}else{
			vo.setUser_image(oldImage);
		}		
		dao.update(vo);
		return "redirect:list";
	}
	
	@RequestMapping("delete")
	public String delete(String user_id) throws Exception{
		UserVO vo = dao.read(user_id);
		if(vo.getUser_image()!=null){
			new File(path + "/" + vo.getUser_image()).delete();
		}		
		dao.delete(user_id);
		return "redirect:list";
	}
}

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
import com.example.domain.InfoVO;
import com.example.domain.PageMaker;
import com.example.domain.User_keepVO;
import com.example.persistence.InfoDAO;
import com.example.service.InfoService;


@Controller
@RequestMapping("/info/")
public class InfoController {
	@Autowired
	InfoDAO dao;
	
	@Autowired
	InfoService service;
	
	@Resource(name="uploadPath")
	String path;
	
	@RequestMapping("list")
	public String list(Model model) throws Exception{		
		model.addAttribute("pageName", "info/list.jsp");
		return "index";
	}
	
	@RequestMapping("list.json")
	@ResponseBody //데이터 자체를 리턴할때
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
	
	@RequestMapping("insert")
	public String insert(Model model){
		model.addAttribute("pageName", "info/insert.jsp");		
		return "index";
	}
	
	@RequestMapping(value="insert", method=RequestMethod.POST)	
	public String insert(InfoVO vo, MultipartHttpServletRequest multi) throws Exception{		
		//파일 업로드
		MultipartFile file = multi.getFile("file");
		if(!file.isEmpty()){
			String image = System.currentTimeMillis() + "_" + file.getOriginalFilename();//파일명
			file.transferTo(new File(path + "/" + image));//파일이동
			vo.setInfo_image(image);
		}
		dao.insert(vo);
		return "redirect:list";
	}
	
	@RequestMapping(value="update", method=RequestMethod.POST)
	public String update(InfoVO vo, MultipartHttpServletRequest multi) throws Exception{
		InfoVO oldVO = dao.read(vo.getInfo_bno());
		String oldImage = oldVO.getInfo_image();
		//대표 이미지 파일 업로드
		MultipartFile file = multi.getFile("file");
		if(!file.isEmpty()){
			String image = System.currentTimeMillis() + "_" + file.getOriginalFilename();//파일명
			file.transferTo(new File(path + "/" + image));//파일이동
			vo.setInfo_image(image);
			//예전 이미지가 있을 경우에만 삭제			
			if(oldImage!=null){
				new File(path + "/" + oldImage).delete();
			}
		}else{
			vo.setInfo_image(oldImage);
		}		
		dao.update(vo);
		return "redirect:list";
	}
	
	@RequestMapping("read")
	public String read(int info_bno, Model model, HttpSession session) throws Exception{
		String user_id = (String) session.getAttribute("user_id");
		System.out.println("로그인아이디............" + user_id);
		model.addAttribute("keep", dao.keepRead(info_bno, user_id));
		model.addAttribute("vo", service.read(info_bno));
		
		String next = dao.nextNum(info_bno);
		if(next!=null){
			model.addAttribute("next", Integer.valueOf(next));
		}
		
		String pre = dao.preNum(info_bno);
		if(pre!=null){
			model.addAttribute("pre", Integer.valueOf(pre));
		}
		
		model.addAttribute("max", dao.maxNum());
		model.addAttribute("min", dao.minNum());
		
		model.addAttribute("pageName", "info/read.jsp");		
		return "index";
	}
	
	@RequestMapping("delete")
	public String read(int info_bno) throws Exception{
		dao.delete(info_bno);
		return "redirect:list";
	}
	
	@RequestMapping("update")
	public String update(int info_bno, Model model) throws Exception{
		model.addAttribute("vo", dao.read(info_bno));
		model.addAttribute("pageName", "info/update.jsp");
		return "index";
	}
	
	@RequestMapping("keepRead.json")
	@ResponseBody
	public User_keepVO keepRead(int info_bno, String user_id) throws Exception{		
		return dao.keepRead(info_bno, user_id);
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
		cri.setPerPageNum(5);
		
		map.put("list", dao.klist(cri.getPageStart(), cri.getPerPageNum(), user_id));		
		PageMaker pm = new PageMaker();
		pm.setCri(cri);
		pm.setTotalCount(dao.totalCount(cri));
		
		map.put("pm", pm);
		map.put("cri", cri);
		
		return map;
	}
}

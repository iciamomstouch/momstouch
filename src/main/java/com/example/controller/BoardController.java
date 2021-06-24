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

import com.example.domain.BoardVO;
import com.example.domain.Criteria;
import com.example.domain.PageMaker;
import com.example.persistence.BoardDAO;
import com.example.service.BoardService;


@Controller
@RequestMapping("/board/")
public class BoardController {
	@Autowired
	BoardDAO dao;
	
	@Autowired
	BoardService service;
	
	@Resource(name="uploadPath")
	String path;
	
	@RequestMapping("list")
	public String list(Model model) throws Exception{		
		model.addAttribute("pageName", "board/list.jsp");
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
	public String insert(Model model, HttpSession session){
		model.addAttribute("user_id", session.getAttribute("user_id"));
		model.addAttribute("pageName", "board/insert.jsp");		
		return "index";
	}
	
	@RequestMapping(value="insert", method=RequestMethod.POST)	
	public String insert(BoardVO vo, MultipartHttpServletRequest multi) throws Exception{		
		//파일 업로드
		MultipartFile file = multi.getFile("file");
		if(!file.isEmpty()){
			String image = System.currentTimeMillis() + "_" + file.getOriginalFilename();//파일명
			file.transferTo(new File(path + "/" + image));//파일이동
			vo.setBoard_image(image);
		}
		dao.insert(vo);
		return "redirect:list";
	}
	
	@RequestMapping(value="update", method=RequestMethod.POST)
	public String update(BoardVO vo, MultipartHttpServletRequest multi) throws Exception{
		BoardVO oldVO = dao.read(vo.getBoard_bno());
		String oldImage = oldVO.getBoard_image();
		//대표 이미지 파일 업로드
		MultipartFile file = multi.getFile("file");
		if(!file.isEmpty()){
			String image = System.currentTimeMillis() + "_" + file.getOriginalFilename();//파일명
			file.transferTo(new File(path + "/" + image));//파일이동
			vo.setBoard_image(image);
			//예전 이미지가 있을 경우에만 삭제			
			if(oldImage!=null){
				new File(path + "/" + oldImage).delete();
			}
		}else{
			vo.setBoard_image(oldImage);
		}		
		dao.update(vo);
		return "redirect:list";
	}
	
	@RequestMapping("read")
	public String read(int board_bno, Model model) throws Exception{
		model.addAttribute("vo", service.read(board_bno));
		model.addAttribute("pageName", "board/read.jsp");
		return "index";
	}
	
	@RequestMapping("delete")
	public String read(int board_bno) throws Exception{
		dao.delete(board_bno);
		return "redirect:list";
	}
}

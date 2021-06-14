package com.example.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.example.domain.Criteria;
import com.example.domain.PageMaker;
import com.example.domain.TradeVO;
import com.example.domain.UserVO;
import com.example.persistence.TradeDAO;
import com.example.service.TradeService;

@Controller
@RequestMapping("/trade/")
public class TradeController {
	@Autowired
	TradeDAO dao;
	
	@Autowired
	TradeService service;
	
	@Resource(name="uploadPath")
	String path;
	
	@RequestMapping("getAttach")
	@ResponseBody
	public HashMap<String, Object> getAttach(int trade_bno) throws Exception{		
		HashMap<String, Object> map = new HashMap<>();
		map.put("list", dao.getAttach(trade_bno));
		System.out.println(map.toString());
		return map;
	}
	
	@RequestMapping(value="update", method=RequestMethod.POST)
	public String update(TradeVO  vo, MultipartHttpServletRequest multi) throws Exception{
		TradeVO oldVO = dao.read(vo.getTrade_bno());
		
		//파일업로드
		MultipartFile file=multi.getFile("file");
		if(!file.isEmpty()){
			String image=System.currentTimeMillis()+"_"+file.getOriginalFilename();
			file.transferTo(new File(path + "/" + image));
			vo.setTrade_image(image);
			//예전이미지가 존재하면 삭제
			System.out.println("....." + oldVO.getTrade_image());
			if(oldVO.getTrade_image()!=null){
				new File(path +"/"+oldVO.getTrade_image()).delete();
			}
		}else{
			vo.setTrade_image(oldVO.getTrade_image());
		}
		
		//첨부파일 여러개 업로드
		List<MultipartFile> files=multi.getFiles("files");
		String attPath=path + "/" + vo.getTrade_bno();
		File folder=new File(attPath);
		if(!folder.exists()) folder.mkdir();
		for(MultipartFile attFile:files){
			if(!attFile.isEmpty()){
				String image=System.currentTimeMillis()+"_"+attFile.getOriginalFilename();
				attFile.transferTo(new File(attPath + "/" + image));
			}
		}
		
		dao.update(vo);
		return "redirect:list";
	}
		
	@RequestMapping("delete")
	public String delete(int trade_bno) throws Exception{
		TradeVO vo = dao.read(trade_bno);
		if(vo.getTrade_image()!=null){
			new File(path + "/" + vo.getTrade_image()).delete();
		}		
		dao.delete(trade_bno);
		return "redirect:list";
	}
	
	@RequestMapping("insert")
	public void insert(){}
	
	@RequestMapping(value="insert", method=RequestMethod.POST)
	public String insert(TradeVO vo, int trade_bno, MultipartHttpServletRequest multi) throws Exception{
		//파일 업로드
		System.out.println(vo.toString());
		MultipartFile file = multi.getFile("file");
		if(!file.isEmpty()){
			String image = System.currentTimeMillis() + "_" + file.getOriginalFilename();//파일명
			file.transferTo(new File(path + "/" + image));//파일이동
			vo.setTrade_image(image);
		}
		
		//첨부파일 여러개 업로드
		List<MultipartFile> files=multi.getFiles("files");
		String attPath=path + "/" + vo.getTrade_bno();
		File folder=new File(attPath);
		if(!folder.exists()) folder.mkdir();
		for(MultipartFile attFile:files){
		    ArrayList<String> images = new ArrayList<String>();
			if(!attFile.isEmpty()){
				String image=System.currentTimeMillis()+"_"+attFile.getOriginalFilename();
				attFile.transferTo(new File(attPath + "/" + image));
				images.add(image);

			}
			vo.setImages(images);
			service.insert(vo);
		}
	    
		return "redirect:list";
	}
	
	@RequestMapping("read")
	public String read(Model model, int trade_bno) throws Exception{		
		model.addAttribute("vo", service.read(trade_bno));
		model.addAttribute("list", dao.getAttach(trade_bno));
		model.addAttribute("pageName", "trade/read.jsp");
		return "index";
	}
	
	@RequestMapping("list")
	public String list(Model model, Criteria cri) throws Exception{
		model.addAttribute("list", dao.list(cri));
		model.addAttribute("pageName", "trade/list.jsp");
		return "index";
	}
}

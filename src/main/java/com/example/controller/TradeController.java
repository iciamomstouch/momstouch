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
import com.example.domain.TradeVO;
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
		//System.out.println(map.toString());
		return map;
	}
	
	@RequestMapping("keep")
	@ResponseBody
	public HashMap<String, Object> keep(int trade_bno) throws Exception{		
		HashMap<String, Object> map = new HashMap<>();
		map.put("list", dao.keep(trade_bno));
		System.out.println(map.toString());
		return map;
	}
	
	@RequestMapping("update")
	public String update(Model model, int trade_bno) throws Exception{
		model.addAttribute("vo", dao.read(trade_bno));
		model.addAttribute("pageName", "trade/update.jsp");
		return "index";
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
		ArrayList<String> images = new ArrayList<String>();
		for(MultipartFile attFile:files){		    
			if(!attFile.isEmpty()){
				String image=System.currentTimeMillis()+"_"+attFile.getOriginalFilename();
				attFile.transferTo(new File(attPath + "/" + image));
				images.add(image);
				//예전이미지가 존재하면 삭제
				System.out.println("....." + oldVO.getImages());
				if(oldVO.getImages()!=null){
					new File(path +"/"+oldVO.getImages()).delete();
				}
			}else{
				vo.setImages(images);
			}
		}
		service.update(vo);
		System.out.println(vo.toString());
		return "redirect:list";
	}
		
	@RequestMapping("delete")
	public String delete(int trade_bno) throws Exception{
		TradeVO vo = dao.read(trade_bno);
		if(vo.getTrade_image()!=null){
			new File(path + "/" + vo.getTrade_image()).delete();
		}		
		service.delete(trade_bno);
		return "redirect:list";
	}
	
	@RequestMapping("insert")
	public String insert(Model model, HttpSession session) throws Exception{
		int lastBno = dao.lastBno();
		int bno = lastBno + 1;
		model.addAttribute("bno", bno);
		model.addAttribute("user_id", session.getAttribute("user_id"));
		model.addAttribute("pageName", "trade/insert.jsp");
		return "index";
	}
	
	@RequestMapping(value="insert", method=RequestMethod.POST)
	public String insert(TradeVO vo, int trade_bno, MultipartHttpServletRequest multi) throws Exception{
		//파일 업로드
		
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
	public String read(Model model, int trade_bno) throws Exception{		
		model.addAttribute("vo", service.read(trade_bno));
		model.addAttribute("list", dao.getAttach(trade_bno));
		model.addAttribute("pageName", "trade/read.jsp");
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
	
	@RequestMapping("list")
	public String list(Model model, Criteria cri) throws Exception{
		model.addAttribute("pageName", "trade/list.jsp");
		return "index";
	}
	
	@RequestMapping("tlist.json")
	@ResponseBody //데이터 자체를 리턴할때
	public List<TradeVO> tlistJson(Criteria cri) throws Exception{
		List<TradeVO> array = new ArrayList<>();
		array = dao.list(cri);
		return array;
	}
	
	@RequestMapping("deleteFile")
	public String deleteFile(int trade_bno) throws Exception{
		TradeVO vo = dao.read(trade_bno);
		if(vo.getTrade_image()!=null){
			new File(path + "/" + vo.getTrade_image()).delete();
		}		
		service.delete(trade_bno);
		return "redirect:list";
	}

}

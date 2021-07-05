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

import com.example.domain.ChatVO;
import com.example.domain.Criteria;
import com.example.domain.PageMaker;
import com.example.domain.TradeVO;
import com.example.domain.Trade_attachVO;
import com.example.domain.User_keepVO;
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
			}
			vo.setImages(images);			
		}
		System.out.println(vo.toString());
		service.update(vo);		
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
	public String read(Model model, int trade_bno, HttpSession session) throws Exception{
		String user_id = (String) session.getAttribute("user_id");
		System.out.println("로그인아이디............" + user_id);
		model.addAttribute("keep", dao.keepRead(trade_bno, user_id));
		model.addAttribute("vo", service.read(trade_bno));
		model.addAttribute("list", dao.getAttach(trade_bno));
		
		String next = dao.nextNum(trade_bno);
		if(next!=null){
			model.addAttribute("next", Integer.valueOf(next));
		}
		
		String pre = dao.preNum(trade_bno);
		if(pre!=null){
			model.addAttribute("pre", Integer.valueOf(pre));
		}
		
		model.addAttribute("max", dao.maxNum());
		model.addAttribute("min", dao.minNum());
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
	
	@RequestMapping("ulist.json")
	@ResponseBody
	public HashMap<String, Object> ulistJson(Criteria cri, String trade_writer) throws Exception{
		HashMap<String, Object> map = new HashMap<String, Object>();
		cri.setPerPageNum(5);
		
		map.put("list", dao.ulist(cri.getPageStart(), cri.getPerPageNum(), trade_writer));	
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
	
	@RequestMapping("deleteFile")
	public String deleteFile(int trade_bno) throws Exception{
		TradeVO vo = dao.read(trade_bno);
		if(vo.getTrade_image()!=null){
			new File(path + "/" + vo.getTrade_image()).delete();
		}		
		service.delete(trade_bno);
		return "redirect:list";
	}
	
	@RequestMapping("chat")
	public String chat(Model model) throws Exception{
		model.addAttribute("pageName", "trade/chat.jsp");
		return "index";
	}
	
	@RequestMapping("clist.json")
	@ResponseBody
	public List<ChatVO> clisst(String user_id) throws Exception{		
		return dao.clist(user_id);
	}
	
	@RequestMapping("keepRead.json")
	@ResponseBody
	public User_keepVO keepRead(int trade_bno, String user_id) throws Exception{		
		return dao.keepRead(trade_bno, user_id);
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
	
	
	
	//안드로이드 리스트
	   @RequestMapping("alist.json")
	   @ResponseBody //데이터 자체를 리턴할때
	   public List<TradeVO> alistJson(Criteria cri) throws Exception{
	      List<TradeVO> array = new ArrayList<>();
	      array = dao.list(cri);
	      return array;
	   }
	   
	   //안드로이드 첨부파일
	   @RequestMapping("agetAttach.json")
	      @ResponseBody
	      public List<Trade_attachVO> agetAttach(int trade_bno) throws Exception{      
	         List<Trade_attachVO> array = new ArrayList<>();
	         array = dao.getAttach(trade_bno);
	         //System.out.println(map.toString());
	         return array;
	      }
}

package com.example.controller;

import java.io.File;
import java.util.HashMap;
import java.util.*;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.util.WebUtils;

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
	
	@RequestMapping("alist.json")
	@ResponseBody //������ ��ü�� �����Ҷ�
	public List<UserVO> alistJson(Criteria cri) throws Exception{
		List<UserVO> array = new ArrayList<>();
		array = dao.list(cri);
		return array;
	}
	
	@RequestMapping("list")
	public String list(Model model) throws Exception{		
		model.addAttribute("pageName", "user/list.jsp");
		return "index";
	}
	
	@RequestMapping("list.json")
	@ResponseBody //������ ��ü�� �����Ҷ�
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
	public String insert(Model model){
		model.addAttribute("pageName", "user/insert.jsp");
		return "index";
	}
	
	@RequestMapping("update")
	public String read(Model model, String user_id) throws Exception{
		model.addAttribute("vo", dao.read(user_id));
		model.addAttribute("pageName", "user/update.jsp");
		return "index";
	}
	
	@RequestMapping(value="insert", method=RequestMethod.POST)
	public String insert(UserVO vo, MultipartHttpServletRequest multi) throws Exception{
		String password = passEncoder.encode(vo.getUser_pass());
		vo.setUser_pass(password);
		
		//���� ���ε�
		MultipartFile file = multi.getFile("file");
		if(!file.isEmpty()){
			String image = System.currentTimeMillis() + "_" + file.getOriginalFilename();//���ϸ�
			file.transferTo(new File(path + "/" + image));//�����̵�
			vo.setUser_image(image);
		}		
		dao.insert(vo);
		return "redirect:list";
	}
	
	@RequestMapping(value="update", method=RequestMethod.POST)
	public String update(UserVO vo, MultipartHttpServletRequest multi) throws Exception{
		UserVO oldVO = dao.read(vo.getUser_id());
		String oldImage = oldVO.getUser_image();
		//��ǥ �̹��� ���� ���ε�
		MultipartFile file = multi.getFile("file");
		if(!file.isEmpty()){
			String image = System.currentTimeMillis() + "_" + file.getOriginalFilename();//���ϸ�
			file.transferTo(new File(path + "/" + image));//�����̵�
			vo.setUser_image(image);
			//���� �̹����� ���� ��쿡�� ����			
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
		dao.update2(user_id);
		return "redirect:logout";
	}
	
	@RequestMapping("login")
	public String login(Model model){
		model.addAttribute("pageName", "user/login.jsp");
		return "index";
	}
	
	@RequestMapping(value="login", method=RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> loginPost(String user_id, String user_pass, HttpSession session, boolean chkLogin, HttpServletResponse response) throws Exception{
		HashMap<String, Object> map=new HashMap<String, Object>();
		UserVO vo = dao.login(user_id);
		int result=0; //���̵� ���� ���
		if(vo!=null){				
			if(passEncoder.matches(user_pass, vo.getUser_pass())){
				System.out.println("�α��� ����.....");
				result=1; //�α��� ����
				if(chkLogin){
					Cookie cookie = new Cookie("user_id", vo.getUser_id());
					cookie.setPath("/");
					cookie.setMaxAge(60*60*24*7); //7�Ϻ���
					response.addCookie(cookie);
				}
				session.setAttribute("user_id", vo.getUser_id());
				session.setAttribute("user_type", vo.getUser_type());
				session.setAttribute("user_nick", vo.getUser_nick());
				String id = (String) session.getAttribute("user_id");
				String type = (String) session.getAttribute("user_type");
				String nick = (String) session.getAttribute("user_nick");
				System.out.println("�������̵�................." +id);
				System.out.println("����Ÿ��.................." +type);
				System.out.println("�����г���.................." + nick);
				String path =(String)session.getAttribute("path");
				if(path==null) path="/";			
				map.put("path", path);
				
			}else{
				System.out.println("�α��� ����.....");
				result=2; //��й�ȣ ����ġ
			}
		}
		map.put("result", result);
		return map;
	}
	
	@RequestMapping("logout")
	public String logout(Model model, HttpSession session, HttpServletResponse response, HttpServletRequest request){
		model.addAttribute("pageName", "home.jsp");
		session.invalidate(); //session���� ����
		
		Cookie cookie = WebUtils.getCookie(request, "user_id");
		if(cookie != null){
			cookie.setPath("/");
			cookie.setMaxAge(0);
			response.addCookie(cookie);
		}
		return "index";
	}
	
	@RequestMapping("myinfo")
	public String myinfo(Model model, String user_id) throws Exception{
		model.addAttribute("vo", dao.read(user_id));
		model.addAttribute("pageName", "user/myinfo.jsp");
		return "index";
	}
	
	@RequestMapping("adminInsert")
	public String adminInsert(Model model){
		model.addAttribute("pageName", "user/adminInsert.jsp");
		return "index";
	}	
	
}

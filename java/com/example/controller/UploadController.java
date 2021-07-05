package com.example.controller;

import java.io.File;
import java.io.FileInputStream;
import java.util.UUID;

import javax.annotation.Resource;

import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.example.persistence.RecipeDAO;
import com.example.persistence.TradeDAO;

@Controller
public class UploadController {
	@Autowired
	RecipeDAO dao;
	
	@Autowired
	TradeDAO tdao;
	
	@Resource(name="uploadPath")
	String path;
	
	@RequestMapping("/uploadForm")
	public void uploadForm(){
		
	}
	
	@RequestMapping("/uploadAjax")
	public void uploadAjax(){
		
	}
	
	//파일 업로드 Form
	@RequestMapping(value="/uploadForm", method=RequestMethod.POST)
	public void uploadFormPost(MultipartFile file) throws Exception{
		System.out.println("파일 사이즈:" + file.getSize());
		System.out.println("업로드 패스:" + path);
		System.out.println("파일타입:" + file.getContentType());
		System.out.println("파일명:" + file.getOriginalFilename());
		UUID uid = UUID.randomUUID(); // 파일명 중복회피
		String savedName = uid.toString() + "_" + file.getOriginalFilename();
		File target = new File(path, savedName);
		FileCopyUtils.copy(file.getBytes(), target);
	}
	
	//파일 업로드 Ajax
	@ResponseBody
	@RequestMapping(value="/uploadFile", method=RequestMethod.POST, produces="text/plain;charset=UTF-8")
	public String uploadAjaxPost(MultipartFile file) throws Exception{
		UUID uid = UUID.randomUUID(); // 파일명 중복회피
		String savedName = uid.toString() + "_" + file.getOriginalFilename();
		File target = new File(path, savedName);
		FileCopyUtils.copy(file.getBytes(), target);
		return savedName;
	}
	
	//이미지 출력
	@ResponseBody
	@RequestMapping("/displayFile")
	public byte[] display(String fullName) throws Exception{
		FileInputStream in = new FileInputStream(path + "/" + fullName);
		byte[] image = IOUtils.toByteArray(in);
		in.close();
		return image;
	}
	
	//파일삭제
	@ResponseBody
	@RequestMapping("/deleteFile")
	public void deleteFile(String fullName, int recipe_bno, int recipe_attach_no) throws Exception{		
		if(fullName!=null){
			dao.delAttach2(recipe_bno, recipe_attach_no);
			new File(path + "/" + recipe_bno + "/" + fullName).delete();
		}		
	}
	
	//중고거래 파일삭제
	@ResponseBody
	@RequestMapping("/trade_deleteFile")
	public void deleteFile(String fullName, int trade_bno) throws Exception{
		if(fullName!=null){
			tdao.delAttach2(fullName);
			new File(path + "/" + trade_bno + "/" + fullName).delete();
		}
		
	}
	
	//파일 다운로드
	@ResponseBody
	@RequestMapping(value = "/downloadFile")
	public ResponseEntity<byte[]> downloadFile(String fullName) throws Exception {
		ResponseEntity<byte[]> entity = null;
		FileInputStream in = null;
		try {
			in = new FileInputStream(path + "/" + fullName);
			fullName = fullName.substring(fullName.indexOf("_") + 1);
			HttpHeaders headers = new HttpHeaders();
			headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
			headers.add("Content-Disposition",
					"attachment;filename=\"" + new String(fullName.getBytes("UTF-8"), "ISO-8859-1") + "\"");
			entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in), headers, HttpStatus.CREATED);
		} catch (Exception e) {
			entity = new ResponseEntity<byte[]>(HttpStatus.BAD_REQUEST);
		} finally {
			in.close();
		}
		return entity;
	}
}

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

@Controller
public class UploadController {
	@Autowired
	RecipeDAO dao;
	
	@Resource(name="uploadPath")
	String path;
	
	@RequestMapping("/uploadForm")
	public void uploadForm(){
		
	}
	
	@RequestMapping("/uploadAjax")
	public void uploadAjax(){
		
	}
	
	//���� ���ε� Form
	@RequestMapping(value="/uploadForm", method=RequestMethod.POST)
	public void uploadFormPost(MultipartFile file) throws Exception{
		System.out.println("���� ������:" + file.getSize());
		System.out.println("���ε� �н�:" + path);
		System.out.println("����Ÿ��:" + file.getContentType());
		System.out.println("���ϸ�:" + file.getOriginalFilename());
		UUID uid = UUID.randomUUID(); // ���ϸ� �ߺ�ȸ��
		String savedName = uid.toString() + "_" + file.getOriginalFilename();
		File target = new File(path, savedName);
		FileCopyUtils.copy(file.getBytes(), target);
	}
	
	//���� ���ε� Ajax
	@ResponseBody
	@RequestMapping(value="/uploadFile", method=RequestMethod.POST, produces="text/plain;charset=UTF-8")
	public String uploadAjaxPost(MultipartFile file) throws Exception{
		UUID uid = UUID.randomUUID(); // ���ϸ� �ߺ�ȸ��
		String savedName = uid.toString() + "_" + file.getOriginalFilename();
		File target = new File(path, savedName);
		FileCopyUtils.copy(file.getBytes(), target);
		return savedName;
	}
	
	//�̹��� ���
	@ResponseBody
	@RequestMapping("/displayFile")
	public byte[] display(String fullName) throws Exception{
		FileInputStream in = new FileInputStream(path + "/" + fullName);
		byte[] image = IOUtils.toByteArray(in);
		in.close();
		return image;
	}
	
	//���� ����
		@ResponseBody
		@RequestMapping("/deleteFile")
		public void deleteFile(String fullName, int recipe_bno, int recipe_attach_no) throws Exception{		
			if(fullName!=null){
				dao.delAttach2(recipe_bno, recipe_attach_no);
				new File(path + "/" + recipe_bno + "/" + fullName).delete();
			}		
		}
	
	//���� �ٿ�ε�
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
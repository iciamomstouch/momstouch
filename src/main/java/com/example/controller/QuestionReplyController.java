package com.example.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.example.domain.Criteria;
import com.example.domain.QuestionReplyVO;
import com.example.persistence.QuestionReplyDAO;

	@Controller
	@RequestMapping("/question/")
	public class QuestionReplyController {
		@Autowired
		QuestionReplyDAO dao;
		
		@RequestMapping(value="list2", method=RequestMethod.GET)
		public ResponseEntity<List<QuestionReplyVO>> list(int question_bno){			
			return new ResponseEntity<>(dao.list(question_bno), HttpStatus.OK);
		}
		
		 @RequestMapping(value="insert2", method=RequestMethod.POST)
			 public ResponseEntity<String> insert(@RequestBody QuestionReplyVO vo){
			 try {
				 dao.insert(vo);
				 return new ResponseEntity<>("SUCCESS", HttpStatus.OK);
			 }catch(Exception e) {
				 return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
			 }
		 }
		 
		 @RequestMapping(value="delete2", method=RequestMethod.GET)
			 public ResponseEntity<String> delete(@PathVariable("question_rno") int question_rno){
			 try {
				 dao.delete(question_rno);
				 return new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
			 }catch(Exception e) {
				 return new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
			 }
		 }
		 
		 @RequestMapping(value="read2", method=RequestMethod.GET)
			 public ResponseEntity<QuestionReplyVO> read(@PathVariable("question_rno") int question_rno){
			 try {
				 return new ResponseEntity<>(dao.read(question_rno), HttpStatus.OK);
			 }catch(Exception e) {
				 return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
			 }
		 }
		 
		 @RequestMapping(value="update2", method= {RequestMethod.PUT, RequestMethod.PATCH})
			 public ResponseEntity<String> update(@PathVariable("question_rno") int question_rno, @RequestBody QuestionReplyVO vo){
			 try {
				 vo.setQuestion_rno(question_rno);
				 dao.update(vo);
				 return new ResponseEntity<>("SUCCESS",HttpStatus.OK);
			 }catch(Exception e) {
				 return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
			 }
		 }
}

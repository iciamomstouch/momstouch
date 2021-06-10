package com.example.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.example.domain.Criteria;
import com.example.domain.QuestionReplyVO;
import com.example.mapper.QuestionReplyMapper;

	@RestController
	@RequestMapping("/question/")
	public class QuestionReplyController {
		@Autowired
		QuestionReplyMapper questionreplyMapper;
		
		@RequestMapping("list", method=RequestMethod.GET)
		public ResponseEntity<List<QuestionReplyVO>> list(int question_bno, int page){
			Criteria cri=new Criteria();
			cri.setPage(page);
			return new ResponseEntity<>(questionreplyMapper.list(cri, question_bno), HttpStatus.OK);
		}
		
		 @RequestMapping(value="/insert", method=RequestMethod.POST)
			 public ResponseEntity<String> insert(@RequestBody QuestionReplyVO vo){
			 try {
				 questionreplyMapper.insert(vo);
				 return new ResponseEntity<>("SUCCESS", HttpStatus.OK);
			 }catch(Exception e) {
				 return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
			 }
		 }
		 
		 @RequestMapping(value="/{question_rno}", method=RequestMethod.DELETE)
			 public ResponseEntity<String> delete(@PathVariable("question_rno") int question_rno){
			 try {
				 questionreplyMapper.delete(question_rno);
				 return new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
			 }catch(Exception e) {
				 return new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
			 }
		 }
		 
		 @RequestMapping(value="/{question_rno}", method=RequestMethod.GET)
			 public ResponseEntity<QuestionReplyVO> read(@PathVariable("question_rno") int question_rno){
			 try {
				 return new ResponseEntity<>(QuestionReplyMapper.read(question_rno), HttpStatus.OK);
			 }catch(Exception e) {
				 return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
			 }
		 }
		 
		 @RequestMapping(value="/{question_rno}", method= {RequestMethod.PUT, RequestMethod.PATCH})
			 public ResponseEntity<String> update(@PathVariable("rno") int question_rno, @RequestBody QuestionReplyVO vo){
			 try {
				 vo.setQuestion_rno(question_rno);
				 questionreplyMapper.update(vo);
				 return new ResponseEntity<>("SUCCESS",HttpStatus.OK);
			 }catch(Exception e) {
				 return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
			 }
		 }
}

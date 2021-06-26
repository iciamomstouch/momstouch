package com.example.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.domain.Info_replyVO;
import com.example.persistence.InfoDAO;
import com.example.persistence.Info_replyDAO;

@Service
public class Info_replyServiceImpl implements Info_replyService{
	@Autowired
	InfoDAO dao;
	
	@Autowired
	Info_replyDAO rdao;
	
	@Transactional
	@Override
	public void insert(Info_replyVO vo) throws Exception {
		dao.updateReply(vo.getInfo_bno(), 1);
		rdao.insert(vo);		
	}
	
	@Transactional
	@Override
	public void delete(int info_rno) throws Exception {
		Info_replyVO vo = rdao.read(info_rno);
		dao.updateReply(vo.getInfo_bno(), -1);	
		rdao.delete(info_rno);			
	}
	
}

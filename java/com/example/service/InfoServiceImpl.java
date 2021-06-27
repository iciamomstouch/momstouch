package com.example.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.domain.InfoVO;
import com.example.persistence.InfoDAO;

@Service
public class InfoServiceImpl implements InfoService{
	
	@Autowired
	InfoDAO dao;
	
	@Transactional
	@Override
	public InfoVO read(int info_bno) throws Exception {
		dao.updateViewCnt(info_bno);
		InfoVO vo = dao.read(info_bno);		
		return vo;
	}

}

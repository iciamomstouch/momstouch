package com.example.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import com.example.domain.TradeVO;
import com.example.persistence.TradeDAO;

@Service
public class TradeServiceImpl implements TradeService {
	@Autowired
	TradeDAO dao;
	
	//게시물 조회
	@Transactional(isolation = Isolation.READ_COMMITTED)
	@Override
	public TradeVO read(int trade_bno) throws Exception {
		dao.updateViewcnt(trade_bno);
		return dao.read(trade_bno);
	}

}

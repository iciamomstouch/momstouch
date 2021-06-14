package com.example.service;

import java.util.ArrayList;

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
	
	@Override
	public void updateViewcnt(int trade_bno) throws Exception {
		dao.updateViewcnt(trade_bno);
	}

	@Override
	public void insert(TradeVO vo) throws Exception {
		dao.insert(vo);
		System.out.println(vo.toString());
		ArrayList<String> images = vo.getImages();
		if(images==null) return;
		for(String image:images){
			dao.addAttach(image, vo.getTrade_bno());
		   }
	}
}

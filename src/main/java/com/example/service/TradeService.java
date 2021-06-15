package com.example.service;

import com.example.domain.TradeVO;

public interface TradeService {
	public TradeVO read(int trade_bno) throws Exception;
	public void insert(TradeVO vo) throws Exception;
}

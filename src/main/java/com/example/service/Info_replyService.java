package com.example.service;

import com.example.domain.Info_replyVO;

public interface Info_replyService {
	public void insert(Info_replyVO vo) throws Exception;
	public void delete(int info_rno) throws Exception;
}

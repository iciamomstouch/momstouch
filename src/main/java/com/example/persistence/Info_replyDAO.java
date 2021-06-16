package com.example.persistence;

import java.util.List;

import com.example.domain.Info_replyVO;

public interface Info_replyDAO {
	public List<Info_replyVO> rlist(int info_bno) throws Exception;
}

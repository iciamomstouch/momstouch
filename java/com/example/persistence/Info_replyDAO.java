package com.example.persistence;

import java.util.List;

import com.example.domain.Info_replyVO;

public interface Info_replyDAO {
	public List<Info_replyVO> rlist(int info_bno) throws Exception;
	public int totalCount(int info_bno) throws Exception;
	public void insert(Info_replyVO vo) throws Exception;
	public void delete(int info_rno) throws Exception;
	public Info_replyVO read(int info_rno) throws Exception;
}

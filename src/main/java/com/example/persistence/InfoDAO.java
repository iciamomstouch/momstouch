package com.example.persistence;

import java.util.List;

import org.apache.ibatis.annotations.Param;


import com.example.domain.Criteria;
import com.example.domain.InfoVO;


public interface InfoDAO {
	public List<InfoVO> list(Criteria cri) throws Exception;
	public void insert(InfoVO vo) throws Exception;
	public InfoVO read(int info_bno) throws Exception;
	public void delete(int info_bno) throws Exception;
	public void update(InfoVO vo) throws Exception;
	public void updateViewCnt(int info_bno);
	
}

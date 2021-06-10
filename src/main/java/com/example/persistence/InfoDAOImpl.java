package com.example.persistence;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


import com.example.domain.Criteria;
import com.example.domain.InfoVO;



@Repository
public class InfoDAOImpl implements InfoDAO{
	String namespace="com.example.mapper.InfoMapper";
	@Autowired
	SqlSession session;
	@Override
	public List<InfoVO> list(Criteria cri) throws Exception {
		return  session.selectList(namespace+ ".list", cri);
	}
	@Override
	public void insert(InfoVO vo) throws Exception {
		// TODO Auto-generated method stub
		
	}
	@Override
	public InfoVO read(int info_bno) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public void delete(int info_bno) throws Exception {
		// TODO Auto-generated method stub
		
	}
	@Override
	public void update(InfoVO vo) throws Exception {
		// TODO Auto-generated method stub
		
	}
	@Override
	public void updateViewCnt(int info_bno) {
		// TODO Auto-generated method stub
		
	}
	

	
	
	

	
}

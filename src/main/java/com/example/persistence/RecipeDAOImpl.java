package com.example.persistence;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.domain.Criteria;
import com.example.domain.RecipeVO;

@Repository
public class RecipeDAOImpl implements RecipeDAO{
	String namespace="com.example.mapper.RecipeMapper";
	
	@Autowired
	SqlSession session;

	@Override
	public List<RecipeVO> list(Criteria cri) throws Exception {		
		return session.selectList(namespace + ".list", cri);
	}

	@Override
	public int totalCount() throws Exception {		
		return session.selectOne(namespace + ".totalCount");
	}

}

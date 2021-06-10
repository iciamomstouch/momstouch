package com.example.persistence;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.domain.Criteria;
import com.example.domain.RecipeVO;
import com.example.domain.Recipe_attachVO;

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

	@Override
	public RecipeVO read(int recipe_bno) throws Exception {		
		return session.selectOne(namespace + ".read", recipe_bno);
	}

	@Override
	public void insert(RecipeVO vo) throws Exception {
		session.insert(namespace + ".insert", vo);		
	}

	@Override
	public void update(RecipeVO vo) throws Exception {
		session.update(namespace + ".update", vo);		
	}

	@Override
	public void delete(int recipe_bno) throws Exception {
		session.delete(namespace + ".delete", recipe_bno);		
	}

	@Override
	public List<Recipe_attachVO> getAttach(int recipe_bno) throws Exception {		
		return session.selectList(namespace + ".getAttach", recipe_bno);
	}

}

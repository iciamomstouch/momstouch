package com.example.persistence;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.domain.Recipe_replyVO;

@Repository
public class Recipe_replyDAOImpl implements Recipe_replyDAO {
	String namespace="com.example.mapper.Recipe_replyMapper";
	
	@Autowired
	SqlSession session;

	@Override
	public List<Recipe_replyVO> rlist(int recipe_bno) throws Exception {		
		return session.selectList(namespace + ".rlist", recipe_bno);
	}

	@Override
	public void insert(Recipe_replyVO vo) throws Exception {
		session.insert(namespace + ".insert", vo);
		
	}

	@Override
	public void delete(int recipe_rno) throws Exception {
		session.delete(namespace + ".delete", recipe_rno);
		
	}

	@Override
	public Recipe_replyVO read(int recipe_rno) throws Exception {
		return session.selectOne(namespace + ".read", recipe_rno);
	}

	@Override
	public void deleteAll(int recipe_bno) throws Exception {
		session.delete(namespace + ".deleteAll", recipe_bno);		
	}

}

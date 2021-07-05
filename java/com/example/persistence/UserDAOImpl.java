package com.example.persistence;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.domain.Criteria;
import com.example.domain.UserVO;

@Repository
public class UserDAOImpl implements UserDAO {
	String namespace="com.example.mapper.UserMapper";
	
	@Autowired
	SqlSession session;

	@Override
	public List<UserVO> list(Criteria cri) throws Exception {		
		return session.selectList(namespace + ".list", cri);
	}

	@Override
	public int totalCount(Criteria cri) throws Exception {		
		return session.selectOne(namespace + ".totalCount", cri);
	}

	@Override
	public UserVO read(String user_id) throws Exception {		
		return session.selectOne(namespace + ".read", user_id);
	}

	@Override
	public void insert(UserVO vo) throws Exception {
		session.insert(namespace + ".insert", vo);		
	}

	@Override
	public void update(UserVO vo) throws Exception {
		session.update(namespace + ".update", vo);		
	}

	@Override
	public void delete(String user_id) throws Exception {
		session.delete(namespace + ".delete", user_id);
		
	}

	@Override
	public UserVO login(String user_id) throws Exception {		
		return session.selectOne(namespace + ".login", user_id);
	}

	@Override
	public void update2(String user_id) throws Exception {
		session.update(namespace + ".update2", user_id);	
		
	}
}

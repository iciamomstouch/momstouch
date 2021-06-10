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
	public int totalCount() throws Exception {		
		return session.selectOne(namespace + ".totalCount");
	}

}

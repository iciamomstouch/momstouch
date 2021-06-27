package com.example.persistence;

import java.util.List;

import com.example.domain.Criteria;
import com.example.domain.UserVO;

public interface UserDAO {
	public List<UserVO> list(Criteria cri) throws Exception;
	public int totalCount(Criteria cri) throws Exception;
	public UserVO read(String user_id) throws Exception;
	public void insert(UserVO vo) throws Exception;
	public void update(UserVO vo) throws Exception;
	public void delete(String user_id) throws Exception;
	public UserVO login(String user_id) throws Exception;
}

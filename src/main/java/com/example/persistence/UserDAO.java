package com.example.persistence;

import java.util.List;

import com.example.domain.Criteria;
import com.example.domain.UserVO;

public interface UserDAO {
	public List<UserVO> list(Criteria cri) throws Exception;
	public int totalCount() throws Exception;
}

package com.example.persistence;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.example.domain.Criteria;
import com.example.domain.InfoVO;
import com.example.domain.User_keepVO;

public interface InfoDAO {
	public List<InfoVO> list(Criteria cri) throws Exception;
	public int totalCount(Criteria cri) throws Exception;
	public void insert(InfoVO vo) throws Exception;
	public InfoVO read(int info_bno) throws Exception;
	public void delete(int info_bno) throws Exception;
	public void update(InfoVO vo) throws Exception;
	public void updateViewCnt(int info_bno);
	public void updateReply(@Param("info_bno")int info_bno, @Param("amount") int amount);
	public User_keepVO keepRead(@Param("info_bno")int info_bno, @Param("user_id")String user_id) throws Exception;
	public void keepInsert(User_keepVO vo) throws Exception;
	public void keepUpdate(User_keepVO vo) throws Exception;
	public List<InfoVO> klist(@Param("pageStart")int pageStart, @Param("perPageNum")int perPageNum, @Param("user_id")String user_id) throws Exception;
	public String nextNum(int info_bno) throws Exception;
	public String preNum(int info_bno) throws Exception;
	public String maxNum() throws Exception;
	public String minNum() throws Exception;
}

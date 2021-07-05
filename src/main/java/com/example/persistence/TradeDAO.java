package com.example.persistence;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.example.domain.ChatVO;
import com.example.domain.Criteria;
import com.example.domain.TradeVO;
import com.example.domain.Trade_attachVO;
import com.example.domain.User_keepVO;

public interface TradeDAO {
	public List<TradeVO> list(Criteria cri) throws Exception;
	public int totalCount(Criteria cri) throws Exception;
	public TradeVO read(int trade_bno) throws Exception;
	public void insert(TradeVO vo) throws Exception;
	public void delete(int trade_bno)throws Exception;
	public void update(TradeVO vo) throws Exception;
	public void addAttach(@Param("trade_attach_image") String trade_attach_image, @Param("trade_bno") int trade_bno) throws Exception;
	public List<Trade_attachVO> getAttach(int trade_bno) throws Exception;
	public void updateViewcnt(int trade_bno) throws Exception;
	public int lastBno() throws Exception;	
	public void delAttach(int trade_bno) throws Exception;
	public void delAttach2(String trade_attach_image) throws Exception;
	public List<TradeVO> ulist(@Param("pageStart")int pageStart, @Param("perPageNum")int perPageNum, @Param("trade_writer")String trade_writer) throws Exception;
	public List<TradeVO> klist(@Param("pageStart")int pageStart, @Param("perPageNum")int perPageNum, @Param("user_id")String user_id) throws Exception;
	public User_keepVO keepRead(@Param("trade_bno")int trade_bno, @Param("user_id")String user_id) throws Exception;
	public void keepInsert(User_keepVO vo) throws Exception;
	public void keepUpdate(User_keepVO vo) throws Exception;
	public String nextNum(int trade_bno) throws Exception;
	public String preNum(int trade_bno) throws Exception;
	public String maxNum() throws Exception;
	public String minNum() throws Exception;
	public List<ChatVO> clist(String user_id) throws Exception;
}

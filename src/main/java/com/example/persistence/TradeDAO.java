package com.example.persistence;

import java.util.List;

import org.apache.ibatis.annotations.Param;
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
	public List<User_keepVO> keep(int trade_bno) throws Exception;
	public void delAttach(int trade_bno) throws Exception;
	public void delAttach2(String trade_attach_image) throws Exception;
}

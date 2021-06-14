package com.example.domain;

import java.util.ArrayList;
import java.util.Date;

public class Trade_attachVO {
	private String trade_attach_image;
	private int trade_bno;
	private Date regDate;
	public String getTrade_attach_image() {
		return trade_attach_image;
	}
	public void setTrade_attach_image(String trade_attach_image) {
		this.trade_attach_image = trade_attach_image;
	}
	public int getTrade_bno() {
		return trade_bno;
	}
	public void setTrade_bno(int trade_bno) {
		this.trade_bno = trade_bno;
	}
	public Date getRegDate() {
		return regDate;
	}
	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}
	@Override
	public String toString() {
		return "Trade_attachVO [trade_attach_image=" + trade_attach_image + ", trade_bno=" + trade_bno + ", regDate="
				+ regDate + "]";
	}

}
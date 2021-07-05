package com.example.domain;

import java.util.ArrayList;
import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

public class TradeVO extends User_keepVO{
	private int trade_bno;
	private String trade_title;
	private String trade_category;
	private String trade_content;
	private String trade_writer;
	private String trade_image;
	private int trade_price;
	
	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss", timezone="Asia/Seoul")
	private Date trade_regdate;
	
	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss", timezone="Asia/Seoul")
	private Date trade_updatedate;
	private int trade_viewcnt;
	private ArrayList<String> images;
	public int getTrade_bno() {
		return trade_bno;
	}
	public void setTrade_bno(int trade_bno) {
		this.trade_bno = trade_bno;
	}
	public String getTrade_title() {
		return trade_title;
	}
	public void setTrade_title(String trade_title) {
		this.trade_title = trade_title;
	}
	public String getTrade_category() {
		return trade_category;
	}
	public void setTrade_category(String trade_category) {
		this.trade_category = trade_category;
	}
	public String getTrade_content() {
		return trade_content;
	}
	public void setTrade_content(String trade_content) {
		this.trade_content = trade_content;
	}
	public String getTrade_writer() {
		return trade_writer;
	}
	public void setTrade_writer(String trade_writer) {
		this.trade_writer = trade_writer;
	}
	public String getTrade_image() {
		return trade_image;
	}
	public void setTrade_image(String trade_image) {
		this.trade_image = trade_image;
	}
	public int getTrade_price() {
		return trade_price;
	}
	public void setTrade_price(int trade_price) {
		this.trade_price = trade_price;
	}
	public Date getTrade_regdate() {
		return trade_regdate;
	}
	public void setTrade_regdate(Date trade_regdate) {
		this.trade_regdate = trade_regdate;
	}
	public Date getTrade_updatedate() {
		return trade_updatedate;
	}
	public void setTrade_updatedate(Date trade_updatedate) {
		this.trade_updatedate = trade_updatedate;
	}
	public int getTrade_viewcnt() {
		return trade_viewcnt;
	}
	public void setTrade_viewcnt(int trade_viewcnt) {
		this.trade_viewcnt = trade_viewcnt;
	}
	public ArrayList<String> getImages() {
		return images;
	}
	public void setImages(ArrayList<String> images) {
		this.images = images;
	}
	@Override
	public String toString() {
		return "TradeVO [trade_bno=" + trade_bno + ", trade_title=" + trade_title + ", trade_category=" + trade_category
				+ ", trade_content=" + trade_content + ", trade_writer=" + trade_writer + ", trade_image=" + trade_image
				+ ", trade_price=" + trade_price + ", trade_regdate=" + trade_regdate + ", trade_updatedate="
				+ trade_updatedate + ", trade_viewcnt=" + trade_viewcnt + ", images=" + images + "]";
	}
	
}
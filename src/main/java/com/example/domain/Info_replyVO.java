package com.example.domain;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

public class Info_replyVO {
	private int Info_rno;
	private int Info_bno;
	private String Info_reply;
	private String Info_replyer;
	@JsonFormat(pattern="yyyy-MM-dd hh:mm:ss", timezone="Asia/Seoul")
	private Date Info_replydate;
	
	public int getInfo_rno() {
		return Info_rno;
	}
	public void setInfo_rno(int info_rno) {
		Info_rno = info_rno;
	}
	public int getInfo_bno() {
		return Info_bno;
	}
	public void setInfo_bno(int info_bno) {
		Info_bno = info_bno;
	}
	public String getInfo_reply() {
		return Info_reply;
	}
	public void setInfo_reply(String info_reply) {
		Info_reply = info_reply;
	}
	public String getInfo_replyer() {
		return Info_replyer;
	}
	public void setInfo_replyer(String info_replyer) {
		Info_replyer = info_replyer;
	}
	public Date getInfo_replydate() {
		return Info_replydate;
	}
	public void setInfo_replydate(Date info_replydate) {
		Info_replydate = info_replydate;
	}
	
	@Override
	public String toString() {
		return "Info_replyVO [Info_rno=" + Info_rno + ", Info_bno=" + Info_bno + ", Info_reply=" + Info_reply
				+ ", Info_replyer=" + Info_replyer + ", Info_replydate=" + Info_replydate + "]";
	}	
}

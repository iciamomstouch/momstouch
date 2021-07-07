package com.example.domain;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

public class Info_replyVO {
	private int Info_rno;
	private int Info_bno;
	private String Info_reply;
	private String Info_replyer;
	
	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss", timezone="Asia/Seoul")
	private Date info_replydate;
	
	private String user_nick;
	private String user_type;
	
	public Date getInfo_replydate() {
		return info_replydate;
	}

	public void setInfo_replydate(Date info_replydate) {
		this.info_replydate = info_replydate;
	}

	public String getUser_nick() {
		return user_nick;
	}

	public void setUser_nick(String user_nick) {
		this.user_nick = user_nick;
	}

	public String getUser_type() {
		return user_type;
	}

	public void setUser_type(String user_type) {
		this.user_type = user_type;
	}

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


	@Override
	public String toString() {
		return "Info_replyVO [Info_rno=" + Info_rno + ", Info_bno=" + Info_bno + ", Info_reply=" + Info_reply
				+ ", Info_replyer=" + Info_replyer + ", info_replydate=" + info_replydate + ", user_nick=" + user_nick
				+ ", user_type=" + user_type + "]";
	}

	
}

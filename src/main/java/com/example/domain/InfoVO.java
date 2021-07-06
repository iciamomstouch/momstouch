package com.example.domain;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

public class InfoVO extends User_keepVO{
	private int info_bno;
	private String info_title;
	private String info_content;
	private String info_image;
	private String info_writer;
	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss", timezone="Asia/Seoul")
	private Date info_regdate;
	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss", timezone="Asia/Seoul")
	private Date info_updatedate;
	private String info_viewcnt;
	private String info_replycnt;
	private String user_nick;
	
	public String getUser_nick() {
		return user_nick;
	}
	public void setUser_nick(String user_nick) {
		this.user_nick = user_nick;
	}
	public int getInfo_bno() {
		return info_bno;
	}
	public void setInfo_bno(int info_bno) {
		this.info_bno = info_bno;
	}
	public String getInfo_title() {
		return info_title;
	}
	public void setInfo_title(String info_title) {
		this.info_title = info_title;
	}
	public String getInfo_content() {
		return info_content;
	}
	public void setInfo_content(String info_content) {
		this.info_content = info_content;
	}
	public String getInfo_image() {
		return info_image;
	}
	public void setInfo_image(String info_image) {
		this.info_image = info_image;
	}
	public String getInfo_writer() {
		return info_writer;
	}
	public void setInfo_writer(String info_writer) {
		this.info_writer = info_writer;
	}	
	public Date getInfo_regdate() {
		return info_regdate;
	}
	public void setInfo_regdate(Date info_regdate) {
		this.info_regdate = info_regdate;
	}
	public Date getInfo_updatedate() {
		return info_updatedate;
	}
	public void setInfo_updatedate(Date info_updatedate) {
		this.info_updatedate = info_updatedate;
	}
	public String getInfo_viewcnt() {
		return info_viewcnt;
	}
	public void setInfo_viewcnt(String info_viewcnt) {
		this.info_viewcnt = info_viewcnt;
	}
	public String getInfo_replycnt() {
		return info_replycnt;
	}
	public void setInfo_replycnt(String info_replycnt) {
		this.info_replycnt = info_replycnt;
	}
	@Override
	public String toString() {
		return "InfoVO [info_bno=" + info_bno + ", info_title=" + info_title + ", info_content=" + info_content
				+ ", info_image=" + info_image + ", info_writer=" + info_writer + ", info_regdate=" + info_regdate
				+ ", info_updatedate=" + info_updatedate + ", info_viewcnt=" + info_viewcnt + ", info_replycnt="
				+ info_replycnt + ", user_nick=" + user_nick + "]";
	}
}

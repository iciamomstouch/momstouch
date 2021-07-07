package com.example.domain;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

public class QuestionVO {
	private int question_bno;
	private int question_grpno;
	private int  question_grpord;
	private int question_depth;
	private String question_title;
	private String question_content;
	private String question_image;
	private String question_writer;
	private String user_nick;
	
	@JsonFormat(pattern="MM-dd HH:mm", timezone="Asia/Seoul")
	private Date question_regdate;
	
	@JsonFormat(pattern="MM-dd HH:mm", timezone="Asia/Seoul")
	private Date question_updatedate;
	private int question_viewcnt;
	
	public String getUser_nick() {
		return user_nick;
	}
	public void setUser_nick(String user_nick) {
		this.user_nick = user_nick;
	}
	public int getQuestion_bno() {
		return question_bno;
	}
	public void setQuestion_bno(int question_bno) {
		this.question_bno = question_bno;
	}
	public int getQuestion_grpno() {
		return question_grpno;
	}
	public void setQuestion_grpno(int question_grpno) {
		this.question_grpno = question_grpno;
	}
	public int getQuestion_grpord() {
		return question_grpord;
	}
	public void setQuestion_grpord(int question_grpord) {
		this.question_grpord = question_grpord;
	}
	public int getQuestion_depth() {
		return question_depth;
	}
	public void setQuestion_depth(int question_depth) {
		this.question_depth = question_depth;
	}
	public String getQuestion_title() {
		return question_title;
	}
	public void setQuestion_title(String question_title) {
		this.question_title = question_title;
	}
	public String getQuestion_content() {
		return question_content;
	}
	public void setQuestion_content(String question_content) {
		this.question_content = question_content;
	}
	public String getQuestion_image() {
		return question_image;
	}
	public void setQuestion_image(String question_image) {
		this.question_image = question_image;
	}
	public String getQuestion_writer() {
		return question_writer;
	}
	public void setQuestion_writer(String question_writer) {
		this.question_writer = question_writer;
	}
	public Date getQuestion_regdate() {
		return question_regdate;
	}
	public void setQuestion_regdate(Date question_regdate) {
		this.question_regdate = question_regdate;
	}
	public Date getQuestion_updatedate() {
		return question_updatedate;
	}
	public void setQuestion_updatedate(Date question_updatedate) {
		this.question_updatedate = question_updatedate;
	}
	public int getQuestion_viewcnt() {
		return question_viewcnt;
	}
	public void setQuestion_viewcnt(int question_viewcnt) {
		this.question_viewcnt = question_viewcnt;
	}
	@Override
	public String toString() {
		return "QuestionVO [question_bno=" + question_bno + ", question_grpno=" + question_grpno + ", question_grpord="
				+ question_grpord + ", question_depth=" + question_depth + ", question_title=" + question_title
				+ ", question_content=" + question_content + ", question_image=" + question_image + ", question_writer="
				+ question_writer + ", user_nick=" + user_nick + ", question_regdate=" + question_regdate
				+ ", question_updatedate=" + question_updatedate + ", question_viewcnt=" + question_viewcnt + "]";
	}
	

}

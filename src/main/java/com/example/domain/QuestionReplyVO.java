package com.example.domain;

import java.sql.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

public class QuestionReplyVO {
	private int question_rno;
	private int question_bno;
	private String question_reply;
	private String question_reply_image;
	private String question_replyer;
	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss", timezone="Asia/Seoul")
	private Date question_replydate;
	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss", timezone="Asia/Seoul")
	private Date question_replyupdate_date;
	
	public int getQuestion_rno() {
		return question_rno;
	}
	public void setQuestion_rno(int question_rno) {
		this.question_rno = question_rno;
	}
	public int getQuestion_bno() {
		return question_bno;
	}
	public void setQuestion_bno(int question_bno) {
		this.question_bno = question_bno;
	}
	public String getQuestion_reply() {
		return question_reply;
	}
	public void setQuestion_reply(String question_reply) {
		this.question_reply = question_reply;
	}
	public String getQuestion_reply_image() {
		return question_reply_image;
	}
	public void setQuestion_reply_image(String question_reply_image) {
		this.question_reply_image = question_reply_image;
	}
	public String getQuestion_replyer() {
		return question_replyer;
	}
	public void setQuestion_replyer(String question_replyer) {
		this.question_replyer = question_replyer;
	}
	public Date getQuestion_replydate() {
		return question_replydate;
	}
	public void setQuestion_replydate(Date question_replydate) {
		this.question_replydate = question_replydate;
	}
	public Date getQuestion_replyupdate_date() {
		return question_replyupdate_date;
	}
	public void setQuestion_replyupdate_date(Date question_replyupdate_date) {
		this.question_replyupdate_date = question_replyupdate_date;
	}
	
	@Override
	public String toString() {
		return "QuestionReplyVO [question_rno=" + question_rno + ", question_bno=" + question_bno + ", question_reply="
				+ question_reply + ", question_reply_image=" + question_reply_image + ", question_replyer="
				+ question_replyer + ", question_replydate=" + question_replydate + ", question_replyupdate_date="
				+ question_replyupdate_date + "]";
	}
	
	
}

package com.example.domain;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

public class Board_replyVO {
	private int board_rno;
	private int board_bno;
	private String board_reply;
	private String board_replyer;
	@JsonFormat(pattern="yyyy-MM-dd hh:mm:ss", timezone="Asia/Seoul")
	private Date board_replydate;
	
	public int getBoard_rno() {
		return board_rno;
	}
	public void setBoard_rno(int board_rno) {
		this.board_rno = board_rno;
	}
	public int getBoard_bno() {
		return board_bno;
	}
	public void setBoard_bno(int board_bno) {
		this.board_bno = board_bno;
	}
	public String getBoard_reply() {
		return board_reply;
	}
	public void setBoard_reply(String board_reply) {
		this.board_reply = board_reply;
	}
	public String getBoard_replyer() {
		return board_replyer;
	}
	public void setBoard_replyer(String board_replyer) {
		this.board_replyer = board_replyer;
	}
	public Date getBoard_replydate() {
		return board_replydate;
	}
	public void setBoard_replydate(Date board_replydate) {
		this.board_replydate = board_replydate;
	}
	
	@Override
	public String toString() {
		return "Board_replyVO [board_rno=" + board_rno + ", board_bno=" + board_bno + ", board_reply=" + board_reply
				+ ", board_replyer=" + board_replyer + ", board_replydate=" + board_replydate + "]";
	}
}

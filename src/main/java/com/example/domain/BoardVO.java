package com.example.domain;

public class BoardVO {
	private int board_bno;
	private String board_title;
	private String board_category;
	private String board_content;
	private String board_image;
	private String board_writer;
	private String board_regdate;
	private String board_updatedate;
	private String board_viewcnt;
	private String board_replycnt;
	
	public int getBoard_bno() {
		return board_bno;
	}
	public void setBoard_bno(int board_bno) {
		this.board_bno = board_bno;
	}
	public String getBoard_title() {
		return board_title;
	}
	public void setBoard_title(String board_title) {
		this.board_title = board_title;
	}
	public String getBoard_category() {
		return board_category;
	}
	public void setBoard_category(String board_category) {
		this.board_category = board_category;
	}
	public String getBoard_content() {
		return board_content;
	}
	public void setBoard_content(String board_content) {
		this.board_content = board_content;
	}
	public String getBoard_image() {
		return board_image;
	}
	public void setBoard_image(String board_image) {
		this.board_image = board_image;
	}
	public String getBoard_writer() {
		return board_writer;
	}
	public void setBoard_writer(String board_writer) {
		this.board_writer = board_writer;
	}
	public String getBoard_regdate() {
		return board_regdate;
	}
	public void setBoard_regdate(String board_regdate) {
		this.board_regdate = board_regdate;
	}
	public String getBoard_updatedate() {
		return board_updatedate;
	}
	public void setBoard_updatedate(String board_updatedate) {
		this.board_updatedate = board_updatedate;
	}
	public String getBoard_viewcnt() {
		return board_viewcnt;
	}
	public void setBoard_viewcnt(String board_viewcnt) {
		this.board_viewcnt = board_viewcnt;
	}
	public String getBoard_replycnt() {
		return board_replycnt;
	}
	public void setBoard_replycnt(String board_replycnt) {
		this.board_replycnt = board_replycnt;
	}
	
	@Override
	public String toString() {
		return "BoardVO [board_bno=" + board_bno + ", board_title=" + board_title + ", board_category=" + board_category
				+ ", board_content=" + board_content + ", board_image=" + board_image + ", board_writer=" + board_writer
				+ ", board_regdate=" + board_regdate + ", board_updatedate=" + board_updatedate + ", board_viewcnt="
				+ board_viewcnt + ", board_replycnt=" + board_replycnt + "]";
	}
	
	
	

}
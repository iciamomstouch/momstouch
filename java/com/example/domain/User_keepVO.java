package com.example.domain;

public class User_keepVO {
	private int user_keep_no;
	private String user_id;
	private int board_bno;
	private int board_keep;
	private int info_bno;
	private int info_keep;
	private int trade_bno;
	private int trade_keep;
	private int recipe_bno;
	private int recipe_keep;
	
	public int getUser_keep_no() {
		return user_keep_no;
	}
	public void setUser_keep_no(int user_keep_no) {
		this.user_keep_no = user_keep_no;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public int getBoard_bno() {
		return board_bno;
	}
	public void setBoard_bno(int board_bno) {
		this.board_bno = board_bno;
	}
	public int getBoard_keep() {
		return board_keep;
	}
	public void setBoard_keep(int board_keep) {
		this.board_keep = board_keep;
	}
	public int getInfo_bno() {
		return info_bno;
	}
	public void setInfo_bno(int info_bno) {
		this.info_bno = info_bno;
	}
	public int getInfo_keep() {
		return info_keep;
	}
	public void setInfo_keep(int info_keep) {
		this.info_keep = info_keep;
	}
	public int getTrade_bno() {
		return trade_bno;
	}
	public void setTrade_bno(int trade_bno) {
		this.trade_bno = trade_bno;
	}
	public int getTrade_keep() {
		return trade_keep;
	}
	public void setTrade_keep(int trade_keep) {
		this.trade_keep = trade_keep;
	}
	public int getRecipe_bno() {
		return recipe_bno;
	}
	public void setRecipe_bno(int recipe_bno) {
		this.recipe_bno = recipe_bno;
	}
	public int getRecipe_keep() {
		return recipe_keep;
	}
	public void setRecipe_keep(int recipe_keep) {
		this.recipe_keep = recipe_keep;
	}
	@Override
	public String toString() {
		return "User_keepVO [user_keep_no=" + user_keep_no + ", user_id=" + user_id + ", board_bno=" + board_bno
				+ ", board_keep=" + board_keep + ", info_bno=" + info_bno + ", info_keep=" + info_keep + ", trade_bno="
				+ trade_bno + ", trade_keep=" + trade_keep + ", recipe_bno=" + recipe_bno + ", recipe_keep="
				+ recipe_keep + "]";
	}
}

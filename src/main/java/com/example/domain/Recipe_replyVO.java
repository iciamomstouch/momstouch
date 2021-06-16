package com.example.domain;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

public class Recipe_replyVO {
	private int recipe_rno;
	private int recipe_bno;
	private String recipe_reply;
	private double recipe_userRating;
	
	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss", timezone="Asia/Seoul")
	private Date recipe_replydate;
	
	public int getRecipe_rno() {
		return recipe_rno;
	}
	public void setRecipe_rno(int recipe_rno) {
		this.recipe_rno = recipe_rno;
	}
	public int getRecipe_bno() {
		return recipe_bno;
	}
	public void setRecipe_bno(int recipe_bno) {
		this.recipe_bno = recipe_bno;
	}
	public String getRecipe_reply() {
		return recipe_reply;
	}
	public void setRecipe_reply(String recipe_reply) {
		this.recipe_reply = recipe_reply;
	}
	public double getRecipe_userRating() {
		return recipe_userRating;
	}
	public void setRecipe_userRating(double recipe_userRating) {
		this.recipe_userRating = recipe_userRating;
	}
	public Date getRecipe_replydate() {
		return recipe_replydate;
	}
	public void setRecipe_replydate(Date recipe_replydate) {
		this.recipe_replydate = recipe_replydate;
	}
	
	@Override
	public String toString() {
		return "Recipe_replyVO [recipe_rno=" + recipe_rno + ", recipe_bno=" + recipe_bno + ", recipe_reply="
				+ recipe_reply + ", recipe_userRating=" + recipe_userRating + ", recipe_replydate=" + recipe_replydate
				+ "]";
	}	
}

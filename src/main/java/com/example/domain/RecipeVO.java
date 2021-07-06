package com.example.domain;

import java.util.ArrayList;
import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

public class RecipeVO extends User_keepVO{
	private int recipe_bno;
	private String recipe_title;
	private String recipe_category;
	private String recipe_ingre;
	private String recipe_seasoning;
	private String recipe_content;
	private String recipe_writer;
	private String recipe_image;
	private String user_nick;
	
	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss", timezone="Asia/Seoul")
	private Date recipe_regdate;
	
	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss", timezone="Asia/Seoul")
	private String recipe_updatedate;
	private int recipe_viewcnt;	
	private double recipe_userRatingAvg;
	private ArrayList<String> recipe_attach_no;
	private ArrayList<String> images;
	private ArrayList<String> recipe_attach_text;
	
	public String getUser_nick() {
		return user_nick;
	}
	public void setUser_nick(String user_nick) {
		this.user_nick = user_nick;
	}
	public ArrayList<String> getRecipe_attach_text() {
		return recipe_attach_text;
	}
	public void setRecipe_attach_text(ArrayList<String> recipe_attach_text) {
		this.recipe_attach_text = recipe_attach_text;
	}
	public ArrayList<String> getRecipe_attach_no() {
		return recipe_attach_no;
	}
	public void setRecipe_attach_no(ArrayList<String> recipe_attach_no) {
		this.recipe_attach_no = recipe_attach_no;
	}
	public int getRecipe_bno() {
		return recipe_bno;
	}
	public void setRecipe_bno(int recipe_bno) {
		this.recipe_bno = recipe_bno;
	}
	public String getRecipe_title() {
		return recipe_title;
	}
	public void setRecipe_title(String recipe_title) {
		this.recipe_title = recipe_title;
	}
	public String getRecipe_category() {
		return recipe_category;
	}
	public void setRecipe_category(String recipe_category) {
		this.recipe_category = recipe_category;
	}
	public String getRecipe_ingre() {
		return recipe_ingre;
	}
	public void setRecipe_ingre(String recipe_ingre) {
		this.recipe_ingre = recipe_ingre;
	}
	public String getRecipe_seasoning() {
		return recipe_seasoning;
	}
	public void setRecipe_seasoning(String recipe_seasoning) {
		this.recipe_seasoning = recipe_seasoning;
	}
	public String getRecipe_content() {
		return recipe_content;
	}
	public void setRecipe_content(String recipe_content) {
		this.recipe_content = recipe_content;
	}
	public String getRecipe_writer() {
		return recipe_writer;
	}
	public void setRecipe_writer(String recipe_writer) {
		this.recipe_writer = recipe_writer;
	}
	public String getRecipe_image() {
		return recipe_image;
	}
	public void setRecipe_image(String recipe_image) {
		this.recipe_image = recipe_image;
	}
	public Date getRecipe_regdate() {
		return recipe_regdate;
	}
	public void setRecipe_regdate(Date recipe_regdate) {
		this.recipe_regdate = recipe_regdate;
	}
	public String getRecipe_updatedate() {
		return recipe_updatedate;
	}
	public void setRecipe_updatedate(String recipe_updatedate) {
		this.recipe_updatedate = recipe_updatedate;
	}
	public int getRecipe_viewcnt() {
		return recipe_viewcnt;
	}
	public void setRecipe_viewcnt(int recipe_viewcnt) {
		this.recipe_viewcnt = recipe_viewcnt;
	}
	public double getRecipe_userRatingAvg() {
		return recipe_userRatingAvg;
	}
	public void setRecipe_userRatingAvg(double recipe_userRatingAvg) {
		this.recipe_userRatingAvg = recipe_userRatingAvg;
	}
	public ArrayList<String> getImages() {
		return images;
	}
	public void setImages(ArrayList<String> images) {
		this.images = images;
	}
	
	@Override
	public String toString() {
		return "RecipeVO [recipe_bno=" + recipe_bno + ", recipe_title=" + recipe_title + ", recipe_category="
				+ recipe_category + ", recipe_ingre=" + recipe_ingre + ", recipe_seasoning=" + recipe_seasoning
				+ ", recipe_content=" + recipe_content + ", recipe_writer=" + recipe_writer + ", recipe_image="
				+ recipe_image + ", recipe_regdate=" + recipe_regdate + ", recipe_updatedate=" + recipe_updatedate
				+ ", recipe_viewcnt=" + recipe_viewcnt + ", recipe_userRatingAvg=" + recipe_userRatingAvg
				+ ", recipe_attach_no=" + recipe_attach_no + ", images=" + images + ", recipe_attach_text="
				+ recipe_attach_text + "]";
	}		
		
}

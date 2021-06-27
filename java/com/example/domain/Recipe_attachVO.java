package com.example.domain;

import java.util.Date;

public class Recipe_attachVO {
	private int recipe_bno;
	private int recipe_attach_no;
	private Date regDate;
	private String recipe_attach_image;
	private String recipe_attach_text;
	
	public String getRecipe_attach_image() {
		return recipe_attach_image;
	}
	public void setRecipe_attach_image(String recipe_attach_image) {
		this.recipe_attach_image = recipe_attach_image;
	}
	public String getRecipe_attach_text() {
		return recipe_attach_text;
	}
	public void setRecipe_attach_text(String recipe_attach_text) {
		this.recipe_attach_text = recipe_attach_text;
	}
	public int getRecipe_bno() {
		return recipe_bno;
	}
	public void setRecipe_bno(int recipe_bno) {
		this.recipe_bno = recipe_bno;
	}
	public int getRecipe_attach_no() {
		return recipe_attach_no;
	}
	public void setRecipe_attach_no(int recipe_attach_no) {
		this.recipe_attach_no = recipe_attach_no;
	}
	public Date getRegDate() {
		return regDate;
	}
	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}
	
	
	@Override
	public String toString() {
		return "Recipe_attachVO [recipe_bno=" + recipe_bno + ", recipe_attach_no=" + recipe_attach_no + ", regDate="
				+ regDate + ", recipe_attach_image=" + recipe_attach_image + ", recipe_attach_text="
				+ recipe_attach_text + "]";
	}	
}

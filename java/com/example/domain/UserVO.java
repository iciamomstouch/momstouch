package com.example.domain;

public class UserVO {
	private String user_id;
	private String user_pass;
	private String user_name;
	private String user_email;
	private String user_address;
	private String user_tel;
	private String user_nick;
	private String user_image;
	private String user_type;
	private int user_join;
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getUser_pass() {
		return user_pass;
	}
	public void setUser_pass(String user_pass) {
		this.user_pass = user_pass;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getUser_email() {
		return user_email;
	}
	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}
	public String getUser_address() {
		return user_address;
	}
	public void setUser_address(String user_address) {
		this.user_address = user_address;
	}
	public String getUser_tel() {
		return user_tel;
	}
	public void setUser_tel(String user_tel) {
		this.user_tel = user_tel;
	}
	public String getUser_nick() {
		return user_nick;
	}
	public void setUser_nick(String user_nick) {
		this.user_nick = user_nick;
	}
	public String getUser_image() {
		return user_image;
	}
	public void setUser_image(String user_image) {
		this.user_image = user_image;
	}
	public String getUser_type() {
		return user_type;
	}
	public void setUser_type(String user_type) {
		this.user_type = user_type;
	}
	public int getUser_join() {
		return user_join;
	}
	public void setUser_join(int user_join) {
		this.user_join = user_join;
	}
	
	@Override
	public String toString() {
		return "UserVO [user_id=" + user_id + ", user_pass=" + user_pass + ", user_name=" + user_name + ", user_email="
				+ user_email + ", user_address=" + user_address + ", user_tel=" + user_tel + ", user_nick=" + user_nick
				+ ", user_image=" + user_image + ", user_type=" + user_type + ", user_join=" + user_join + "]";
	}	
}

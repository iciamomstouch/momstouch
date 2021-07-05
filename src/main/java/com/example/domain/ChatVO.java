package com.example.domain;

import java.util.Date;

public class ChatVO extends UserVO{
	private int chat_id;
	private String chat_sender;
	private String chat_receiver;
	private String chat_content;
	private Date chat_time;
	public int getChat_id() {
		return chat_id;
	}
	public void setChat_id(int chat_id) {
		this.chat_id = chat_id;
	}
	public String getChat_sender() {
		return chat_sender;
	}
	public void setChat_sender(String chat_sender) {
		this.chat_sender = chat_sender;
	}
	public String getChat_receiver() {
		return chat_receiver;
	}
	public void setChat_receiver(String chat_receiver) {
		this.chat_receiver = chat_receiver;
	}
	public String getChat_content() {
		return chat_content;
	}
	public void setChat_content(String chat_content) {
		this.chat_content = chat_content;
	}
	public Date getChat_time() {
		return chat_time;
	}
	public void setChat_time(Date chat_time) {
		this.chat_time = chat_time;
	}
	@Override
	public String toString() {
		return "ChatVO [chat_id=" + chat_id + ", chat_sender=" + chat_sender + ", chat_receiver=" + chat_receiver
				+ ", chat_content=" + chat_content + ", chat_time=" + chat_time + "]";
	}
	
	
}

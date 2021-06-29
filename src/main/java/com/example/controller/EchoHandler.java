package com.example.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

public class EchoHandler extends TextWebSocketHandler {
List<WebSocketSession> sessionList=new ArrayList<>();
Map<String, String> sessionUser=new HashMap<>();

	
	//Ŭ���̾�Ʈ ������ ������ ��
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		sessionList.remove(session);
		System.out.println("�������" + session.getId());
		super.afterConnectionClosed(session, status);
	}

	//Ŭ���̾�Ʈ�� ���� �Ǿ��� ��
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		sessionList.add(session);
		System.out.println("�����:" + session.getId());
		super.afterConnectionEstablished(session);
	}

	//Ŭ���̾�Ʈ�� ������ �޽����� ����������
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		String strMessage=message.getPayload();
		System.out.println("�޽���:" + strMessage);
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		String strDate=sdf.format(new Date());
		strMessage=strMessage + "|" + strDate;
		//������ ��� �������� �޽��� ������
		for(WebSocketSession web:sessionList){
			web.sendMessage(new TextMessage(strMessage));
		}
		super.handleTextMessage(session, message);
	}
	
}

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
	<title>회원관리</title>
	<style>
		#pagination a{text-decoration:none;color:green;}
		#pagination .active{color:red;}
	</style>
</head>
<body>
	<h1>[회원목록]</h1>
	<button onClick="location.href='insert'">회원등록</button>
	총갯수:<span id="totalCount">${pm.totalCount }</span>
	<table border=1>
		<tr class="title">
			<td width=100>아이디</td>
			<td width=100>이름</td>
			<td width=200>이메일</td>
			<td width=200>전화번호</td>
			<td width=200>주소</td>
			<td width=100>닉네임</td>
			<td width=100>이미지</td>
		</tr>
		<c:forEach items="${list}" var="vo">
		<tr class="row" onClick="location.href='read?user_id=${vo.user_id}'">
			<td>${vo.user_id}</td>
			<td>${vo.user_name}</td>
			<td>${vo.user_email}</td>
			<td>${vo.user_tel}</td>
			<td>${vo.user_address}</td>
			<td>${vo.user_nick}</td>			
			<td>
				<img src="/displayFile?fullName=${vo.user_image}" width=100/>
			</td>
		</tr>		
		</c:forEach>
	</table>
	<hr/>
	<div id="pagination">
		<c:if test="${pm.prev }">
			<a href="list?page=${pm.startPage-1}">이전</a>
		</c:if>
		<c:forEach begin="${pm.startPage }" end="${pm.endPage}" var="i">
			<c:if test="${i==cri.page }">
				<a class="active" href="list?page=${i}">${i}&nbsp;</a>
			</c:if>
			<c:if test="${i!=cri.page }">
				<a href="list?page=${i}">${i}&nbsp;</a>
			</c:if>
		</c:forEach>
		<c:if test="${pm.next }">
			<a href="list?page=${pm.endPage+1}">다음</a>
		</c:if>
</body>
</html>
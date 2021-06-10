<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>게시판 목록</title>
	<style>
		.row {cursor:pointer;}
	</style>
</head>
<body>
	<h1>[게시판 목록]</h1>
	<button onClick="location.href='insert'">글쓰기</button>
	<table border=1>
	<tr class="row" onClick="location.href='read?boar_bno=${vo.board_bno}'">
			<td width=100>글번호</td>
			<td width=500>카테고리</td>
			<td width=100>제목</td>
			<td width=100>작성자</td>
			<td width=100>작성일</td>
			<td width=100>조회수</td>
		</tr>
	<c:forEach items="${list}" var="vo">
	
		<tr class="row" onClick="location.href='read?board_bno=${vo.board_bno}'">
			<td width=100>${vo.board_bno}</td>
			<td width=100>${vo.board_category}</td>
			<td width=500>${vo.board_title}</td>
			<td width=100>${vo.board_writer}</td>
			<td width=100>${vo.board_regdate}</td>
			<td width=100>${vo.board_viewcnt}</td>
		</tr>
	</c:forEach>
	</table>
</body>
</html>
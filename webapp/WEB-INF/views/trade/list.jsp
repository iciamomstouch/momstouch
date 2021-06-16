<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>중고거래</title>
	<style>
		.row {cursor:pointer;}
	</style>
</head>
<body>
	<h1>중고거래</h1>
	<table border=1 style=margin-top:10px;>
		<tr>
			<td>이미지</td>
			<td>카테고리</td>
			<td>제목</td>
			<td>가격</td>
			<td>작성자</td>
			<td>작성일</td>
			<td>관심목록</td>
		</tr>
		<c:forEach items="${list}" var="vo">
			<tr class="row" onClick="location.href='read?trade_bno=${vo.trade_bno}'">
				<td class="trade_image">
					<c:if test="${vo.trade_image==null}">
						<img src="http://placehold.it/100x80"/>
					</c:if>
					<c:if test="${vo.trade_image!=null}">
						<img src="/displayFile?fullName=${vo.trade_image}" width=100/>
					</c:if>	
				</td>
				<td>${vo.trade_category}</td>
				<td>${vo.trade_title}</td>
				<td><fmt:formatNumber value="${vo.trade_price}" pattern="#,###원"/></td>
				<td>${vo.trade_writer}</td>
				<td><fmt:formatDate value="${vo.trade_regdate}" pattern="yyyy-MM-dd kk:mm:ss"/></td>
				<td>♥</td>
			</tr>
		</c:forEach>
	</table>
	<button onClick="location.href='insert'">글작성</button>
</body>
</html>
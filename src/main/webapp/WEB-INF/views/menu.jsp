<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="item-left">
	<a href="/board/list">게시판1</a>
	<a href="/info/list">게시판2</a>
	<a href="/trade/list">중고거래</a>
	<a href="/recipe/list">레시피</a>
	<a href="/question/list">질문게시판</a>
	<a href="/user/list">회원관리</a>	
</div>

<div class="item-right">
	<c:if test="${user_id != null }">
		<span style="margin-right:50px;">${user_id }님</span>
		<a href="/user/logout">로그아웃</a>
	</c:if>
	<c:if test="${user_id == null }">
		<a href="/user/login">로그인</a>
	</c:if>

</div>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="item-left">
	<a href="/map/map">우리동네</a><br/><br/>
	<c:if test="${user_type == 'admin' }">
		<a href="/user/list" id="user">회원관리</a><br/><br/>
	</c:if>	
	<a href="/question/list" id="qeus">질문게시판</a>
</div>
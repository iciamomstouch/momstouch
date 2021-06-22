<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" href="/resources/css/home.css"/>
	<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
 	<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
	<title>First time</title>	
</head>
<body>
	<div id="divTop">
		<div id="sidemenu">
			<jsp:include page="leftmenu.jsp"/>
			<div class="close"></div>
		</div>
		<div class="btnside"></div>
		
		<span><img src="/resources/image/logo.png" class="logo" onClick="location.href='/'"/></span>
		
		<span class="login">
			<c:if test="${user_id != null }">
				<span>${user_id}님</span>
				<a href="/user/logout">
					<img src="/resources/css/person-x-fill.svg" class="logout">
				</a>
			</c:if>
			<c:if test="${user_id == null }">
				<a href="/user/login">
					<img src="/resources/css/person-fill.svg" class="login"/>
				</a>
			</c:if>
		</span>
	</div>
		<div id="divMenu">
			<jsp:include page="menu.jsp"/>
		</div>
	<div id="divCenter">
		<div id="divContent">
			<jsp:include page="${pageName }"/>
		</div>
	</div>
	
	<div id="divBottom">
		<h4>인천일보 아카데미</h4>
		
	</div>
</body>
<script>
$(".btnside").click(function () {
    $("#sidemenu").addClass("open");
});
$(".close").click(function () {
    $("#sidemenu").removeClass("open");
});
</script>
</html>
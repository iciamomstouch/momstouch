<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" href="/resources/css/home.css"/>
	<title>맘's터치</title>	
	<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
 	<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
</head>
<body>
	<div id="divTop">
		<h1>[맘스터치]</h1>		
		<div id="divMenu">
			<jsp:include page="menu.jsp"/>
		</div>		
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
</html>
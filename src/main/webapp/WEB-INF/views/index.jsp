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
	<title>맘's터치</title>	
</head>
<body>
	<div id="divTop">
		<h1>[맘스터치]</h1>
		<div id="weather"><span id="today"></span>&nbsp;&nbsp;<span id="daum_weather"></span></div>		
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
<script>
	var weather = [];
	getWeather();
	function getWeather() { //다음 날씨 정보 출력
		$.ajax({
			type : "get",
			url : "/daum.json",
			success : function(data) {
				$("#today").html(data.date);
				var i = 0;
				$(data.list).each(function() {
					weather[i] = this.part + " " + this.ico + " " + this.temper + " " + this.wa;
					i++;
				});
				i = 0;
				var interval = setInterval(function() {
					$("#daum_weather").html(weather[i]);
					if (i < weather.length - 1) {
						i++;
					} else {
						i = 0;
					}
				}, 1000);
			}
		});
	}
</script>
</html>
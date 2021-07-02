<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
	<title>회원관리</title>
	<link rel="stylesheet" href="/resources/css/user/list.css"/>
	<style>
		#pagination a{text-decoration:none;color:green;}
		#pagination .active{color:red;}
		.row{background:pink;}
	</style>
</head>
<body>
	<div id="condition" style="margin-bottom:5px;">
		<div id="left">
			<select id="searchType">
				<option value="user_id">아이디</option>
				<option value="user_name">이름</option>
				<option value="user_nick">닉네임</option>
			</select>
			<input type="text" id="keyword" placeholder="검색어"/>
			<input type="button" id="btnSearch" value="검 색"/>
			<span id="total"></span>
		</div>
		<div id="right"></div>
	</div>
	<button onClick="location.href='insert'">회원등록</button>
	<div id="list">
		<div id="tbl" style="width:600px; margin: 0px auto; margin-bottom:30px;"></div>
		<script id="temp" type="text/x-handlebars-template">
		{{#each list}}
		<table style="width:550px;border:2px solid black;" onClick="location.href='/user/update?user_id={{user_id}}'">
			<tr class="row">
				<tr>
					<td rowspan=7 id="image"><img src="/displayFile?fullName={{user_image}}" width=100/></td>
				</tr>
				<tr>
					<td id="uid">{{user_id}}</td>
				</tr>
				<tr>
					<td id="uname">{{user_name}}</td>
				</tr>
				<tr>
					<td id="unick">{{user_nick}}</td>
				</tr>
				<tr>
					<td id="utel">{{user_tel}}</td>
				</tr>
				<tr>
					<td id="uadd">{{user_address}}</td>
				</tr>
				<tr>
					<td id="uemail">{{user_email}}</td>
				</tr>
			</tr>
		</table>
		<br/>
		{{/each}}
		</script>	
	</div>
	<div id="pagination" style="margin-top:5px;"></div>
	
</body>
<script type="text/javascript">
	var page=1;
	getList();
	$("#keyword").on("keydown", function(e){
		if(e.keyCode==13){
			page=1;
			getList();
		}
	})
	$("#btnSearch").on("click", function(){		
			page=1;
			getList();		
	})
	function getList(){
		var searchType=$("#searchType").val();
		var keyword=$("#keyword").val();
		$.ajax({
			type:"get",
			url:"list.json",
			dataType:"json",
			data:{"page":page, "keyword":keyword, "searchType":searchType},
			success:function(result){
				var temp=Handlebars.compile($("#temp").html());
				$("#tbl").html(temp(result));
				$("#total").html("검색수 : " + result.pm.totalCount);
				
				//페이징 목록 출력
				var str = "";
				var prev = result.pm.startPage-1;
				var next = result.pm.endPage+1;
				if(result.pm.prev) str+= "<a href='" + prev + "'>◀</a>";
				for(var i=result.pm.startPage; i<=result.pm.endPage; i++){
					if(i==page){
						str += "[<a class='active' href='" + i +"'>" + i + "</a>] ";
					}else{
						str += "[<a href='" + i +"'>" + i + "</a>] ";
					}					
				}
				if(result.pm.next) str+= "<a href='" + next + "'>▶</a>";
				$("#pagination").html(str);
			}
		})
	}
	
	$("#pagination").on("click", "a", function(e){
		e.preventDefault();
		page = $(this).attr("href");
		getList();
	});
</script>
</html>

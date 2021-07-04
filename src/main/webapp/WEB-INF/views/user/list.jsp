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
		.row{cursor: pointer;}
	</style>
</head>
<body>
	<div id="condition" width="800" style="margin-bottom:30px;">
		<div id="right">
		<button onClick="location.href='insert'" id="btnplus">
				<img src="/resources/css/plus-circle-fill.svg" class="plus">
		</button>
		</div>
		<div id="left">
			<select id="searchType">
				<option value="user_id">아이디</option>
				<option value="user_name">이름</option>
				<option value="user_nick">닉네임</option>
			</select>
			<input type="text" id="keyword" placeholder="검색어를 입력해주세요" style="width:400px; font-size: 15px;background-color:transparent;border:0 solid black; border-bottom: 3px solid black; text-align:left;"/>
			<button>
				<img src="/resources/css/search.svg" class="search">
			</button>
			<span id="total"></span>
			
		</div>
	</div>
	
	<div id="list">
		<div id="tbl" style="width:600px; margin: 0px auto; margin-bottom:30px;"></div>
		<script id="temp" type="text/x-handlebars-template">
		{{#each list}}
		<table style="width:550px;
					height:180px;
					margin: 0px auto;
					border:5px solid #f2f2f2;
					border-radius:5px; 
					background:#f2f2f2;
					color:black;
					cursor: pointer;" 
					onClick="location.href='/user/update?user_id={{user_id}}'">
			<tr class="row">
				<tr>
					<td rowspan=7><img src="/displayFile?fullName={{user_image}}" width=100 id="image"/></td>
				</tr>
				<tr>
					<td id="uid" colspan=2>{{user_id}}</td>
				</tr>
				<tr>
					<td width=30 ><img src="/resources/image/name.png" width=30 id="name"/></td>
					<td id="uname">{{user_name}}</td>
				</tr>
				<tr>
					<td width=30><img src="/resources/image/nick.png" width=30 id="nick"/></td>
					<td id="unick">{{user_nick}}</td>
				</tr>
				<tr>
					<td width=30><img src="/resources/image/phone.png" width=30 id="phone"/></td>
					<td id="utel">{{user_tel}}</td>
				</tr>
				<tr>
					<td width=30><img src="/resources/image/add.png" width=30 id="add"/></td>
					<td id="uadd" width=300>{{user_address}}</td>
				</tr>
				<tr>
					<td width=30><img src="/resources/image/email.png" width=30 id="email"/></td>
					<td id="uemail">{{user_email}}</td>
				</tr>
			</tr>
		</table>
		<br/>
		{{/each}}
		</script>	
	</div>
	<div id="pagination" style="margin-top:20px; margin-bottom:10px;"></div>
	
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
						str += "<a class='active' href='" + i +"'>" + i + "</a> ";
					}else{
						str += "<a href='" + i +"'>" + i + "</a> ";
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
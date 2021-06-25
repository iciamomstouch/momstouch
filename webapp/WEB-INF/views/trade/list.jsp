<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>중고거래</title>
	<link rel="stylesheet" href="/resources/css/tralist.css"/>
	<style>
		.row {cursor:pointer;}
		#pagination span {cursor: pointer; color:black; border:1px solid gray; padding:5px; background:white;}
		#pagination .active {background:gray; color:white;}
	</style>
	<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
</head>
<body>
	<div id="condition" style="margin-bottom:5px;">
		<div id="btninsert">
			<button onClick="location.href='insert'" id="btninsert">WRITING</button>
		</div>			
	</div>
	
	<table id="tbl"></table>
	<script id="temp" type="text/x-handlebars-template">
	<tr class="title">
		<td>이미지</td>
		<td>카테고리</td>
		<td>제목</td>
		<td>가격</td>
		<td>작성자</td>
		<td>작성일</td>
	</tr>
	{{#each list}}
	<tr class="row" onClick="location.href='read?trade_bno={{trade_bno}}'">
		<td><img src="/displayFile?fullName={{trade_image}}" width=100/></td>
		<td>{{trade_category}}</td>
		<td>{{trade_title}}</td>
		<td>{{trade_price}}</td>
		<td>{{trade_writer}}</td>
		<td>{{trade_regdate}}</td>
	</tr>
	{{/each}}
	</script>
	<div id="left" style="margin-top:10px;">
			<select id="searchType">
				<option value="trade_title">제목</option>
				<option value="trade_writer">작성자</option>
			</select>
			<input type="text" id="keyword" placeholder="검색어"/>
			<input type="button" id="btnSearch" value="검 색"/>
			<span id="total"></span>
		</div>
	<div id="pagination" style="margin-top:5px;"></div>
</body>
<script>
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
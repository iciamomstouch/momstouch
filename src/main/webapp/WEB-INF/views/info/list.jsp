<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>게시판2</title>
	<style>
		.row {cursor:pointer;}
	</style>
</head>
<body>
	<h1>[게시판2 목록]</h1>
	<div id="condition" style="margin-bottom:5px;">
		<div id="left">		
			<select id="searchType">
				<option value="info_title">제목</option>				
				<option value="info_content">내용</option>
			</select>
			<input type="text" id="keyword" placeholder="검색어"/>
			<input type="button" id="btnSearch" value="검 색"/>
			<span id="total"></span>
		</div>
		<div id="right"></div>
	</div>
	<button onClick="location.href='insert'">글쓰기</button>
	<div id="list">
		<table id="tbl" border=1 width=800></table>
		<script id="temp" type="text/x-handlebars-template">
		<tr class="title">
			<td width=50>글번호</td>			
			<td width=200>제목</td>
			<td width=100>작성자</td>
			<td width=200>작성일</td>
			<td width=100>조회수</td>
		</tr>
		{{#each list}}
		<tr class="row" onClick="location.href='read?info_bno={{info_bno}}'">
			<td width=50>{{info_bno}}</td>			
			<td width=200>{{info_title}}</td>
			<td width=100>{{info_writer}}</td>
			<td width=200>{{info_regdate}}</td>
			<td width=100>{{info_viewcnt}}</td>
		</tr>
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
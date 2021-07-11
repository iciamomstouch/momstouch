<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>정보방</title>
	<link rel="stylesheet" href="/resources/css/info/list.css"/>
	<style>
		.row {cursor:pointer;}
	</style>
</head>
<body>
	<c:if test="${user_type == 'admin'}">
	<div id="condition" style="margin-bottom:10px;">
		<div id="btninsert">
			<button onClick="location.href='insert'" id="btninsert">WRITING</button>
		</div>
	</div>
	</c:if>
	
	<div id="list">
		<table id="tbl" width=800></table>
		<script id="temp" type="text/x-handlebars-template">
		<tr class="title">						
			<th width=550>제목</th>
			<th width=80>작성자</th>
			<th width=110>작성일</th>			
			<th width=60>조회수</th>
		</tr>
		{{#each list}}
		<tr class="row" onClick="location.href='read?info_bno={{info_bno}}'">						
			<td style="text-align:left;">{{info_title}}<span style="font-weight:bold;">&nbsp;&nbsp;[{{info_replycnt}}]</span></td>
			<td>{{user_nick}}</td>
			<td>{{info_regdate}}</td>			
			<td>{{info_viewcnt}}</td>
		</tr>
		{{/each}}
		</script>
		<div id="left">		
			<select id="searchType">
				<option value="info_title">제목</option>				
				<option value="info_content">내용</option>
			</select>
			<input type="text" id="keyword" placeholder="검색어"/>
			<button>
				<img src="/resources/css/search.svg" id="btnSearch" class="search">
			</button>
			<span id="total"></span>
		</div>	
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
			data:{"page":page, "keyword":keyword, "searchType":searchType, "perPageNum":10},
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
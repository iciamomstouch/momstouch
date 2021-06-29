<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>오늘</title>
	<link rel="stylesheet" href="/resources/css/board/list.css"/>
	<style>
		.row {cursor:pointer;}
	</style>
</head>
<body>
	<div id="condition" style="margin-bottom:5px;">
		<div id="btninsert">
			<button onClick="location.href='insert'" id="btninsert">WRITING</button>
		</div>
	</div>
	
	<div id="list">
		<table id="tbl" style="width:600px; margin: 0px auto;"></table>
		<script id="temp" type="text/x-handlebars-template">
		{{#each list}}
		<tr class="row" >
			<tr>
				<td id="bwriter">{{board_writer}}</td>
				<td id="bvcnt">조회수: {{board_viewcnt}}</td>
			</tr>
			<tr>
				<td id="bcate">{{board_category}}</td>
				<td id="bdate">{{board_regdate}}</td>
			</tr>
			<tr>
				<td colspan="2" id="bimg" onClick="location.href='read?board_bno={{board_bno}}'">
					<c:if test="${vo.board_image==null }">
						<img src="http://placehold.it/600x600" width=600 id="image"/>
					</c:if>
					<c:if test="${vo.board_image!=null }">
						<img src="/displayFile?fullName=${vo.board_image }" width=800 id="image"/>
					</c:if>
					<input type="file" name="file" style="display:none;"/>
				</td>
			</tr>
			<tr>
				<td id="breply">댓글수: {{board_replycnt}}</td>
				<td id="bheart">
					<img src="/resources/css/heart.svg" class="heart">
				</td>
			</tr>
			<tr>
				<td colspan="2" id="btitle" onClick="location.href='read?board_bno={{board_bno}}'">{{board_title}}</td>
			</tr>
		</tr>
		{{/each}}
		</script>
		<div id="left">		
			<select id="searchType">
				<option value="board_title">제목</option>
				<option value="board_category">카테고리</option>
				<option value="board_content">내용</option>
			</select>
			<input type="text" id="keyword" placeholder="검색어"/>
			<input type="button" id="btnSearch" value="검 색"/>
			<span id="total"></span>
		</div>	
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
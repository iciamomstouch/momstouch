<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
	<title>레시피</title>
	<style>
		#pagination a{text-decoration:none;color:green;}
		#pagination .active{color:red;}							
	</style>
</head>
<body>
	<h1>[레시피목록]</h1>
	<div>
		<button onClick="location.href='insert'">레시피등록</button>		
	</div>
	<div id="condition" style="margin-bottom:5px;">
		<div id="left">
			<select id="searchType">
				<option value="recipe_title">요리명</option>
				<option value="recipe_ingre">요리재료</option>
				<option value="recipe_writer">작성자</option>
			</select>
			<input type="text" id="keyword" placeholder="검색어"/>
			<input type="button" id="btnSearch" value="검 색"/>
			<span id="total"></span>
		</div>	
		<div>
			<span><button>산모</button></span>
			<span><button>4~6개월</button></span>
			<span><button>7~9개월</button></span>
			<span><button>10~12개월</button></span>
			<span><button>12개월 이상</button></span>
		</div>
	</div>	
	
	<table border=1 id="tbl"></table>
	<script id="temp" type="text/x-handlebars-template">
	<tr class="title">
		<td width=200>이미지</td>
		<td width=100>카테고리</td>
		<td width=200>제목</td>
		<td width=100>평점</td>
		<td width=100>작성자</td>
		<td width=200>작성일</td>
	</tr>
	{{#each list}}
	<tr class="row" onClick="location.href='read?recipe_bno={{recipe_bno}}'">
		<td><img src="/displayFile?fullName={{recipe_image}}" width=100/></td>
		<td>{{recipe_category}}</td>
		<td>{{recipe_title}}</td>
		<td>{{format recipe_userRatingAvg}}<span>/5</span></td>
		<td>{{recipe_writer}}</td>
		<td>{{recipe_regdate}}</td>
	</tr>
	{{/each}}
	</script>
	<script>
		Handlebars.registerHelper("format", function(recipe_userRatingAvg){
			var userRatingAvg = (Math.round(recipe_userRatingAvg*10))/10;
			return userRatingAvg;
		})
	</script>
	<hr/>
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
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
	<title>레시피</title>
	<link rel="stylesheet" href="/resources/css/recipe/list.css"/>
	<style>
		
		.box {width:230px;
			  height:300px;
			  padding:5px;
			  margin:5px;
			  margin-left:13px;
			  background:white;
			  color:black;
			  float:left; 
			  cursor: pointer;}
		.img{text-align:center;
			margin-bottom:5px;}
		.rcate{width:30px;
			   margin-left:5px;
			   font-size:15px;
			   color:#0080FF;
			   text-align:left;}
		.rtitle{width:200px;
				margin-left:5px;
				font-size:20px;
				font-weight:bold;
				text-align:left;
				overflow: hidden;
				text-overflow: ellipsis;
				white-space: nowrap;}
		.rwriter{text-align:left;
				margin-left:5px;}
		.ravg{text-align:left;
		      vertical-align: middle;}								
	</style>
</head>
<body>
	<div id="btninsert">
		<button onClick="location.href='insert'" id="btninsert">WRITING</button>		
	</div>
	<div id="tip">
		<p>
			<a id="atitle">이유식 개월 수</a>
		    <a>초기: 4~6개월/</a>
		    <a>중기: 7~9개월 /</a> 
		    <a>후기: 10~12개월/</a>
		    <a>완료기: 12개월 이상</a>
	    </p>

	</div>
	<div id="condition">		
		<span><button class="btn01" value="산모">산모</button></span>
		<span><button class="btn01" value="초기">초기</button></span>
		<span><button class="btn01" value="중기">중기</button></span>
		<span><button class="btn01" value="후기">후기</button></span>
		<span><button class="btn01" value="완료기">완료기</button></span>		
	</div>	
	
	<table id="tbl" style="width:800px; margin:0px auto; margin-bottom:10px;"></table>
	<script id="temp" type="text/x-handlebars-template">
	<tr>
	<td>
	{{#each list}}
	<div class="box" onClick="location.href='read?recipe_bno={{recipe_bno}}'">
		<div class="img"><img src="/displayFile?fullName={{recipe_image}}" width=230/></div>
		<div class="rcate">{{recipe_category}}</div>
		<div class="rtitle">{{recipe_title}}</div>
		<div class="rwriter">{{user_nick}}</div>
		<div class="ravg"><img src="/resources/image/0{{format recipe_userRatingAvg}}.png" style="vertical-align: middle; width:150px;" class="star0{{format recipe_userRatingAvg}}"/>{{format recipe_userRatingAvg}}<span>/5</span></div>		
	</div>
	{{/each}}
	</td>
	</tr>
	</script>
	<div id="left">
		<select id="searchType">
			<option value="recipe_title">요리명</option>
			<option value="recipe_ingre">요리재료</option>
			<option value="recipe_writer">작성자</option>
		</select>
		<input type="text" id="keyword" placeholder="검색어"/>
		<button>
			<img src="/resources/css/search.svg" id="btnSearch" class="search">
		</button>
		<span id="total"></span>
	</div>
	<script>
		Handlebars.registerHelper("format", function(recipe_userRatingAvg){
			var userRatingAvg = (Math.round(recipe_userRatingAvg));
			return userRatingAvg;
		})
	</script>

	<div id="pagination" style="margin-top:20px; margin-bottom:10px;"></div>			
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
			data:{"page":page, "keyword":keyword, "searchType":searchType, "perPageNum":9},
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
	
	$("#condition").on("click", "button", function(){		
		page=1;
		var keyword=$(this).val();
		getList2();	
		
		function getList2(){
			var searchType="recipe_category";		
			$.ajax({
				type:"get",
				url:"list.json",
				dataType:"json",
				data:{"page":page, "keyword":keyword, "searchType":searchType, "perPageNum":9},
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
	})	
	
	$("#pagination").on("click", "a", function(e){
		e.preventDefault();
		page = $(this).attr("href");
		getList();
	});	
</script>
</html>
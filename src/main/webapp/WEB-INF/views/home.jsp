<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 	
 	<style>
 		.box { width:130px;height:150px;padding:5px;margin:5px;background:gray;color:white;float:left; font-size:15px; }
 	</style>
 	
 	<!-- 게시판1--------------------------------------------------------------- -->
	<h2>[게시판1]</h2>
	
	<div id="list1">
		<table id="tbl1" border=1 width=800></table>
		<script id="temp1" type="text/x-handlebars-template">
		<tr class="title">
			<td width=60>글번호</td>
			<td width=100>카테고리</td>
			<td width=200>제목</td>
			<td width=100>작성자</td>
			<td width=200>작성일</td>
			<td width=60>댓글수</td>
			<td width=60>조회수</td>
		</tr>
		{{#each list}}
		<tr class="row" onClick="location.href='board/read?board_bno={{board_bno}}'">
			<td width=50>{{board_bno}}</td>
			<td width=100>{{board_category}}</td>
			<td width=200>{{board_title}}</td>
			<td width=100>{{board_writer}}</td>
			<td width=200>{{board_regdate}}</td>
			<td width=100>{{board_replycnt}}</td>
			<td width=100>{{board_viewcnt}}</td>
		</tr>
		{{/each}}
		</script>	
	</div>
	
	<hr/>
	
	<script>	
	getList1();
	function getList1(){
		var page=1;
		$.ajax({
			type:"get",
			url:"/board/list.json",
			dataType:"json",
			data:{"page":page},
			success:function(result){
				var temp=Handlebars.compile($("#temp1").html());
				$("#tbl1").html(temp(result));
			}
		});
	}
	</script>
	
	<!-- 게시판2--------------------------------------------------------------- -->
	<h2>[게시판2]</h2>
	
	<div id="list2">
		<table id="tbl2" border=1 width=800></table>
		<script id="temp2" type="text/x-handlebars-template">
		<tr class="title">
			<td width=60>글번호</td>			
			<td width=200>제목</td>
			<td width=100>작성자</td>
			<td width=200>작성일</td>
			<td width=60>댓글수</td>
			<td width=60>조회수</td>
		</tr>
		{{#each list}}
		<tr class="row" onClick="location.href='info/read?info_bno={{info_bno}}'">
			<td width=50>{{info_bno}}</td>			
			<td width=200>{{info_title}}</td>
			<td width=100>{{info_writer}}</td>
			<td width=200>{{info_regdate}}</td>
			<td width=100>{{info_replycnt}}</td>
			<td width=100>{{info_viewcnt}}</td>
		</tr>
		{{/each}}
		</script>	
	</div>
	
	<hr/>
	
	<script>	
	getList2();
	function getList2(){
		var page=1;			
		$.ajax({
			type:"get",
			url:"/info/list.json",
			dataType:"json",
			data:{"page":page},
			success:function(result){
				var temp=Handlebars.compile($("#temp2").html());
				$("#tbl2").html(temp(result));
			}
		});
	}	
	</script>
	
	<!-- 중고거래 게시판--------------------------------------------------------------- -->
	<h2>[중고거래]</h2>
	
	<div id="list3">
		<table id="tbl3" border=1 width=800></table>		
		<script id="temp3" type="text/x-handlebars-template">
		<tr>
		<td>		
		{{#each list}}
		<div class="box" onClick="location.href='trade/read?trade_bno={{trade_bno}}'">
			<div><img src="/displayFile?fullName={{trade_image}}" width=100/></div>
			<div>[<span>{{trade_category}}</span>]&nbsp;<span>{{trade_title}}</span></div>
			<div>{{trade_regdate}}</div>
			<div>{{trade_price}}</div>
		</div>
		{{/each}}
		</td>
		</tr>
		</script>
	</div>
	
	<script>
	getList3();
	function getList3(){
		var page=1;
		$.ajax({
			type:"get",
			url:"/trade/list.json",
			dataType:"json",
			data:{"page":page},
			success:function(result){
				var temp=Handlebars.compile($("#temp3").html());
				$("#tbl3").html(temp(result));
			}
		});
	}
	</script>
	
	<hr/>
	
	<!-- 레시피 게시판--------------------------------------------------------------- -->
	<h2>[레시피]</h2>
	<div id="list4">
		<table border=1 id="tbl4"></table>
		<script id="temp4" type="text/x-handlebars-template">
		<tr class="title">
			<td width=200>이미지</td>
			<td width=100>카테고리</td>
			<td width=200>제목</td>
			<td width=100>평점</td>
			<td width=100>작성자</td>
			<td width=200>작성일</td>
		</tr>
		{{#each list}}
		<tr class="row" onClick="location.href='recipe/read?recipe_bno={{recipe_bno}}'">
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
			});
			
			getList4();
			function getList4(){
				var page=1;
				$.ajax({
					type:"get",
					url:"recipe/list.json",
					dataType:"json",
					data:{"page":page},
					success:function(result){
						var temp=Handlebars.compile($("#temp4").html());
						$("#tbl4").html(temp(result));
					}
				});
			}
		</script>	
	</div>
	<hr/>
	
	<!-- 질문 게시판--------------------------------------------------------------- -->
	<h2>[질문]</h2>
	<div id="list5">
		<table id="tbl5" border=1 width=800></table>
		<script id="temp5" type="text/x-handlebars-template">
		<tr class="title">
			<td width=50>글번호</td>			
			<td width=300>제목</td>
			<td width=100>작성자</td>
			<td width=200>작성일</td>			
			<td width=50>조회수</td>
		</tr>
		{{#each list}}
		<tr class="row" onClick="location.href='question/read?question_bno={{question_bno}}'">
			<td>{{question_bno}}</td>			
			<td>{{question_title}}</td>
			<td>{{question_writer}}</td>
			<td>{{question_regdate}}</td>			
			<td>{{question_viewcnt}}</td>
		</tr>
		{{/each}}
		</script>	
	</div>	
	
	<script>
	getList5();
	function getList5(){
		var page=1;
		$.ajax({
			type:"get",
			url:"/question/list.json",
			dataType:"json",
			data:{"page":page},
			success:function(result){
				var temp=Handlebars.compile($("#temp5").html());
				$("#tbl5").html(temp(result));
			}
		});
	}
	</script>
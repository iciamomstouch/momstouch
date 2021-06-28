<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 	
	<link rel="stylesheet" href="/resources/css/board.css"/>
 	<!-- 게시판1--------------------------------------------------------------- -->

	<h2>오늘</h2>

	<div id="list1">
		<table id="tbl1" width=800></table>
		<script id="temp1" type="text/x-handlebars-template">
		<tr class="title">
			<td width=100>카테고리</td>
			<td width=200>제목</td>
			<td width=100>작성자</td>
			<td width=50>조회수</td>
		</tr>
		{{#each list}}
		<tr class="row" onClick="location.href='board/read?board_bno={{board_bno}}'">
			<td>{{board_category}}</td>
			<td>{{board_title}}<span style="font-weight:bold;">&nbsp;&nbsp;[{{board_replycnt}}]</span></td>
			<td>{{board_writer}}</td>
			<td>{{board_viewcnt}}</td>
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
			data:{"page":page, "perPageNum":3},
			success:function(result){
				var temp=Handlebars.compile($("#temp1").html());
				$("#tbl1").html(temp(result));
			}
		});
	}
	</script>
	
	
	
	<!-- 중고거래 게시판--------------------------------------------------------------- -->
	<h2>중고거래</h2>
	
	<div id="list3">
		<table id="tbl3"></table>		
		<script id="temp3" type="text/x-handlebars-template">
		<tr>
		<td>		
		{{#each list}}
		<div class="box" onClick="location.href='trade/read?trade_bno={{trade_bno}}'">
			<div class="img"><img src="/displayFile?fullName={{trade_image}}" width="100"/></div>
			<div class="tratitle">:[<span>{{trade_category}}</span>]&nbsp;<span>{{trade_title}}</span></div>
			<div class="price">:{{trade_price}}원</div>
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
			data:{"page":page, "perPageNum":5},
			success:function(result){
				var temp=Handlebars.compile($("#temp3").html());
				$("#tbl3").html(temp(result));
			}
		});
	}
	</script>
	
	<hr/>
	
	<!-- 레시피 게시판--------------------------------------------------------------- -->
	<h2>레시피</h2>
	
	<div id="list4">
		<table id="tbl4"></table>
		<script id="temp4" type="text/x-handlebars-template">
		{{#each list}}
		<tr class="recipe_box" onClick="location.href='recipe/read?recipe_bno={{recipe_bno}}'">
			<td rowspan="3"><img src="/displayFile?fullName={{recipe_image}}" width=300/></td>
			<td style="width:300px;font-size:20px; padding-left:10px;">:{{recipe_category}}</td>
		</tr>
		<tr>
			<td style="width:300px; font-weight:bold; font-size:30px; text-overflow: ellipsis; padding-left:10px;">
				"{{recipe_title}}"
			</td>
		</tr>
		<tr>
			<td><img src="/resources/image/04.png" width=100 class="star04"/>{{format recipe_userRatingAvg}}<span>/5</span></td>
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
					data:{"page":page, "perPageNum":1},
					success:function(result){
						var temp=Handlebars.compile($("#temp4").html());
						$("#tbl4").html(temp(result));
					}
				});
			}
		</script>	
	</div>
	<hr/>
	
	<!-- 게시판2--------------------------------------------------------------- -->
	<h2>정보방</h2>
	
	<div id="list2">
		<table id="tbl2" width=800></table>
		<script id="temp2" type="text/x-handlebars-template">
		<tr class="title">		
			<td>제목</td>
			<td>작성자</td>
			<td>조회수</td>
		</tr>
		{{#each list}}
		<tr class="row" onClick="location.href='info/read?info_bno={{info_bno}}'">		
			<td>{{info_title}}<span style="font-weight:bold;">&nbsp;&nbsp;[{{info_replycnt}}]</span></td>
			<td>{{info_writer}}</td>
			<td>{{info_viewcnt}}</td>
		</tr>
		{{/each}}
		</script>	
	</div>
	
	<script>	
	getList2();
	function getList2(){
		var page=1;			
		$.ajax({
			type:"get",
			url:"/info/list.json",
			dataType:"json",
			data:{"page":page, "perPageNum":3},
			success:function(result){
				var temp=Handlebars.compile($("#temp2").html());
				$("#tbl2").html(temp(result));
			}
		});
	}	
	</script>	
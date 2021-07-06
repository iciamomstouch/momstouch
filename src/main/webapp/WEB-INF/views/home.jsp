<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 	
	<link rel="stylesheet" href="/resources/css/home.css"/>
	<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.css" />
	<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css" />
	<script src="https://unpkg.com/swiper/swiper-bundle.js"></script>
	<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
	<style>
		.swiper-container {
			width: 800px;
			height: 300px;}
		.tratitle{overflow: hidden;
			text-align:left;				
			text-overflow: ellipsis;
			white-space: nowrap;}
	</style>
 	<!-- 게시판1--------------------------------------------------------------- -->

	<h2>오늘</h2>
	<br/>

	<div id="list1">
		<table id="tbl1" width=800></table>
		<script id="temp1" type="text/x-handlebars-template">
		<tr class="title">
			<th width=100>카테고리</th>
			<th width=200>제목</th>
			<th width=100>작성자</th>
			<th width=50>조회수</th>
		</tr>
		{{#each list}}
		<tr class="row" onClick="location.href='/board/read?board_bno={{board_bno}}'">
			<td>{{board_category}}</td>
			<td>{{board_title}}<span style="font-weight:bold;">&nbsp;&nbsp;[{{board_replycnt}}]</span></td>
			<td>{{user_nick}}</td>
			<td>{{board_viewcnt}}</td>
		</tr>
		{{/each}}
		</script>	
	</div>
	
	<hr/>
	<br/>
	
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
	<br/>
	<div id="list3">
		<table id="tbl3"></table>		
		<script id="temp3" type="text/x-handlebars-template">
		<tr>
		<td>		
		{{#each list}}
		<div class="box" onClick="location.href='/trade/read?trade_bno={{trade_bno}}'">
			<div class="img"><img src="/displayFile?fullName={{trade_image}}" width="100"/></div>
			<div class="tratitle">:[<span>{{trade_category}}</span>]&nbsp;<span>{{trade_title}}</span></div>
			<div class="price">:{{trade_price}}원</div>
		</div>
		{{/each}}
		</td>
		</tr>
		</script>
	</div>
	
	<hr/>
	<br/>
	
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
	
	<!-- 레시피 게시판--------------------------------------------------------------- -->
	<h2>레시피</h2>
	<br/>
	<div class="swiper-container">	
	<div id="list4" class="swiper-wrapper">		
		<script id="temp4" type="text/x-handlebars-template">
		{{#each list}}
		<div class="swiper-slide">
		<table id="tbl4" style="width:600px; height: 250px; margin: 0px auto;">
		<tr class="recipe_box" onClick="location.href='/recipe/read?recipe_bno={{recipe_bno}}'">
			<td rowspan="3"><img src="/displayFile?fullName={{recipe_image}}" width=300 height=250/></td>
			<td style="width:300px;font-size:20px; padding-left:10px; color:#0080FF;">:{{recipe_category}}</td>
		</tr>
		<tr>
			<td style="width:300px; font-weight:bold; font-size:30px; text-overflow: ellipsis; padding-left:10px;">
				"{{recipe_title}}"
			</td>
		</tr>
		<tr>
			<td><img src="/resources/image/0{{format recipe_userRatingAvg}}.png" style="vertical-align: middle; width:150px;" class="star0{{format recipe_userRatingAvg}}"/>{{format recipe_userRatingAvg}}<span>/5</span></td>
		</tr>
		</table>
		</div>
		{{/each}}
		</script>
	</div>	
		<!-- If we need pagination -->
	<div class="swiper-pagination"></div>
	<!-- If we need navigation buttons -->
	<div class="swiper-button-prev"></div>
	<div class="swiper-button-next"></div>	
	
	</div>
	
	<hr/>
	<br/>
	
	<script>
		Handlebars.registerHelper("format", function(recipe_userRatingAvg) {
			var userRatingAvg = (Math.round(recipe_userRatingAvg));
			return userRatingAvg;
		});

		getList4();
		function getList4() {
			var page = 1;
			$.ajax({
				type : "get",
				url : "/recipe/list.json",
				dataType : "json",
				data : {
					"page" : page,
					"perPageNum" : 5
				},
				success : function(result) {
					var temp = Handlebars.compile($("#temp4").html());
					$("#list4").html(temp(result));
					
					const swiper = new Swiper('.swiper-container', {
						// 슬라이드를 버튼으로 움직일 수 있습니다.
						  navigation: {
						    nextEl: '.swiper-button-next',
						    prevEl: '.swiper-button-prev',
						  },
						    
						// 현재 페이지를 나타내는 점이 생깁니다. 클릭하면 이동합니다.
						  pagination: {
						    el: '.swiper-pagination',
						    type: 'bullets',
						  },

						// 현재 페이지를 나타내는 스크롤이 생깁니다. 클릭하면 이동합니다.
						  scrollbar: {
						    el: '.swiper-scrollbar',
						    draggable: true,
						  },
						    
						// 3초마다 자동으로 슬라이드가 넘어갑니다. 1초 = 1000
						  autoplay: {
						    delay: 3000,
						  },
						});
				}
			});
		}
	</script>
	
	<!-- 게시판2--------------------------------------------------------------- -->
	
	<h2>정보방</h2>
	<br/>
	<div id="list2">
		<table id="tbl2" width=800></table>
		<script id="temp2" type="text/x-handlebars-template">
		<tr class="title">		
			<th>제목</th>
			<th>작성자</th>
			<th>조회수</th>
		</tr>
		{{#each list}}
		<tr class="row" onClick="location.href='/info/read?info_bno={{info_bno}}'">		
			<td>{{info_title}}<span style="font-weight:bold;">&nbsp;&nbsp;[{{info_replycnt}}]</span></td>
			<td>{{user_nick}}</td>
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
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	<head>
		<link rel="stylesheet" href="/resources/css/user/myinfo.css"/>
		<style>
		#tbl3 {float:center;
			  width:800px;
			  overflow: hidden;}			
		.box {width:130px;
			height:210px;
			padding:5px;
			margin:5px;
			margin-left:13px;
			background:white;
			color:black;
			float:left; 
			font-size:15px;
			cursor: pointer;}
		.tratitle{overflow: hidden;
				text-align:left;
				text-overflow: ellipsis;
				white-space: nowrap;}
		.price{text-align:left;}
		.trawriter{text-align:left;}
		.rbox {width:230px;
			  height:300px;
			  padding:5px;
			  margin:5px;
			  margin-left:13px;
			  background:white;
			  color:black;
			  float:left; 
			  cursor: pointer;}
		.rimg{text-align:center;
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
		.row{cursor: pointer;}			
		</style>
	</head>
	
    <h2>마이 페이지</h2>
    
    <div width=600>
    	<table id="tbl" style="width:600px; height:200px; margin: 0px auto;">
    		<tr>
    			<td rowspan=4 width=150 id="mimage">
    				<c:if test="${vo.user_image==null }">
						<img src="http://placehold.it/150x150" width=150 id="image"/>
					</c:if>
					<c:if test="${vo.user_image!=null }">
						<img src="/displayFile?fullName=${vo.user_image }" width=150 height=150 id="image"/>
					</c:if>
					<input type="file" name="file" style="display:none;"/>
    			</td>
    			<td colspan=2 id="mid">${vo.user_nick }님(${vo.user_id })</td>
    		</tr>
    		<tr>
    			<td width=30><img src="/resources/image/phone.png" width=30 id="phone"/></td>
    			<td id="mtel">${vo.user_tel }</td>
    		</tr>
    		<tr>
    			<td width=30><img src="/resources/image/add.png" width=30 id="add"/></td>
    			<td id="madd" width=300>${vo.user_address }</td>
    		</tr>
    		<tr>
    			<td width=30><img src="/resources/image/email.png" width=30 id="email"/></td>
    			<td id="memail">${vo.user_email }</td>
    		</tr>
    	</table>
    </div>
    
    <br/>
    
    <div style="margin-bottom: 20px;">
    	<button id="btnShow1">내가 쓴 글 보기</button>    	 
    	<button id="btnShow2">내가 쓴 댓글 보기</button>
    	<button onClick="location.href='update?user_id=${vo.user_id }'" id="btnShow3">내정보 수정</button>
    </div>
    
    <hr/>
    <div id="ulist"> 
    <button id="btnHidden1">
    	<img src='/resources/css/x-square.svg' class="xbtn">
    </button>  
    <div id="list1">
		<table id="tbl1" width=800></table>
		<script id="temp1" type="text/x-handlebars-template">
		<tr class="title">
			<th width=100>카테고리</th>
			<th width=480>제목</th>
			<th width=80>조회수</th>
			<th width=110>작성일</th>
		</tr>
		{{#each list}}
		<tr class="row" onClick="location.href='/board/read?board_bno={{board_bno}}'">
			<td>{{board_category}}</td>
			<td>{{board_title}}<span style="font-weight:bold;">&nbsp;&nbsp;[{{board_replycnt}}]</span></td>
			<td>{{board_viewcnt}}</td>
			<td>{{board_regdate}}</td>
		</tr>
		{{/each}}
		</script>	
	</div>
	
	<hr/>
	<br/>
	
	<script>	
	getList1();
	function getList1(){
		var board_writer = "${vo.user_id }";
		var page=1;
		$.ajax({
			type:"get",
			url:"/board/ulist.json",
			dataType:"json",
			data:{"page":page, "board_writer":board_writer},
			success:function(result){
				var temp=Handlebars.compile($("#temp1").html());
				$("#tbl1").html(temp(result));
			}
		});
	}
	</script>
	
	<div id="list2">
		<table id="tbl2" width=800></table>
		<script id="temp2" type="text/x-handlebars-template">
		<tr class="title">			
			<th width=590>제목</th>
			<th width=80>조회수</th>
			<th width=110>작성일</th>
		</tr>
		{{#each list}}
		<tr class="row" onClick="location.href='/question/read?question_bno={{question_bno}}'">			
			<td>{{question_title}}</td>
			<td>{{question_viewcnt}}</td>
			<td>{{question_regdate}}</td>
		</tr>
		{{/each}}
		</script>	
	</div>
	
	<hr/>
	<br/>
	
	<script>	
	getList2();
	
	function getList2(){
		var question_writer = "${vo.user_id }";
		var page=1;		
		$.ajax({
			type:"get",
			url:"/question/ulist.json",
			dataType:"json",
			data:{"page":page, "question_writer":question_writer},
			success:function(result){
				var temp=Handlebars.compile($("#temp2").html());
				$("#tbl2").html(temp(result));
			}
		});
	}
	</script>
	
	<div id="list3">
		<table id="tbl3"></table>		
		<script id="temp3" type="text/x-handlebars-template">
		<tr>
		<td>		
		{{#each list}}
		<div class="box" onClick="location.href='/trade/read?trade_bno={{trade_bno}}'">
			<div class="img"><img src="/displayFile?fullName={{trade_image}}" width="120" height="130" style="margin-bottom:10px;"/></div>
			<div class="tratitle">[<span>{{trade_category}}</span>]&nbsp;<span>{{trade_title}}</span></div>
			<div class="price" style="font-weight:bold">{{pattern trade_price}}</div>			
		</div>
		{{/each}}
		</td>
		</tr>
		</script>
		<script>
	   	Handlebars.registerHelper("pattern", function(trade_price){         
	    	if(trade_price == 0){
	        	return "무료";
	        }
	        return trade_price + "원";
	    });
		</script>
	</div>
	
	<hr/>
	<br/>
	
	<script>
	getList3();
	function getList3(){
		var trade_writer = "${vo.user_id}";
		var page=1;
		$.ajax({
			type:"get",
			url:"/trade/ulist.json",
			dataType:"json",
			data:{"page":page, "trade_writer":trade_writer},
			success:function(result){
				var temp=Handlebars.compile($("#temp3").html());
				$("#tbl3").html(temp(result));
			}
		});
	}
	</script>	
    </div>
    
    <script>
	  //게시글 숨기기 보이기
	  $("#ulist").hide();
	  $("#btnShow1").on("click",function(){
	  	$("#ulist").show();  	
	  });
	  
	  $("#btnHidden1").on("click",function(){
	  	$("#ulist").hide();  
	  });
    </script>
    
    <div id="rlist"> 
    <button id="btnHidden2">
    	<img src='/resources/css/x-square.svg' class="xbtn">
    </button>  
    <div id="rlist1">
		<table id="rtbl1" width=800></table>
		<script id="rtemp1" type="text/x-handlebars-template">		
		{{#each list}}
		<tr class="row" onClick="location.href='/board/read?board_bno={{board_bno}}'">			
			<td width=480>{{board_reply}}</td>
			<td width=100>{{board_replyer}}</td>
			<td width=200>{{board_replydate}}</td>
		</tr>
		{{/each}}
		</script>	
	</div>
	
	<hr/>
	<br/>
	
	<script>	
	getList4();
	function getList4(){
		var board_replyer = "${vo.user_id }";
		var page=1;
		$.ajax({
			type:"get",
			url:"/board/uReply.json",
			dataType:"json",
			data:{"page":page, "board_replyer":board_replyer},
			success:function(result){
				var temp=Handlebars.compile($("#rtemp1").html());
				$("#rtbl1").html(temp(result));
			}
		});
	}
	</script>
	
	<div id="rlist2">
		<table id="rtbl2" width=800></table>
		<script id="rtemp2" type="text/x-handlebars-template">		
		{{#each list}}
		<tr class="row" onClick="location.href='/info/read?info_bno={{info_bno}}'">			
			<td width=480>{{info_reply}}</td>
			<td width=100>{{info_replyer}}</td>
			<td width=200>{{info_replydate}}</td>
		</tr>
		{{/each}}
		</script>	
	</div>
	
	<hr/>
	<br/>
	
	<script>	
	getList5();
	
	function getList5(){
		var info_replyer = "${vo.user_id }";
		var page=1;		
		$.ajax({
			type:"get",
			url:"/info/uReply.json",
			dataType:"json",
			data:{"page":page, "info_replyer":info_replyer},
			success:function(result){
				var temp=Handlebars.compile($("#rtemp2").html());
				$("#rtbl2").html(temp(result));
			}
		});
	}
	</script>
	
	<div id="rlist3">
		<table id="rtbl3" width=800></table>		
		<script id="rtemp3" type="text/x-handlebars-template">
		{{#each list}}
		<tr class="row" onClick="location.href='/recipe/read?recipe_bno={{recipe_bno}}'">			
			<td width=480>{{recipe_reply}}</td>
			<td width=100>{{recipe_replyer}}</td>
			<td width=200>{{recipe_replydate}}</td>
		</tr>
		{{/each}}
		</script>
	</div>
	
	<hr/>
	<br/>
	
	<script>
	getList6();
	function getList6(){
		var recipe_replyer = "${vo.user_id}";
		var page=1;
		$.ajax({
			type:"get",
			url:"/recipe/uReply.json",
			dataType:"json",
			data:{"page":page, "recipe_replyer":recipe_replyer},
			success:function(result){
				var temp=Handlebars.compile($("#rtemp3").html());
				$("#rtbl3").html(temp(result));
			}
		});
	}
	</script>	
    </div>
    
    <script>
	  //게시글 숨기기 보이기
	  $("#rlist").hide();
	  $("#btnShow2").on("click",function(){
	  	$("#rlist").show();  	
	  });
	  
	  $("#btnHidden2").on("click",function(){
	  	$("#rlist").hide();  
	  });
    </script>
      
    <!-- 즐겨찾기------------------------------------------------------------------------------------------- -->
    
    <h2>즐겨찾기</h2>
    <div id="board_keep">
    	<table id="tbl_keep1" width=800></table>
		<script id="temp_keep1" type="text/x-handlebars-template">
		<tr class="title">
			<th width=80>카테고리</th>
			<th width=400>제목</th>
			<th width=100>작성자</th>
			<th width=80>조회수</th>
			<th width=120>작성일</th>
		</tr>
		{{#each list}}
		<tr class="row" onClick="location.href='/board/read?board_bno={{board_bno}}'">
			<td>{{board_category}}</td>
			<td>{{board_title}}<span style="font-weight:bold;">&nbsp;&nbsp;[{{board_replycnt}}]</span></td>
			<td>{{board_writer}}</td>
			<td>{{board_viewcnt}}</td>
			<td>{{board_regdate}}</td>
		</tr>
		{{/each}}
		</script>		

	<br/>
	
	<script>	
	getList1();
	function getList1(){
		var user_id = "${vo.user_id }";
		var page=1;
		$.ajax({
			type:"get",
			url:"/board/klist.json",
			dataType:"json",
			data:{"page":page, "user_id":user_id},
			success:function(result){
				var temp=Handlebars.compile($("#temp_keep1").html());
				$("#tbl_keep1").html(temp(result));
			}
		});
	}
	</script>    
    </div>
    
    <div id="info_keep">
    	<table id="tbl_keep2" width=800></table>
		<script id="temp_keep2" type="text/x-handlebars-template">
		<tr class="title">		
			<th width=480>제목</th>
			<th width=100>작성자</th>
			<th width=80>조회수</th>
			<th width=120>작성일</th>
		</tr>
		{{#each list}}
		<tr class="row" onClick="location.href='/info/read?info_bno={{info_bno}}'">		
			<td>{{info_title}}<span style="font-weight:bold;">&nbsp;&nbsp;[{{info_replycnt}}]</span></td>
			<td>{{info_writer}}</td>
			<td>{{info_viewcnt}}</td>
			<td>{{info_regdate}}</td>
		</tr>
		{{/each}}
		</script>	
	</div>
	
	<script>	
	getList2();
	function getList2(){
		var user_id = "${vo.user_id }";
		var page=1;			
		$.ajax({
			type:"get",
			url:"/info/klist.json",
			dataType:"json",
			data:{"page":page, "user_id":user_id},
			success:function(result){
				var temp=Handlebars.compile($("#temp_keep2").html());
				$("#tbl_keep2").html(temp(result));
			}
		});
	}	
	</script>	
    
    <div id="recipe_keep">
    	<table id="tbl_keep4" style="width:800px; margin:0px auto; margin-bottom:10px;"></table>
		<script id="temp_keep4" type="text/x-handlebars-template">
		<tr>
			<td>
			{{#each list}}
			<div class="rbox" onClick="location.href='/recipe/read?recipe_bno={{recipe_bno}}'">
				<div class="rimg"><img src="/displayFile?fullName={{recipe_image}}" width=230/></div>
				<div class="rcate">{{recipe_category}}</div>
				<div class="rtitle">{{recipe_title}}</div>
				<div class="rwriter">{{recipe_writer}}</div>
				<div class="ravg"><img src="/resources/image/0{{format recipe_userRatingAvg}}.png" style="vertical-align: middle; width:150px;" width=150 class="star0{{format recipe_userRatingAvg}}"/>{{format recipe_userRatingAvg}}<span>/5</span></div>		
			</div>
			{{/each}}
			</td>
		</tr>
		</script>
		<script>
		Handlebars.registerHelper("format", function(recipe_userRatingAvg){
			var userRatingAvg = (Math.round(recipe_userRatingAvg));
			return userRatingAvg;
		})
		</script>
    </div>    
    
    <br/>
    
    <script>
    getList4();
    function getList4(){
    	var user_id = "${vo.user_id }";
		var page=1;
		$.ajax({
			type:"get",
			url:"/recipe/klist.json",
			dataType:"json",
			data:{"page":page, "user_id":user_id},
			success:function(result){
				var temp=Handlebars.compile($("#temp_keep4").html());
				$("#tbl_keep4").html(temp(result));
			}
		});
    }
    </script>
    
    <hr/>
    <h2>찜한 물건 보기</h2>
    <div id="trade_keep">
    	<table id="tbl_keep3"></table>		
		<script id="temp_keep3" type="text/x-handlebars-template">
		<tr>
		<td>		
		{{#each list}}
		<div class="box" onClick="location.href='/trade/read?trade_bno={{trade_bno}}'">
			<div class="img"><img src="/displayFile?fullName={{trade_image}}" width="120" height=130 style="margin-bottom:10px;"/></div>
			<div class="tratitle">[<span>{{trade_category}}</span>]&nbsp;<span>{{trade_title}}</span></div>
			<div class="price" style="font-weight:bold">{{pattern trade_price}}</div>			
		</div>
		{{/each}}
		</td>
		</tr>
		</script>
		<script>
	   	Handlebars.registerHelper("pattern", function(trade_price){         
	    	if(trade_price == 0){
	        	return "무료";
	        }
	        return trade_price + "원";
	    });
		</script>
	</div>
	
	<hr/>
	<br/>
	
	<script>
	getList3();
	function getList3(){
		var user_id = "${vo.user_id}";
		var page=1;
		$.ajax({
			type:"get",
			url:"/trade/klist.json",
			dataType:"json",
			data:{"page":page, "user_id":user_id},
			success:function(result){
				var temp=Handlebars.compile($("#temp_keep3").html());
				$("#tbl_keep3").html(temp(result));
			}
		});
	}
	</script>    
    

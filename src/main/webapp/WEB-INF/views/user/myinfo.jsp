<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
	</style>

    <h2>내정보 페이지</h2>
    
    <div width=800>
    	<table border=1 width=600 align="center">
    		<tr>
    			<td rowspan=4 width=300>
    				<c:if test="${vo.user_image==null }">
						<img src="http://placehold.it/250x200" width=250 id="image"/>
					</c:if>
					<c:if test="${vo.user_image!=null }">
						<img src="/displayFile?fullName=${vo.user_image }" width=250 id="image"/>
					</c:if>
					<input type="file" name="file" style="display:none;"/>
    			</td>
    			<td>${vo.user_nick }님(${vo.user_id })</td>
    		</tr>
    		<tr>
    			<td>${vo.user_tel }</td>
    		</tr>
    		<tr>
    			<td>${vo.user_address }</td>
    		</tr>
    		<tr>
    			<td>${vo.user_email }</td>
    		</tr>
    	</table>
    </div>
    
    <br/>
    
    <div>
    	<button id="btnShow">내가 쓴 글 보기</button>    	 
    	<button>내가 쓴 댓글 보기</button>
    	<button onClick="location.href='update?user_id=${vo.user_id }'">내정보 수정</button>
    </div>
    
    <div id="ulist"> 
    <button id="btnHidden">숨기기</button>  
    <div id="list1">
		<table id="tbl1" width=800></table>
		<script id="temp1" type="text/x-handlebars-template">
		<tr class="title">
			<td width=100>카테고리</td>
			<td width=200>제목</td>
			<td width=100>작성자</td>
			<td width=50>작성일</td>
		</tr>
		{{#each list}}
		<tr class="row" onClick="location.href='/board/read?board_bno={{board_bno}}'">
			<td>{{board_category}}</td>
			<td>{{board_title}}<span style="font-weight:bold;">&nbsp;&nbsp;[{{board_replycnt}}]</span></td>
			<td>{{board_writer}}</td>
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
			<td width=200>제목</td>
			<td width=100>작성자</td>
			<td width=50>작성일</td>
		</tr>
		{{#each list}}
		<tr class="row" onClick="location.href='/question/read?question_bno={{question_bno}}'">			
			<td>{{question_title}}</td>
			<td>{{question_writer}}</td>
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
			<div class="img"><img src="/displayFile?fullName={{trade_image}}" width="100"/></div>
			<div class="tratitle">:[<span>{{trade_category}}</span>]&nbsp;<span>{{trade_title}}</span></div>
			<div class="price">:{{trade_price}}원</div>
			<div >{{trade_writer}}</div>
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
  $("#btnShow").on("click",function(){
  	$("#ulist").show();  	
  });
  
  $("#btnHidden").on("click",function(){
  	$("#ulist").hide();  
  });
    </script>
  
    
    <h2>즐겨찾기</h2>
    <div>board</div>
    <div>info</div>
    <div>recipe</div>
    
    <br/>
    
    <h2>찜한 물건 보기</h2>
    <div>trade</div>
    
    
    
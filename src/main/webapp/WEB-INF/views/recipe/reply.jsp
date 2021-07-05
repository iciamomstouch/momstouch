<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>	
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">	
	<title>댓글목록</title>
	<style>
		a {text-decoration:none; color:blue;}
		.active{color:red; font-weight: bold;}
		.star{
		  background: url('http://miuu227.godohosting.com/images/icon/ico_review.png') no-repeat right 0;
		  background-size: auto 100%;
		  width: 30px;
		  height: 30px;
		  display: inline-block;
		  text-indent: -9999px;
		  cursor: pointer;
		}
		.star.on{background-position:0 0;}		
	</style>
	<link rel="stylesheet" href="/resources/css/recipe/reply.css"/>	
</head>
<body>
	<h1>별점주기</h1>
	<div class="starRev">
		<span class="star" onClick="setStar(1)">★</span>
	    <span class="star" onClick="setStar(2)">★</span>
	    <span class="star" onClick="setStar(3)">★</span>
	    <span class="star" onClick="setStar(4)">★</span>
	    <span class="star" onClick="setStar(5)">★</span>  
	</div>
	
	<hr/>
	    
	<div style="width: 780px; padding:10px; border-bottom: 3px solid black;"> 
		<input type="hidden" size=10 id="recipe_replyer" value="${user_id}"/>
		<input type="text" size=58 id="txtReply" placeholder="댓글를 기재해주세요."/>
		<button id="btnInsert" style="height:40px;
									border:none;
									background:white;
									vertical-align : bottom;
									text-align:center;">
			<img src="/resources/css/arrow-down-circle-fill.svg" class="btnInsert">
		</button>		
	</div>
	
	<div id="rtbl" style="width:800px; margin: 0px auto; margin-top:30px;"></div>
	<script id="rTemp" type="text/x-handlebars-template">		
		{{#each list}}
		<table style="width:800px; 
					border:5px solid #D8D8D8;
					border-radius:5px;
					background:#D8D8D8;">
			<tr class="row">
				<td width=100 id="r_rer">{{recipe_replyer}}</td>
				<td id="r_rat">
					<img src="/resources/image/0{{recipe_userRating}}.png" class="star0{{recipe_userRating}}" style="vertical-align: middle; width:100px;">
					{{recipe_userRating}}/5</td>			
				<td width=300 id="r_date">{{recipe_replydate}}</td>
				<td width=50><button class="btnDelete" recipe_rno="{{recipe_rno}}"
					style="height:40px;
					border:none;
					background:#D8D8D8;
					vertical-align : top;
					text-align:center;
					cursor: pointer;">❌</button>
				</td>
			</tr>
			<tr>			
				<td colspan=4 id="r_rely">{{recipe_reply}}</td>	
			</tr>
		</table>
		<br/>
		{{/each}}
	</script>	
</body>
<script>
	var recipe_bno="${vo.recipe_bno }";
	var replyer=$("#recipe_replyer").val();
	var userRating = 0;
	getList();
	
	$(".starRev span").click(function(){		
		  $(this).parent().children('span').removeClass('on');
		  $(this).addClass('on').prevAll('span').addClass('on');		  
		  return userRating;
	});
	
	function setStar(point){
		userRating = point;		
	};
	
	$("#rtbl").on("click", ".row .btnDelete", function(){
		var rno=$(this).attr("recipe_rno");
		if(!confirm(rno + "을(를) 삭제하시겠습니까?")) return;
		$.ajax({
			type:"get",
			url:"reply/delete",
			data:{"recipe_rno":rno},
			success:function(){
				alert("삭제 완료!");
				getList();
			}
		});
	});
	$("#txtReply").on("keydown", function(e){
		if(e.keyCode==13) $("#btnInsert").click();
	})
	
	$("#btnInsert").on("click", function(){		
		var reply=$("#txtReply").val();
		if(reply==""){
			alert("내용을 입력해주세요!");
			return;
		}
		$.ajax({
			type:"post",
			url:"reply/insert",
			data:{"recipe_bno":recipe_bno, "recipe_reply":reply, "recipe_replyer":replyer, "recipe_userRating":userRating},
			success:function(){
				alert("댓글 추가 완료!");
				$("#txtReply").val("");
				getList();
			}
		});
	});

	function getList(){
		$.ajax({
			url:"reply.json",
			type:"get",
			data:{"recipe_bno":recipe_bno},
			dataType:"json",
			success:function(data){				
				var rTemp=Handlebars.compile($("#rTemp").html());
				$("#rtbl").html(rTemp(data));				
			}
		});
	}	
</script>
</html>
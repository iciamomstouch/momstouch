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
</head>
<body>
	<h1>[댓글 목록]</h1>
	<div class="starRev">
		<span class="star" onClick="setStar(1)">★</span>
	    <span class="star" onClick="setStar(2)">★</span>
	    <span class="star" onClick="setStar(3)">★</span>
	    <span class="star" onClick="setStar(4)">★</span>
	    <span class="star" onClick="setStar(5)">★</span>  
	</div>
	
	<div style="padding:10px;">
		<input type="text" size=10 id="recipe_replyer" value="${user_id}"/>
		<input type="text" size=50 id="txtReply"/>
		<input type="button" value="댓글입력" id="btnInsert">		
	</div>
	<table id="rtbl" border=1></table>
	<script id="rTemp" type="text/x-handlebars-template">
		{{#each list}}
		<tr class="row">
			<td width=50 rowspan=2>{{recipe_rno}}</td>
			<td width=100>{{recipe_replyer}}</td>			
			<td width=200>{{recipe_replydate}}</td>
			<td>{{recipe_userRating}}</td>
		</tr>
		<tr class="row">			
			<td colspan=2>{{recipe_reply}}</td>			
			<td><button class="btnDelete" recipe_rno="{{recipe_rno}}">삭제</button></td>
		</tr>
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
		if(!confirm(recipe_rno + "을(를) 삭제하시겠습니까?")) return;
		$.ajax({
			type:"get",
			url:"reply/delete",
			data:{"recipe_rno":recipe_rno},
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
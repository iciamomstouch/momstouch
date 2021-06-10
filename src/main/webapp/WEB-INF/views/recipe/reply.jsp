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
	</style>
</head>
<body>
	<h1>[댓글 목록]</h1>
	<div style="padding:10px;">
		<input type="text" size=50 id="txtReply"/>
		<input type="button" value="댓글입력" id="btnInsert">		
	</div>
	<table id="rtbl" border=1></table>
	<script id="rTemp" type="text/x-handlebars-template">
		{{#each list}}
		<tr class="row">
			<td width=50>{{recipe_rno}}</td>
			<td width=300>{{recipe_reply}}</td>
			<td>{{recipe_replydate}}</td>
			<td><button class="btnDelete" rno="{{recipe_rno}}">삭제</button></td>
		</tr>
		{{/each}}
	</script>	
</body>
<script>
	var recipe_bno="${vo.recipe_bno }";	
	getList();	

	function getList(){
		$.ajax({
			url:"/recipe/reply.json",
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
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>	
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>댓글목록</title>
	<link rel="stylesheet" href="/resources/css/info/reply.css"/>
	<style>
		a {text-decoration:none; color:blue;}
		.active{color:red; font-weight: bold;}
	</style>
</head>
<body>
	<div style="width: 800px; padding:10px;">
		<input type="text" size=80 id="txtReply"/>
		<input type="button" value="댓글입력" id="btnInsert">		
	</div>
	<table id="rtbl"></table>
	<script id="rTemp" type="text/x-handlebars-template">
		{{#each list}}
		<tr class="row">
			<td id="i_rno">{{info_rno}}</td>
			<td id="i_rer">{{info_replyer}}</td>
			<td id="i_rdate">{{info_replydate}}</td>
			<td id="idel"><button class="btnDelete" rno="{{info_rno}}">❌</button></td>
		</tr>
		<tr>
			<td colspan="3" id="i_rely">{{info_reply}}</td>			
		</tr>
		{{/each}}
	</script>	
</body>
	<script>
	var info_bno="${vo.info_bno }";
	
	getList();	

	function getList(){
		$.ajax({
			url:"reply.json",
			type:"get",
			data:{"info_bno":info_bno},
			dataType:"json",
			success:function(data){				
				var rTemp=Handlebars.compile($("#rTemp").html());
				$("#rtbl").html(rTemp(data));				
			}
		});
	}
	//댓글 삭제
	$("#rtbl").on("click", ".row .btnDelete", function(){
	var rno=$(this).attr("rno");
	if(!confirm(rno + "을(를) 삭제하실래요?")) return;
		$.ajax({
			type:"get",
			url:"reply/delete",
			data:{"info_rno":rno},
			success:function(){
				alert("삭제완료!");
				getList();
			}
		});
	});
	
	//댓글 등록
	$("#btnInsert").on("click", function(){
		var reply=$("#txtReply").val();
		var replyer="${user_id}";
		if(reply==""){
			alert("내용을 입력하세요!");
			return;
		}
		$.ajax({
			type:"post",
			url:"reply/insert",
			data:{"info_bno":info_bno, "info_reply":reply, "info_replyer":replyer},
			success:function(){
				alert("댓글추가완료!");
				$("#txtReply").val("");
				getList();
			}
		});
	});
	</script>
</html>
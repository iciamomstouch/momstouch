<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
 	<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
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
		<span>댓글수:<span id="totalCount"></span>건</span>
	</div>
	<table id="tbl" border=1></table>
	<script id="temp" type="text/x-handlebars-template">
		{{#each list}}
		<tr class="row">
			<td width=50>{{recipe_rno}}</td>
			<td width=300>{{recipe_reply}}</td>
			<td>{{recipe_replydate}}</td>
			<td><button class="btnDelete" rno="{{recipe_rno}}">삭제</button></td>
		</tr>
		{{/each}}
	</script>
	<div id="pagination"></div>
</body>
<script>
	var recipe_bno="${vo.recipe_bno }";
	
	getList();
	
	$("#tbl").on("click", ".row .btnDelete", function(){
		var rno=$(this).attr("rno");
		if(!confirm(rno + "을(를) 삭제하실래요?")) return;
		$.ajax({
			type:"get",
			url:"reply/delete",
			data:{"rno":rno},
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
		if(reply=="") {
			alert("내용을 입력하세요!");
			return;
		}
		$.ajax({
			type:"post",
			url:"/reply/insert",
			data:{"bno": bno, "reply":reply},
			success:function(){
				alert("댓글 추가완료!");
				$("#txtReply").val("");
				getList();
			}
		});
	});

	function getList(){
		$.ajax({
			url:"/recipe/reply.json",
			type:"get",
			data:{"recipe_bno":recipe_bno},
			dataType:"json",
			success:function(data){
				var temp=Handlebars.compile($("#temp").html());
				$("#tbl").html(temp(data));
				$("#totalCount").html(data.pm.totalCount);
				var str="";
				if(data.pm.prev){
					str += "<a href='" + (data.pm.startPage-1) + "'>이전 </a>";
				}
				for(var i=data.pm.startPage; i<=data.pm.endPage; i++){
					if(i==page){
						str += "<a href='"+i +"' class='active'>" + i + "</a> ";
					}else{
						str += "<a href='"+i +"'>" + i + "</a> ";
					}
				}
				if(data.pm.next){
					str += "<a href='" + (data.pm.endPage+1) + "'>다음 </a>";
				}
				$("#pagination").html(str);
			}
		});
	}
	
	$("#pagination").on("click", "a", function(e){
		e.preventDefault();
		page=$(this).attr("href");
		getList();
	});
</script>
</html>
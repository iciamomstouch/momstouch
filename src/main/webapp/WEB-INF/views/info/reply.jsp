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
	<div style="width: 780px; padding:10px; border-bottom: 3px solid black;">
		<input type="text" size=55 id="txtReply" placeholder="댓글을 기재해주세요."/>
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
			<td id="i_rer">{{user_nick}}</td>
			<td id="i_rdate">{{info_replydate}}</td>
			<td id="idel"><button class="btnDelete" rno="{{info_rno}}"
				style="{{printDel info_replyer}};
				height:40px;
				border:none;
				background:#D8D8D8;
				vertical-align : top;
				text-align:center;">❌</button></td>
		</tr>
		<tr>
			<td colspan="3" id="i_rely">{{info_reply}}</td>			
		</tr>
		</table>
		<br/>
		{{/each}}
	</script>	
</body>
	<script>
	//로그인한 아이디만 댓글삭제버튼노출 
	Handlebars.registerHelper("printDel", function(board_replyer){
	   var user_id="${user_id}";
	   var user_type="${user_type}";
	   if(user_id!=board_replyer){
		   if(user_type == 'admin'){
			   return "";
		   }
	      return "display:none;";
	   }
	});
	
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
		if(replyer == "" ){
			alert("로그인 후 이용가능합니다.")
		}else{
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
		}
	});
	</script>
</html>
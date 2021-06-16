<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

	<h1>[댓글 목록]</h1>
	<div style="padding:10px;">
		<input type="text" size=50 id="txtReply"/>
		<input type="button" value="댓글입력" id="btnInsert">		
	</div>
	<table id="rtbl" border=1></table>
	<script id="rTemp" type="text/x-handlebars-template">
		{{#each list}}
		<tr class="row">
			<td width=50>{{board_rno}}</td>
			<td width=100>{{board_replyer}}</td>
			<td width=300>{{board_reply}}</td>
			<td>{{board_replydate}}</td>
			<td><button class="btnDelete" rno="{{board_rno}}">삭제</button></td>
		</tr>
		{{/each}}
	</script>	

	<script>
		var board_bno="${vo.board_bno }";
		
		getList();
		
		function getList(){
			$.ajax({
				url:"/board/reply.json",
				type:"get",
				data:{"board_bno":board_bno},
				dataType:"json",
				success:function(data){				
					var rTemp=Handlebars.compile($("#rTemp").html());
					$("#rtbl").html(rTemp(data));				
				}
			});
		}		
	</script>
</html>
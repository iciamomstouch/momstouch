<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<head>
 	<title>댓글목록</title>
 	<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>	 
</head>
<body>
 <div id="divReply">
 <div class="header">
	 댓글목록
 <span style="float:right"><button id="btnReplyOpen">댓글쓰기</button></span>
 </div>
 <div id="replies"></div>
 <script id="temp" type="text/x-handlebars-template">
 	{{#each .}}
 	<div rno="{{rno}}">
 		<span class="replyer">{{replyer}}</span>
 		<span class="replyDate">{{replyDate}}</span>
 		<div class="reply">{{reply}}</div>
 		<div><button class="btnUpdate">수정</button></div>
 		<hr style="border:0.5px dotted gray;">
 	</div>
 	{{/each}}
 </script>
 </div>
</body>
<script>
	 var page=1;
	 var bno=284;
	 getReplyList();
	 function getReplyList(){
	 	$.ajax({
	 		type:"get", 
	 		url:"/reply/list", 
	 		data:{"bno":bno, "page":page}, 
	 		success:function(data){
	 			var temp=Handlebars.compile($("#temp").html());
	 			$("#replies").html(temp(data));
	 		}
	 	});
	 }
</script>
</html>
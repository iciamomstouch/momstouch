<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>중고거래 보기</title>
	<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
	<link rel="stylesheet" href="/resources/css/trade/style.css"/>
</head>
<body>
	<h1>중고거래 보기</h1>
	<form name="frm" enctype="multipart/form-data">
	<table border=1>
		<input type="text" name="trade_bno" value="${vo.trade_bno}" style="display:none"/>
		<tr>
			<td><input type="text" name="trade_writer" value="${vo.trade_writer}"/></td>
			<td><fmt:formatDate value="${vo.trade_regdate}" pattern="yyyy-MM-dd kk:mm:ss"/></td>
			<td>조회수:${vo.trade_viewcnt}</td>
		</tr>
		<tr>
			<td>
				<select name="trade_category" value="${vo.trade_category}">	
					<option>${vo.trade_category}</option>
					<option value="구매">구매</option>
					<option value="판매">판매</option>
					<option value="나눔">나눔</option>
				</select>
			</td>
			<td colspan=2>${vo.trade_title}</td>
		</tr>
		<tr>
			<td colspan=3>
			<div id="slide">
		  		<input type="radio" name="pos" id="pos1" checked>
		  		<input type="radio" name="pos" id="pos2">
		  		<input type="radio" name="pos" id="pos3">
		 		<input type="radio" name="pos" id="pos4">
	          		<ul id="attachFiles"></ul>
	                <script id="temp" type="text/x-handlebars-template">
					{{#each list}}
                    	<img class="main_slideImg" src="/displayFile?fullName={{trade_bno}}/{{trade_attach_image}}" width=200/>
					{{/each}}
                  	</script>
		    	<p class="pos">
				    <label for="pos1"></label>
				    <label for="pos2"></label>
				    <label for="pos3"></label>
				    <label for="pos4"></label>
			  	</p>
		    </div>
			</td>
		</tr>
		<tr>
			<td colspan=3>${vo.trade_content}</td>
		<tr>
		<tr>
			<td>${vo.trade_keep}</td>
			<td>${vo.trade_price}</td>
			<td><button>채팅으로 거래하기</button></td>
		</tr>
	</table>
	<input type="submit" value="글수정"/>
	<input type="reset" value="수정취소"/>
	<input type="button" value="글삭제" id="btnDelete"/>
	<input type="button" value="목록이동" onClick="location.href='list'"/>
	</form>
</body>
<script>
	var trade_bno=$(frm.trade_bno).val();
	
	
	$("#btnDelete").on("click", function(){
		if(!confirm("삭제하실래요?")) return;
		frm.action="delete";
		frm.method="get";
		frm.submit();
	});
	
	//첨부파일 출력
	   getAttach();   
	   function getAttach(){
	      $.ajax({
	         type:"get",
	         url:"getAttach",
	         data:{"trade_bno":trade_bno},
	         dataType:"json",
	         success:function(data){
	            var temp = Handlebars.compile($("#temp").html());
	            $(data).each(function(){	                     
	            $("#attachFiles").append(temp(data));
	            })
	         }
	      })
	   }
	   
		//첨부 파일삭제
		$("#attachFiles").on("click", "li .del", function(){
			var li=$(this).parent();
			var fullName = $(this).attr("fullName");
			if(!confirm(fullName + "을 삭제하실래요?")) return;
			$.ajax({
				type:"get",
				url:"/deleteFile",
				data:{"fullName":fullName},
				success:function(){
					alert("삭제완료!");
					li.remove();
				}
			})
		});
</script>
</html>
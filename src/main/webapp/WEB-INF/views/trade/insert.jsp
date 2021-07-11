<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" href="/resources/css/trade/insert.css"/>
	<title>중고거래  글작성</title>
	<style>
		#image{cursor:pointer;}
	</style>
</head>
<body>
	<form name="frm" enctype="multipart/form-data">
		<input type="hidden" name="trade_bno" value="${bno}"/>
		<input type="hidden" name="trade_writer" value="${user_id}" />
		<table class="tbl" style="width:600px; margin:0px auto; margin-bottom:10px;">
			<tr>
				<td id="id">${user_nick}</td>
			</tr>
			<tr>
				<td>
					<select name="trade_category" id="option">
						<option value="구매">구매</option>
						<option value="판매">판매</option>
						<option value="나눔">나눔</option>
					</select>
				</td>
				<td id="title"><input type="text" name="trade_title" size=40  placeholder="제목을 기재해주세요." style="font-size: 15px;background-color:transparent;border:0 solid black;text-align:left;"/></td>
			</tr>		
			<tr>
				<td colspan="2" id="price" style="text-align:left;">
					<input type="number" name="trade_price" size=90 placeholder="가격을 기재해주세요." style="font-size: 20px;background-color:transparent;border:0 solid black;text-align:left;"/><a style="font-size: 25px;
	  				font-weight:bold;">원</a>
				</td>
			</tr>
			
			<tr>
				<td colspan=2 id="content">
					<textarea rows="10" cols="70" name="trade_content" placeholder="내용을 기재해주세요." style="font-size: 15px;background-color:transparent;border:0 solid black;text-align:left;padding-top:10px;"></textarea>
				</td>
			</tr>
			<tr>
				<td width=100 id="img" style="text-align:center;">대표 이미지</td>
				<td id="img">
					<img src="http://placehold.it/300x200" width=300 id="image"/>
					<input type="file" name="file" style="display:none;"/>
				</td>
			</tr>
			<tr>
				<td style="border-bottom: 1px solid #ccc;"><input type="button" value="➕" style="border:none; background:white; cursor: pointer; text-align:left; font-size:15px;" id="btnImage" /></td>
				<td style="height:150px;padding:10px;border-bottom: 1px solid #ccc;">
	            	<input type="file" name="files" accept="image/*" multiple style="display:none"/>
	            	<div id="listFile"></div>	     			
            	</td>
			</tr>
		</table>
		<input type="submit" value="새글등록" id="btnUpdate"/>
		<input type="reset" value="등록취소" id="btnReset"/>
		<input type="button" value="목록이동" onClick="location.href='list'" id="btnList"/>
	</form>
</body>
<script>
	$(frm).on("submit", function(e){
		e.preventDefault();
		
		var trade_title=$(frm.trade_title).val();
		if(trade_title==""){
			alert("제목을 입력하세요!");
			return;
		}
		
		if(!confirm("새글을 등록하실래요?")) return;
		frm.action="insert";
		frm.method="post";
		frm.submit();
	});
	
	$("#image").on("click", function(){
		$(frm.file).click();
	});
	
	//이미지 미리보기
	$(frm.file).on("change", function(){
		var file=$(frm.file)[0].files[0];
		$("#image").attr("src", URL.createObjectURL(file));
	});	
	
	$("#btnImage").on("click", function(){
		$(frm.files).click();
	});
	
	//첨부 파일들을 선택한경우
	$(frm.files).on("change", function(){
		var files=$(frm.files)[0].files;//파일을 여러개 선택할경우		
		$.each(files, function(index, file){
			var str = "<img width=150 src='" + URL.createObjectURL(file) + "'/>";
			$("#listFile").append(str);
		});
	});
	
</script>
</html>
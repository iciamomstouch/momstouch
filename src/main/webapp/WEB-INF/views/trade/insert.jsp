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
</head>
<body>

	<form name="frm" enctype="multipart/form-data">
	<input type="hidden" name="trade_bno" value="${bno}"/>
	
		<table class="tbl" style="width:800px; text-align:center; margin-bottom:10px;">
			<tr>
				<td id="id">${user_id}</td>
			</tr>
			<tr>
				<td>
					<select name="trade_category" id="option">
						<option value="구매">구매</option>
						<option value="판매">판매</option>
						<option value="나눔">나눔</option>
					</select>
				</td>
				<td id="title"><input type="text" name="trade_title" size=60  placeholder="제목을 기재해주세요." style="font-size: 15px;background-color:transparent;border:0 solid black;text-align:left;"/></td>
			</tr>		
			<tr>
				<td colspan="2" id="price" style="text-align:left;">
					<input type="number" name="trade_price" size=90  placeholder="가격을 기재해주세요." style="font-size: 20px;background-color:transparent;border:0 solid black;text-align:left;"/><a style="font-size: 25px;
	  				font-weight:bold;">원</a>
				</td>
			</tr>
			
			<tr>
				<td colspan=2 id="content">
					<textarea rows="10" cols="90" name="trade_content"  placeholder="내용을 기재해주세요." style="font-size: 15px;background-color:transparent;border:0 solid black;text-align:left;padding-top:10px;"></textarea>
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
				<td style="border-bottom: 1px solid #ccc;"><input type="button" value="상세이미지" style="border:none; background:white; cursor: pointer; text-align:left; font-size:15px;"/></td>
				<td style="height:150px;padding:10px;border-bottom: 1px solid #ccc;">
	            	<input type="file" name="files" accept="image/*" multiple style="display:none"/>
	     			<div id="uploaded">
	                	<ul id="uploadFiles"></ul>
	                 	<script id="temp" type="text/x-handlebars-template">
                  		<li style="text-align:left;">
                    		<img src="/displayFile?fullName={{fullName}}" width=300/>
                     		<input type="text" name="files" value="{{fullName}}"/>
                     		<input class="del" type="button" value="❌" fullName={{fullName}}/>
                  		</li>
                  		</script>
	              	</div>
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
	
	//첨부 파일들을 선택한경우
	   $(frm.files).on("change", function(){
	      var files=$(frm.files)[0].files;
	      $.each(files, function(index, file){
	         uploadFile(file);
	      });
	   });
	
	   
	function uploadFile(file){
		if(file == null) return;
      	var formData=new FormData();
      	formData.append("file", file);
      
      	$.ajax({
        	type:"post",
         	url:"/uploadFile",
         	processData:false,
         	contentType:false,
         	data:formData,
         	success:function(data){
            	var temp=Handlebars.compile($("#temp").html());
            	var tempData={"fullName":data};
            	$("#uploadFiles").append(temp(tempData));
         	}
		});
	}
	
	$("#btnImage").on("click", function(){
		$(frm.files).click();
	});
	
	//첨부 파일삭제
	$("#uploadFiles").on("click", "li .del", function(){
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
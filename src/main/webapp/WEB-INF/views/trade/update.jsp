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
		<input type="hidden" name="trade_bno" value="${vo.trade_bno}"/>
		<input type="hidden" name="trade_writer" value="${user_id}" />
		<table class="tbl" style="width:800px; text-align:center; margin-bottom:10px;">
			<tr>
				<td id="id">${user_id}</td>
			</tr>
			<tr>
				<td>
					<select name="trade_category" id="option">
						<option value="구매" <c:out value="${vo.trade_category=='구매'?'selected':''}"/>>구매</option>
						<option value="판매" <c:out value="${vo.trade_category=='판매'?'selected':''}"/>>판매</option>
						<option value="나눔" <c:out value="${vo.trade_category=='나눔'?'selected':''}"/>>나눔</option>
					</select>
				</td>
				<td id="title"><input type="text" name="trade_title" value="${vo.trade_title }" size=60  placeholder="제목을 기재해주세요." style="font-size: 15px;background-color:transparent;border:0 solid black;text-align:left;"/></td>
			</tr>		
			<tr>
				<td colspan="2" id="price" style="text-align:left;">
					<input type="number" name="trade_price" value="${vo.trade_price }" size=90  placeholder="가격을 기재해주세요." style="font-size: 20px;background-color:transparent;border:0 solid black;text-align:left;"/><a style="font-size: 25px;
	  				font-weight:bold;">원</a>
				</td>
			</tr>
			
			<tr>
				<td colspan=2 id="content">
					<textarea rows="10" cols="90" name="trade_content"  placeholder="내용을 기재해주세요." style="font-size: 15px;background-color:transparent;border:0 solid black;text-align:left;padding-top:10px;">${vo.trade_content }</textarea>
				</td>
			</tr>
			<tr>
				<td width=100 id="img" style="text-align:center;">대표 이미지</td>
				<td id="img">
					<c:if test="${vo.trade_image==null }">
						<img src="http://placehold.it/300x240" width=300 id="image"/>
					</c:if>
					<c:if test="${vo.trade_image!=null }">
						<img src="/displayFile?fullName=${vo.trade_image }" width=300 id="image"/>
					</c:if>
					<input type="file" name="file" style="display:none;"/>
				</td>
			</tr>
			<tr>
				<td style="border-bottom: 1px solid #ccc;"><input type="button" value="상세이미지" style="border:none; background:white; cursor: pointer; text-align:left; font-size:15px;" id="btnImage" /></td>
				<td style="height:150px;padding:10px;border-bottom: 1px solid #ccc;">
	            	<input type="file" name="files" accept="image/*" multiple style="display:none"/>
	            	<div id="listFile"></div>
	     			<div id="uploaded">
	                	<ul id="uploadFiles"></ul>
	                 	<script id="temp" type="text/x-handlebars-template">
                  		{{#each list}}
                  			<li>
                    			<img src="/displayFile?fullName={{trade_bno}}/{{trade_attach_image}}" width=100/>
               					<input type="text" name="files" value="{{trade_attach_image}}"/>
                     			<input class="del" type="button" value="삭제" fullName="{{trade_attach_image}}"/>
                  			</li>
						{{/each}}
                  		</script>
	              	</div>
            	</td>
			</tr>
		</table>
		<input type="submit" value="게시글수정" id="btnUpdate"/>
		<input type="reset" value="수정취소" id="btnReset"/>
		<input type="button" value="목록이동" onClick="location.href='list'" id="btnList"/>
	</form>
</body>
<script>
var trade_bno=$(frm.trade_bno).val();
	//게시글 수정
	$(frm).on("submit", function(e){
		e.preventDefault();
		
		var trade_title=$(frm.trade_title).val();
		if(trade_title==""){
			alert("제목을 입력하세요!");
			return;
		}		
		if(!confirm("글을 수정등록하실래요?")) return;
		frm.action="update";
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
		var files=$(frm.files)[0].files;//파일을 여러개 선택할경우		
		$.each(files, function(index, file){
			var str = "<img width=150 src='" + URL.createObjectURL(file) + "'/>";
			$("#listFile").append(str);
		});
	});	
	
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
			url:"/trade_deleteFile",
			data:{"fullName":fullName, "trade_bno":trade_bno},
			success:function(){
				alert("삭제완료!");
				li.remove();
			}
		})
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
	            $("#uploadFiles").append(temp(data));
	            });
	         }
	      });
	   }
</script>
</html>
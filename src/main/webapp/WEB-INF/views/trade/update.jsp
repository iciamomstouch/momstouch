<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>중고거래</title>
</head>
<body>
	<h1>게시글 수정하기</h1>
	<form name="frm" enctype="multipart/form-data">
		<table border=1>
			<tr>
				<td>번호</td>
				<td colspan=3><input type="text" name="trade_bno" value="${vo.trade_bno}" size=50/></td>
			</tr>
			<tr>
				<td>제목</td>
				<td colspan=3><input type="text" name="trade_title" value="${vo.trade_title}" size=50/></td>
			</tr>
			<tr>
				<td>작성자</td>
				<td colspan=3><input type="text" name="trade_writer" value="${vo.trade_writer}" size=50/></td>
			</tr>
			<tr>
				<td>가격</td>
				<td colspan=3><input type="num" name="trade_price" value="${vo.trade_price}" size=50/></td>
			</tr>
			<tr>
				<td>카테고리</td>
				<td colspan=3>
					<select name="trade_category">
						<option value="구매">구매</option>
						<option value="판매">판매</option>
						<option value="나눔">나눔</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>제품이미지</td>
				<td>
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
				<td>내용</td>
				<td colspan=3>
					<textarea rows="10" cols="52" name="trade_content">${vo.trade_content}</textarea>
			</td>
			</tr>
			<tr>
				<td><input type="button" value="첨부이미지" id="btnImage"/></td>
				<td style="height:150px;padding:10px;">
	            	<input type="file" name="files" accept="image/*" multiple style="display:none"/>
	     			<div id="uploaded">
	                	<ul id="attachFiles"></ul>
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
		<input type="submit" value="게시글 수정"/>
		<input type="reset" value="등록취소"/>
		<input type="button" value="목록이동" onClick="location.href='list'"/>
	</form>
</body>
<script>
var trade_bno=$(frm.trade_bno).val();
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
	$("#attachFiles").on("click", "li .del", function(){
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
	            $("#attachFiles").append(temp(data));
	            });
	         }
	      });
	   }
</script>
</html>
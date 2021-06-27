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
	<title>중고거래 새 글작성</title>
</head>
<body>
	<h1>중고거래 새 글작성</h1>
	<form name="frm" enctype="multipart/form-data">
		<table border=1>
			<tr>
				<td>번호</td>
				<td><input type="text" name="trade_bno" value="${bno }"/></td>
			</tr>
			<tr>
				<td>제목</td>
				<td><input type="text" name="trade_title"/></td>
			</tr>
			<tr>
				<td>작성자</td>
				<td><input type="text" name="trade_writer" value="${user_id }"/></td>
			</tr>
			<tr>
				<td>가격</td>
				<td><input type="number" name="trade_price"/></td>
			</tr>
			<tr>
				<td>카테고리</td>
				<td>
					<select name="trade_category">
						<option value="구매">구매</option>
						<option value="판매">판매</option>
						<option value="나눔">나눔</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>내용</td>
				<td>
					<textarea rows="10" cols="52" name="trade_content"></textarea>
				</td>
			</tr>
			<tr>
				<td width=100>이미지</td>
				<td width=300>
					<img src="http://placehold.it/150x120" width=150 id="image"/>
					<input type="file" name="file" style="display:none;"/>
				</td>
			</tr>
			<tr>
				<td><input type="button" value="첨부이미지" id="btnImage"/></td>
				<td style="height:150px;padding:10px;">
	            	<input type="file" name="files" accept="image/*" multiple style="display:none"/>
	     			<div id="uploaded">
	                	<ul id="uploadFiles"></ul>
	                 	<script id="temp" type="text/x-handlebars-template">
                  		<li>
                    		<img src="/displayFile?fullName={{fullName}}" width=50/>
                     		<input type="text" name="files" value="{{fullName}}"/>
                     		<input class="del" type="button" value="삭제" fullName="{{fullName}}"/>
                  		</li>
                  		</script>
	              	</div>
            	</td>
			</tr>
		</table>
		<input type="submit" value="새글등록"/>
		<input type="reset" value="등록취소"/>
		<input type="button" value="목록이동" onClick="location.href='list'"/>
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
			url:"/trade_deleteFile",
			data:{"fullName":fullName},
			success:function(){
				alert("삭제완료!");
				li.remove();
			}
		})
	});

</script>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" href="/resources/css/recipe/insert.css"/>
	<title>레시피 게시판</title>
</head>
<body>
	<form name="frm" enctype="multipart/form-data">
		<input type="hidden" name="recipe_bno" value="${bno}"/>
		<input type="hidden" name="recipe_writer" value="${user_id}" />
		<table class="tbl" style="width:800px; text-align:center; margin-bottom:10px;">
			<tr>
				<td colspan=4 id="id">${user_id}</td>
			</tr>
			<tr>
				<td colspan=1>
					<select name="recipe_category" id="option">
						<option value="산모">산모</option>
						<option value="초기">초기</option>
						<option value="중기">중기</option>
						<option value="후기">후기</option>
						<option value="완료기">완료기</option>
					</select>
				</td>
				<td colspan=4 id="title"><input type="text" name="recipe_title" size=70 placeholder="제목을 기재해주세요." style="font-size: 15px;background-color:transparent;border:0 solid black;text-align:left;"/></td>
			</tr>

			<tr>
				<td width=100 style="border-bottom: 1px solid #ccc; font-weight:bold;">대표 이미지</td>
				<td width=300 colspan=3 id="img">
					<img src="http://placehold.it/150x120" style="width:150px; text-align:center;" id="image"/>
					<input type="file" name="file" style="display:none;"/>
				</td>
			</tr>
			<tr>
				<td colspan=4 id="content">
					<textarea rows="3" cols="70" name="recipe_ingre" placeholder="재료를 기재해주세요." style="font-size: 15px;background-color:transparent;border:0 solid black;text-align:left;"></textarea>
				</td>
			</tr>
			<tr>
				<td colspan=4 id="content">
					<textarea rows="3" cols="70" name="recipe_seasoning" placeholder="양념을 기재해주세요." style="font-size: 15px;background-color:transparent;border:0 solid black;text-align:left;"></textarea>
				</td>
			</tr>
			<tr>
				<td colspan=4 id="content">
					<textarea rows="5" cols="70" name="recipe_content" placeholder="내용을 기재해주세요." style="font-size: 15px;background-color:transparent;border:0 solid black;text-align:left;"></textarea>
				</td>
			</tr>
			
			<tbody id="attach_list">			
			<tr id="sublist">				
	     		<td>
	     			<input type="hidden" name="recipe_attach_no" value="1"/>
	     			<input type="button" value="행추가" onclick="add_new_row('attach_list',0);"/>
	     		</td>
	     		<td width=100>
					<img src="http://placehold.it/150x120" width=150 id="image1"/>
					<input type="file" name="files"/>
				</td>
				<td>
					<textarea rows="5" cols="40" name="recipe_attach_text"></textarea>
				</td>
				<td>
					<button type="button">
						<img src="/resources/css/dash-circle-fill.svg" class="x">
					</button>
				</td>            	
			</tr>
			</tbody>
		</table>
		<input type="submit" value="새글등록" id="btnUpdate"/>
		<input type="reset" value="등록취소" id="btnReset"/>
		<input type="button" value="목록이동" onClick="location.href='list'" id="btnList"/>
		
	</form>
</body>
<script>
	var num_rows=1;
	var new_row_num=1;
	function add_new_row(obj,n) {
	    $("#num_rows").val(++num_rows);
	    var tag = ""
	    tag +="<tr id='tr_id"+(new_row_num + n)+ "'>\n";
	    tag +="<td>"+"<input type='text' name='recipe_attach_no' value='" + ((new_row_num + n) +1)+ "'/></td>\n";
	    tag +="<td>\n";
	    tag +="<img src='http://placehold.it/150x120' width=150 id='image" + ((new_row_num + n) +1) + "'/>\n";
	    tag +="<input type='file' name='files'/>\n";	   
	    tag +="</td>\n";
	    tag +="<td>\n";
	  	tag +="<textarea rows='5' cols='52' name='recipe_attach_text'></textarea>"
	  	tag +="</td>\n";
	  	tag +="<td>\n";
	    tag +="<button type='button'>삭제</button>\n";
	    tag +="</td>\n";
	    tag +="</tr>\n";
	  
	    $("#"+obj).append(tag);
	    new_row_num++;
	}
	
	$('#attach_list').on("click", "button", function() {
	    $(this).closest("tr").remove()
	});
	
	//게시글 등록
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
	
	$(".images").on("click", function(){
		$(frm.files).click();
	});
	
	//이미지 미리보기
	$(frm.files).on("change", function(){
		var file=$(frm.files)[0].files[0];
		$(".images").attr("src", URL.createObjectURL(file));
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
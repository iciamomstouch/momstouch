<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>레시피</title>
</head>
<body>
	<h1>레시피 수정하기</h1>
	<form name="frm" enctype="multipart/form-data">
		<table border=1>
			<tr>
				<td>번호</td>
				<td colspan=3><input type="text" name="recipe_bno" value="${vo.recipe_bno}" size=50/></td>
			</tr>
			<tr>
				<td>제목</td>
				<td colspan=3><input type="text" name="recipe_title" value="${vo.recipe_title}" size=50/></td>
			</tr>
			<tr>
				<td>작성자</td>
				<td colspan=3><input type="text" name="recipe_writer" value="${user_id}" size=50/></td>
			</tr>
			<tr>
				<td>카테고리</td>
				<td colspan=3>
					<select name="recipe_category">
						<option value="산모">산모</option>
						<option value="초기">초기</option>
						<option value="중기">중기</option>
						<option value="후기">후기</option>
						<option value="완료기">완료기</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>요리이미지</td>
				<td>
					<c:if test="${vo.recipe_image==null }">
						<img src="http://placehold.it/300x240" width=300 id="image"/>
					</c:if>
					<c:if test="${vo.recipe_image!=null }">
						<img src="/displayFile?fullName=${vo.recipe_image }" width=300 id="image"/>
					</c:if>
					<input type="file" name="file" style="display:none;"/>
				</td>
			</tr>
			<tr>
				<td>내용</td>
				<td colspan=3>
					<textarea rows="10" cols="52" name="recipe_content">${vo.recipe_content}</textarea>
				</td>
			</tr>
			<tr>
				<td>재료</td>
				<td colspan=3>
					<textarea rows="5" cols="52" name="recipe_ingre">${vo.recipe_ingre}</textarea>
				</td>
			</tr>
			<tr>
				<td>양념장</td>
				<td colspan=3>
					<textarea rows="5" cols="52" name="recipe_seasoning">${vo.recipe_seasoning}</textarea>
				</td>
			</tr>
			<tr>
				<td>조리순서</td>
				<td style="height:150px;padding:10px;" colspan=3>					
					<table id="attachFiles"></table>
					<script id="temp" type="text/x-handlebars-template">
					{{#each list}}
					<tr>
						<td>{{recipe_attach_no}}</td>
						<td><img src="/displayFile?fullName={{recipe_bno}}/{{recipe_attach_image}}" width=100/></td>									
						<td><textarea rows="8" cols="35" >{{recipe_attach_text}}</textarea></td>
						<td><input type="button" class="del" value="삭제" fullName="{{recipe_attach_image}}" num="{{recipe_attach_no}}"/></td>					
					</tr>
					{{/each}}	
					</script>									
				</td>
			</tr>
			<tbody id="attach_list">			
			<tr>				
	     		<td>
	     			<input type="text" name="recipe_attach_no" value="${attachNo}"/>
	     		</td>
	     		<td width=300>
					<img src="http://placehold.it/150x120" width=150 id="image1"/>
					<input type="file" name="files"/>
				</td>
				<td>
					<textarea rows="5" cols="52" name="recipe_attach_text"></textarea>
				</td>
				<td>
					<button type="button">삭제</button>
				</td>            	
			</tr>
			</tbody>
		</table>
		<input type="submit" value="레시피 수정"/>
		<input type="reset" value="등록취소"/>
		<input type="button" value="목록이동" onClick="location.href='list'"/>
		<input type="button" value="행추가" onclick="add_new_row('attach_list',0);"/>
		
	</form>
</body>
<script>
	var num_rows=1;
	var new_row_num=${attachNo};
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
		
		var recipe_title=$(frm.recipe_title).val();
		if(recipe_title==""){
			alert("제목을 입력하세요!");
			return;
		}
		
		if(!confirm("수정하실래요?")) return;
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
	
	//파일 삭제
	$("#attachFiles").on("click", "tr td .del", function(){
		var recipe_bno=$(frm.recipe_bno).val();
		var image = $(this).attr("fullName");
		var num = $(this).attr("num");
		if(!confirm(image + "파일을 삭제하실래요?")) return;
		$(this).closest("tr").remove();
		$.ajax({
			type:"get",
			url:"/deleteFile",
			data:{"fullName":image, "recipe_bno":recipe_bno, "recipe_attach_no":num},
			success:function(){
				alert("삭제완료");
				
			}
		})		
	});
	
	//첨부파일 출력
	getAttach();	
	function getAttach(){
		var recipe_bno=$(frm.recipe_bno).val();
		$.ajax({
			type:"get",
			url:"getAttach.json",
			data:{"recipe_bno":recipe_bno},
			dataType:"json",
			success:function(data){				
				var temp = Handlebars.compile($("#temp").html());								
				$("#attachFiles").append(temp(data));				
			}
		})
	}

</script>
</html>
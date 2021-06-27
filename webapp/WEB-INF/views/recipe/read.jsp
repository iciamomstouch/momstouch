<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
	<title>레시피게시판</title>
	<style>
		#listFile img{width:150px; margin:0px 10px 10px 0px;}
		 input[type=text] {padding: 5px; margin: 0px;}
	</style>
</head>
<body>
	<h1>[레시피정보]</h1>
	<form name="frm" encType="multipart/form-data">
		<table border=1 width=500>
			<tr>
				<td>번호</td>
				<td><input type="text" name="recipe_bno" value="${vo.recipe_bno }" readOnly size=50 />
			</tr>
			<tr>
				<td>작성자</td>
				<td><input type="text" name="recipe_writer" value="${vo.recipe_writer }" readOnly size=50 />
			</tr>			
			<tr>
				<td>제목</td>
				<td><input type="text" name="recipe_title" value="${vo.recipe_title }" size=50 />
			</tr>
			<tr>
				<td>카테고리</td>
				<td><input type="text" name="recipe_category" value="${vo.recipe_category }" size=50 />
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
				<td><input type="text" name="recipe_content" value="${vo.recipe_content }" size=50/>
			</tr>
			<tr>
				<td>재료</td>
				<td><input type="text" name="recipe_ingre" value="${vo.recipe_ingre }" size=50/>
			</tr>
			<tr>
				<td>양념</td>
				<td><input type="text" name="recipe_seasoning" value="${vo.recipe_seasoning }" size=50/>
			</tr>			
			<tr>
				<td>조리순서</td>
				<td style="height:150px;padding:10px;">
					<input type="file" name="files" accept="image/*" multiple style="display:none;"/> 
					<div id="listFile"></div>
					<div id="attach">
					<table id="attachFiles"></table>
					<script id="temp" type="text/x-handlebars-template">
					{{#each list}}
					<tr>
						<td><img src="/displayFile?fullName={{recipe_bno}}/{{recipe_attach_image}}" width=100/></td>									
						<td><textarea rows="8" cols="35" >{{recipe_attach_text}}</textarea></td>					
					</tr>
					{{/each}}	
					</script>
				</div>					
				</td>
			</tr>
		</table>
		<input type="button" value="게시글수정" onClick="location.href='update?recipe_bno=${vo.recipe_bno}'"/>		
		<input type="button" value="게시글삭제" id="btnDelete"/>
		<input type="button" value="목록이동" onClick="location.href='list'"/>
	</form>
	 <hr/>
   <jsp:include page="reply.jsp"></jsp:include>
</body>
<script type="text/javascript">
	
	//이미지 여러개 첨부
	$("#btnImage").on("click", function(){
		$(frm.files).click();
	})
	
	$(frm.files).on("change", function(){
		var files=$(frm.files)[0].files;//파일을 여러개 선택할경우		
		$.each(files, function(index, file){
			var str = "<img src='" + URL.createObjectURL(file) + "'/>";
			$("#listFile").append(str);
		});
	});
	
	//상품삭제
	$("#btnDelete").on("click", function(){		
		if(!confirm("상품을 삭제하실래요?")) return;
		frm.action="delete";
		frm.method="get";
		frm.submit();
		
	})
	
	//상품수정
	$(frm).on("submit", function(e){
		e.preventDefault();
		var pname=$(frm.pname).val();
		if(pname==""){
			alert("상품명을 입력하세요!");
			return;
		}
		if(!confirm("상품정보를 수정하실래요?")) return;
		frm.action="update";
		frm.method="post";
		frm.submit();
	})

	$("#image").on("click", function(){
		$(frm.file).click();
	});
	
	//이미지 미리보기
	$(frm.file).on("change", function(){
		var file=$(frm.file)[0].files[0];//파일을 한개만 선택할경우
		$("#image").attr("src", URL.createObjectURL(file));
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
	
	//파일 삭제
	$("#attachFiles").on("click", "ol .del", function(){
		var ol = $(this).parent();
		var image = $(this).attr("fullName");
		if(!confirm(image + "파일을 삭제하실래요?")) return;
		$.ajax({
			type:"get",
			url:"/deleteFile",
			data:{"fullName":image, "recipe_bno":recipe_bno},
			success:function(){
				alert("삭제완료");
				li.remove();
			}
		})		
	});
	
	/*첨부 파일들을 선택한경우
	   $(frm.files).on("change", function(){
	      var files=$(frm.files)[0].files;
	      $.each(files, function(index, file){
	         uploadFile(file);
	      });
	   });*/
	   
	/*첨부이미지 업로드
	function uploadFile(file){
      if(file == null) return;
      var formData=new FormData();
      formData.append("file", file);
      formData.append("pcode", pcode);
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
   }*/
   
   /*
   $("#btnImage").on("click", function(){
      $(frm.files).click();
   });*/
</script>
</html>
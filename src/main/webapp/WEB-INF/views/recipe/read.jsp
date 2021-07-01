<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
	<link rel="stylesheet" href="/resources/css/recipe/read.css"/>
	<title>레시피게시판</title>
	<style>
		#listFile img{width:200px; margin:0px 10px 10px 0px;}
		 input[type=text] {padding: 5px; margin: 0px;}
	</style>
</head>
<body>
	<form name="frm" encType="multipart/form-data">
		<input type="hidden" name="recipe_bno" value="${vo.recipe_bno }" readOnly size=50 />
		<table style="width:600px; margin: 0px auto;">
			<tr>
				<td colspan="2" id="rwriter">${vo.recipe_writer }</td>
			</tr>
			<tr>
				<td colspan="2" id="rimg">
					<c:if test="${vo.recipe_image==null }">
						<img src="http://placehold.it/600x400" width=600 id="image"/>
					</c:if>
					<c:if test="${vo.recipe_image!=null }">
						<img src="/displayFile?fullName=${vo.recipe_image }" width=600 id="image"/>
					</c:if>
					<input type="file" name="file" style="display:none;"/>
				</td>
			</tr>			
			<tr>
				<td  colspan="2" id="rcate">${vo.recipe_category }</td>
			</tr>
			<tr>	
				<td  colspan="2" id="rtitle">${vo.recipe_title }</td>
			</tr>			
			<tr>
				<td colspan="2" id="rcont1">${vo.recipe_content }</td>
			</tr>
			<tr>
				<td colspan="2" id="rcont2">${vo.recipe_ingre }</td>
			</tr>
			<tr>
				<td colspan="2" id="rcont3">${vo.recipe_seasoning }</td>
			</tr>			
			<tr>
				<td colspan="2" id="rno">조리순서</td>
			</tr>
			<tr>
				<td style="height:150px;padding:10px;">
					<input type="file" name="files" accept="image/*" multiple style="display:none;"/> 
					<div id="listFile"></div>
					<div id="attach">
					<table id="attachFiles" style="margin:0 auto;"></table>
					<script id="temp" type="text/x-handlebars-template">
					{{#each list}}
					<tr>
						<td colspan="2" ><img src="/displayFile?fullName={{recipe_bno}}/{{recipe_attach_image}}" width=200/></td>
					</tr>
					<tr>									
						<td colspan="2"><textarea rows="8" cols="50" >{{recipe_attach_text}}</textarea></td>					
					</tr>
					{{/each}}	
					</script>
				</div>					
				</td>
			</tr>
		</table>
		<input type="button" value="게시글수정" onClick="location.href='update?recipe_bno=${vo.recipe_bno}'" id="btnUpdate"/>		
		<input type="button" value="게시글삭제" id="btnDelete"/>
		<input type="button" value="목록이동" onClick="location.href='list'" id="btnList"/>
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
	
	//즐겨찾기 추가 삭제
	$(".heart").on("click", function(){
		var recipe_bno = "${vo.recipe_bno}";
		var user_id = "${user_id}";
		
		if(user_id==null || user_id==""){
			alert("로그인이 필요한 기능입니다.")
		}else{
			alert(recipe_bno + user_id);
			$.ajax({
				type:"get",
				url:"keepRead.json",			
				data:{"recipe_bno":recipe_bno, "user_id":user_id},			
				success:function(result){				
					var strUid=result.user_id;
					var keep=result.recipe_keep;
					alert(strUid + keep);
					if(strUid == user_id){
						if(keep == 0){						
							$.ajax({
								type:"post",
								url:"keepUpdate",
								data:{"recipe_bno":recipe_bno, "user_id":user_id, "recipe_keep":1},
								success:function(){
									alert("즐겨찾기 추가!");									
								}
							});
						}else{
							$.ajax({
								type:"post",
								url:"keepUpdate",
								data:{"recipe_bno":recipe_bno, "user_id":user_id, "recipe_keep":0},
								success:function(){
									alert("즐겨찾기 삭제!");									
								}
							});
						}					
					}else{					
						$.ajax({
							type:"post",
							url:"keepInsert",
							data:{"recipe_bno":recipe_bno, "user_id":user_id, "recipe_keep":1},
							success:function(){
								alert("즐겨찾기 추가!");								
							}
						});
					}
				}
			});
		}
	})
	
</script>
</html>
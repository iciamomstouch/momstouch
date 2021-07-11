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
		<input type="hidden" name="recipe_writer" value="${vo.recipe_writer}" readOnly size=50 />
		<table style="width:600px; margin: 0px auto;">
			<tr>
				<td colspan="2" id="rwriter">${vo.user_nick}</td>
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
				<td id="rcate">${vo.recipe_category }</td>
				<td id="bheart">
					<c:if test="${keep.recipe_keep==1 }">
						<img src="/resources/css/heart-fill.svg" class="heart">
					</c:if>
					<c:if test="${keep.recipe_keep!=1 }">
						<img src="/resources/css/heart.svg" class="heart">
					</c:if>					
				</td>
			</tr>
			<tr>	
				<td  colspan="2" id="rtitle">${vo.recipe_title }</td>
			</tr>			
			<tr>
				<td colspan="2" id="rcont1"><div id=cont1 width=100>내용</div>${vo.recipe_content }</td>
			</tr>
			<tr>
				<td colspan="2" id="rcont2"><div id=cont2 width=100>재료</div>${vo.recipe_ingre }</td>
			</tr>
			<tr>
				<td colspan="2" id="rcont3"><div id=cont3 width=100>양념장</div>${vo.recipe_seasoning }</td>
			</tr>			
			<tr>
				<td colspan="2" id="rno">조리순서</td>
			</tr>
			<tr>
				<td style="height:150px;padding:10px;">
					<input type="file" name="files" accept="image/*" multiple style="display:none;"/> 
					<div id="listFile"></div>
					<div id="attach">
					<table id="attachFiles" style="margin:0 auto; padding-top:30px;"></table>
					<script id="temp" type="text/x-handlebars-template">
					{{#each list}}
					<tr>
						<td colspan="2"><textarea style="border: none; font-size:20px;" rows="5" cols="40" >{{recipe_attach_text}}</textarea></td>
						<td colspan="2" ><img src="/displayFile?fullName={{recipe_bno}}/{{recipe_attach_image}}" width=200/></td>	
					</tr>
					{{/each}}	
					</script>
				</div>					
				</td>
			</tr>
		</table>
		<c:if test="${user_type == 'admin' || user_id == vo.recipe_writer}">
			<input type="button" value="게시글수정" onClick="location.href='update?recipe_bno=${vo.recipe_bno}'" id="btnUpdate" class="btn"/>		
			<input type="button" value="게시글삭제" id="btnDelete" class="btn"/>
		</c:if>
		<input type="button" value="목록이동" onClick="location.href='list'" id="btnList" class="btn"/>
		<input type="button" value="이전" onClick="location.href='read?recipe_bno=${pre}'" class="btn" id="pre"/>
		<input type="button" value="다음" onClick="location.href='read?recipe_bno=${next}'" class="btn" id="next"/>
	</form>
	 <hr/>
   <jsp:include page="reply.jsp"></jsp:include>
</body>
<script type="text/javascript">

	//이전 다음 버튼 비활성화	
	var max="${max}";
	var min="${min}";
	var num="${vo.recipe_bno}";
	
	if(min==num){
		$("#pre").attr("disabled", true);
	}
	if(max==num){
		$("#next").attr("disabled", true);
	}
	
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
			$.ajax({
				type:"get",
				url:"keepRead.json",			
				data:{"recipe_bno":recipe_bno, "user_id":user_id},			
				success:function(result){				
					var strUid=result.user_id;
					var keep=result.recipe_keep;
					
					if(strUid == user_id){
						if(keep == 0){						
							$.ajax({
								type:"post",
								url:"keepUpdate",
								data:{"recipe_bno":recipe_bno, "user_id":user_id, "recipe_keep":1},
								success:function(){
									alert("즐겨찾기 추가!");
									location.reload();
								}
							});
						}else{
							$.ajax({
								type:"post",
								url:"keepUpdate",
								data:{"recipe_bno":recipe_bno, "user_id":user_id, "recipe_keep":0},
								success:function(){
									alert("즐겨찾기 삭제!");
									location.reload();
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
								location.reload();
							}
						});
					}
				}
			});
		}
	})
	
</script>
</html>

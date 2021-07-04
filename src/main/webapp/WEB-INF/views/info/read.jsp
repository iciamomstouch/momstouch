<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" href="/resources/css/info/read.css"/>
	<title>정보방</title>
	
</head>
<body>
	<form name="frm" encType="multipart/form-data">
		<input type="hidden" name="info_bno" value="${vo.info_bno}"/>
		<table id="tbl" style="width:600px; margin: 0px auto;">
			<tr>
				<td colspan="2" id="iwriter">${vo.info_writer}</td>
			</tr>
			<tr>
				<td id="idate"><fmt:formatDate pattern="MM-dd HH:mm:ss" value="${vo.info_regdate }" /></td>
			</tr>
			<tr>
				<td colspan="2" id="iimg">
					<c:if test="${vo.info_image==null }">
						<img src="http://placehold.it/600x600" width=600 id="image"/>
					</c:if>
					<c:if test="${vo.info_image!=null }">
						<img src="/displayFile?fullName=${vo.info_image }" width=600 id="image"/>
					</c:if>
					<input type="file" name="file" style="display:none;"/>
				</td>
			</tr>
			<tr>
				<td colspan="2" id="iheart">
					<c:if test="${keep.info_keep==1 }">
						<img src="/resources/css/heart-fill.svg" class="heart">
					</c:if>
					<c:if test="${keep.info_keep!=1 }">
						<img src="/resources/css/heart.svg" class="heart">
					</c:if>	
				</td>
			</tr>
			<tr>
				<td colspan="2" id="ivcnt">조회수: ${vo.info_viewcnt}</td>
			</tr>			
			<tr>
				<td colspan=2 id="ititle">${vo.info_title}</td>
			</tr>	
			<tr>
				<td colspan=2 id="icont">${vo.info_content}</td>
			</tr>		
		</table>
		<input type="button" value="수정" id="btnUpdate" class="btn" onClick="location.href='update?info_bno=${vo.info_bno}'"/>
		<input type="button" value="삭제" id="btnDelete" class="btn"/>
		<input type="button" value="목록" onClick="location.href='list'" id="btnList" class="btn"/>
		<input type="button" value="이전" onClick="location.href='read?info_bno=${pre}'" class="btn" id="pre"/>
		<input type="button" value="다음" onClick="location.href='read?info_bno=${next}'" class="btn" id="next"/>
	</form>
	<hr/>
	<jsp:include page="reply.jsp"></jsp:include>
</body>
<script>

	//이전 다음 버튼 비활성화	
	var max="${max}";
	var min="${min}";
	var num="${vo.info_bno}";
	
	if(min==num){
		$("#pre").attr("disabled", true);
	}
	if(max==num){
		$("#next").attr("disabled", true);
	}

	//게시글 삭제
	$("#btnDelete").on("click", function(){
		if(!confirm("삭제하실래요?")) return;
		frm.action="delete";
		frm.method="get";
		frm.submit();
	});

	$("#image").on("click", function() {
		$(frm.file).click();
	});

	//이미지 미리보기
	$(frm.file).on("change", function() {
		var file = $(frm.file)[0].files[0];
		$("#image").attr("src", URL.createObjectURL(file));
	});
	
	//즐겨찾기 추가 삭제
	$(".heart").on("click", function(){
		var info_bno = "${vo.info_bno}";
		var user_id = "${user_id}";
		
		if(user_id==null || user_id==""){
			alert("로그인이 필요한 기능입니다.")
		}else{
			alert(info_bno + user_id);
			$.ajax({
				type:"get",
				url:"keepRead.json",			
				data:{"info_bno":info_bno, "user_id":user_id},			
				success:function(result){				
					var strUid=result.user_id;
					var keep=result.info_keep;
					alert(strUid + keep);
					if(strUid == user_id){
						if(keep == 0){						
							$.ajax({
								type:"post",
								url:"keepUpdate",
								data:{"info_bno":info_bno, "user_id":user_id, "info_keep":1},
								success:function(){
									alert("즐겨찾기 추가!");
									location.reload();
								}
							});
						}else{
							$.ajax({
								type:"post",
								url:"keepUpdate",
								data:{"info_bno":info_bno, "user_id":user_id, "info_keep":0},
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
							data:{"info_bno":info_bno, "user_id":user_id, "info_keep":1},
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

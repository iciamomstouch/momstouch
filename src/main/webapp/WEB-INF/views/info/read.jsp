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
		<table width=800>
			<tr>
				<td colspan="2" id="iwriter">${vo.info_writer}</td>
			</tr>
			<tr>
				<td id="idate"><fmt:formatDate pattern="MM-dd HH:mm:ss" value="${vo.info_regdate }" /></td>
			</tr>
			<tr>
				<td colspan="2" id="iimg">
					<c:if test="${vo.info_image==null }">
						<img src="http://placehold.it/800x800" width=800 id="image"/>
					</c:if>
					<c:if test="${vo.info_image!=null }">
						<img src="/displayFile?fullName=${vo.info_image }" width=800 id="image"/>
					</c:if>
					<input type="file" name="file" style="display:none;"/>
				</td>
			</tr>
			<tr>
				<td colspan="2" id="iheart">
					<img src="/resources/css/heart.svg" class="heart">
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
		<input type="button" value="수정" id="btnUpdate" onClick="location.href='update?info_bno=${vo.info_bno}'"/>
		<input type="button" value="삭제" id="btnDelete"/>
		<input type="button" value="목록" onClick="location.href='list'" id="btnList"/>
	</form>
	<hr/>
	<jsp:include page="reply.jsp"></jsp:include>
</body>
<script>
	//게시글 삭제
	$("#btnDelete").on("click", function(){
		if(!confirm("삭제하실래요?")) return;
		frm.action="delete";
		frm.method="get";
		frm.submit();
	});	

	//이미지 미리보기
	$(frm.file).on("change", function() {
		var file = $(frm.file)[0].files[0];
		$("#image").attr("src", URL.createObjectURL(file));
	});

</script>
</html>
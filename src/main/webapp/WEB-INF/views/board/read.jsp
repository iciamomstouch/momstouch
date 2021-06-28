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
	<link rel="stylesheet" href="/resources/css/board/read.css"/>
	<title>오늘</title>
	
</head>
<body>
	<form name="frm" encType="multipart/form-data">
		<input type="hidden" name="board_bno" value="${vo.board_bno}"/>
		<table class="tbl" style="width:750px; text-align:center; margin-bottom:10px;">
			<tr>
				<td colspan="2" id="bwriter">${vo.board_writer}</td>
			</tr>
			<tr>
				<td id="bcate">${vo.board_category}</td>
				<td id="bdate"><fmt:formatDate pattern="MM-dd HH:mm:ss" value="${vo.board_regdate}" /></td>
			</tr>
			<tr>
				<td colspan="2" id="bimg">
					<c:if test="${vo.board_image==null }">
						<img src="http://placehold.it/800x800" width=800 id="image"/>
					</c:if>
					<c:if test="${vo.board_image!=null }">
						<img src="/displayFile?fullName=${vo.board_image }" width=800 id="image"/>
					</c:if>
					<input type="file" name="file" style="display:none;"/>
				</td>
			</tr>
			<tr>
				<td colspan="2" id="bheart">
					<img src="/resources/css/heart.svg" class="heart">
				</td>
			</tr>
			<tr>
				<td colspan="2" id="bvcnt">조회수: ${vo.board_viewcnt}</td>
			</tr>			
			<tr>
				<td colspan=2 id="btitle">${vo.board_title}</td>
			</tr>
			
			<tr>
				<td colspan=2 id="bcont">${vo.board_content}</td>
			</tr>		
		</table>
		<input type="submit" value="수정" id="btnUpdate"/>
		<input type="button" value="삭제" id="btnDelete"/>
		<input type="button" value="목록" onClick="location.href='list'" id="btnList"/>
	</form>
	<hr/>
	<jsp:include page="reply.jsp"></jsp:include>
</body>
<script>
	//글쓰기 삭제
	$("#btnDelete").on("click", function(){
		if(!confirm("삭제하실래요?")) return;
		frm.action="delete";
		frm.method="get";
		frm.submit();
	});

	//글쓰기 수정
	$(frm).on("submit", function(e){
			e.preventDefault();
			var board_title=$(frm.board_title).val();
			if(board_title==""){
				alert("제목을 입력하세요!");
				return;
			}
			if(!confirm("게시글을 수정하실래요?")) return;
			frm.action="update";
			frm.method="post";
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

</script>
</html>
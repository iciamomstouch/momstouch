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
	<title>게시판1</title>
	
</head>
<body>
	<h1>[글정보]</h1>
	<form name="frm" encType="multipart/form-data">
		<input type="hidden" name="board_bno" value="${vo.board_bno}"/>
		<table border=1 width=500>
			<tr>
				<td width=100>작성자</td>
				<td><input type="text" name="board_writer" value="${vo.board_writer}" readonly size=50/></td>
			</tr>
			<tr>
				<td>작성일</td>
				<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${vo.board_regdate }" /></td>
			</tr>
			<tr>
				<td>조회수</td>
				<td><input type="text" name="board_viewcnt" value="${vo.board_viewcnt}" size=50/></td>
			</tr>
			<tr>
				<td>정보</td>
				<td><input type="text" name="board_category" value="${vo.board_category}" size=50/></td>
			</tr>
			<tr>
				<td width=100>제목</td>
				<td><input type="text" name="board_title" value="${vo.board_title}" size=50/></td>
			</tr>
			<tr>
				<td>이미지</td>
				<td>
					<c:if test="${vo.board_image==null }">
						<img src="http://placehold.it/300x240" width=300 id="image"/>
					</c:if>
					<c:if test="${vo.board_image!=null }">
						<img src="/displayFile?fullName=${vo.board_image }" width=300 id="image"/>
					</c:if>
					<input type="file" name="file" style="display:none;"/>
				</td>
			</tr>
			<tr>
				<td colspan=2>
					<textarea rows="10" cols="80" name="board_content">${vo.board_content}</textarea>
				</td>
			</tr>		
		</table>
		<input type="submit" value="수정"/>
		<input type="button" value="삭제" id="btnDelete"/>
		<input type="button" value="목록" onClick="location.href='list'"/>
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
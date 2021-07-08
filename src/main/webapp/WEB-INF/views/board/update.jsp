<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" href="/resources/css/board/insert.css"/>
	<title>오늘</title>
</head>
<body>
	<form name="frm" encType="multipart/form-data">
		<input type="hidden" name="board_writer" value="${user_id}" />
		<input type="hidden" name="board_bno" value="${vo.board_bno}"/>
		<table class="tbl" style="width:800px; text-align:center; margin-bottom:10px;">			
			<tr>
				<td id="id">${user_id}</td>
			</tr>
			<tr>
				<td>
					<select name="board_category" id="option">
						<option value="정보" <c:out value="${vo.board_category=='정보'?'selected':''}"/>>정보</option>
						<option value="유머" <c:out value="${vo.board_category=='유머'?'selected':''}"/>>유머</option>
						<option value="이슈" <c:out value="${vo.board_category=='이슈'?'selected':''}"/>>이슈</option>
						<option value="계층" <c:out value="${vo.board_category=='계층'?'selected':''}"/>>계층</option>
						<option value="감동" <c:out value="${vo.board_category=='감동'?'selected':''}"/>>감동</option>
						<option value="기타" <c:out value="${vo.board_category=='기타'?'selected':''}"/>>기타</option>
					</select>
				</td>
				<td id="title"><input type="text" name="board_title" value="${vo.board_title}" size=60  placeholder="제목을 기재해주세요." style="font-size: 15px;background-color:transparent;border:0 solid black;text-align:left;"/></td>
			</tr>			
			<tr>
				<td colspan="2" id="bimg">
					<c:if test="${vo.board_image==null }">
						<img src="http://placehold.it/600x600" width=600 id="image"/>
					</c:if>
					<c:if test="${vo.board_image!=null }">
						<img src="/displayFile?fullName=${vo.board_image }" width=600 id="image"/>
					</c:if>
					<input type="file" name="file" style="display:none;"/>
				</td>
			</tr>			
			<tr>
				<td colspan=2 id="content">
					<textarea rows="10" cols="85" name="board_content" placeholder="내용을 기재해주세요." style="font-size: 15px;background-color:transparent;border:0 solid black;text-align:left;">${vo.board_content }</textarea>
				</td>
			</tr>			
		</table>
		<input type="submit" value="게시글수정" id="btnUpdate"/>
		<input type="reset" value="수정취소" id="btnReset"/>
		<input type="button" value="목록이동" onClick="location.href='list'" id="btnList"/>
	</form>
</body>
<script>
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
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" href="/resources/css/question/read.css"/>
	<title>질문게시판</title>
</head>
<body>
	<form name="frm" encType="multipart/form-data">
	 
	 <table class="tbl" style="width: 600px; margin:0px auto; margin-bottom:10px;">
		 <tr id="question_bno">
			 <td><input type="text" name="question_bno" size=50 value="${vo.question_bno}" readonly></td>
		 </tr>
		  <tr id="qtop">
			 <td width=150 id="qwriter">${vo.question_writer}</td>
			 <td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${vo.question_regdate}" /></td>
			 <td width=150>조회수:${vo.question_viewcnt}</td>
		 </tr>
		 <tr>
			 <td colspan="3" id="qtitle">${vo.question_title}</td>
		 </tr>
		 <tr>
			<td colspan="3" id="qimg">
				<c:if test="${vo.question_image==null }">
					<img src="http://placehold.it/300x240" width=300 id="image"/>
				</c:if>
				<c:if test="${vo.question_image!=null }">
					<img src="/displayFile?fullName=${vo.question_image }" width=300 id="image"/>
				</c:if>
				<input type="file" name="file" style="display:none;"/>
			</td>
		</tr>
		<tr>
			<td colspan="3" id="qcont">${vo.question_content}</td>
		</tr>		 		
	 </table>
	 <input type="button" value="수정" id="btnUpdate" onClick="location.href='update?question_bno=${vo.question_bno}'">	 
	 <input type="button" value="삭제" id="btnDelete">
	 <input type="button" value="답변" onClick="location.href='reply?question_bno=${vo.question_bno}'" id="btnReply">
	 <input type="button" value="목록" onClick="location.href='list'" id="btnList">
	 </form>
</body>
<script>
	//게시글 삭제
	$("#btnDelete").on("click", function(){
		if(!confirm("삭제하실래요?")) return;
		frm.action="delete";
		frm.method="post";
		frm.submit();
	});	
	
	//이미지 미리보기
	$(frm.file).on("change", function() {
		var file = $(frm.file)[0].files[0];
		$("#image").attr("src", URL.createObjectURL(file));
	});
</script>
</html>
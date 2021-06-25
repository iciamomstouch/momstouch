<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>질문게시판</title>
</head>
<body>
	<h2>[질문게시판 읽기]</h2>
	<form name="frm" encType="multipart/form-data">
	 <input type="text" name="question_grpno" value="${vo.question_grpno }"/>
	 <table class="tbl" border=1 width=600>
		 <tr>
			 <td width=100>번호</td>
			 <td><input type="text" name="question_bno" size=50 value="${vo.question_bno}" readonly></td>
		 </tr>
		  <tr>
			 <td width=100>작성자</td>
			 <td><input type="text" name="question_writer" value="${vo.question_writer}" readonly size=50></td>
		 </tr>
		 <tr>
			<td>작성일</td>
			<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${vo.question_regdate }" /></td>
		</tr>
		<tr>
			<td>조회수</td>
			<td><input type="text" name="question_viewcnt" value="${vo.question_viewcnt}" readonly size=50/></td>
		</tr>
		 <tr>
			 <td width=100>제목</td>
			 <td><input type="text" name="question_title" size=50 value="${vo.question_title}" size=50/></td>
		 </tr>
		 <tr>
			<td>이미지</td>
			<td>
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
			<td width=100>내용</td>
			<td><textarea rows="10" cols="50" name="question_content">${vo.question_content}</textarea></td>
		</tr>		 		
	 </table>
	 <input type="submit" value="수정">	 
	 <input type="button" value="삭제" id="btnDelete">
	 <input type="button" value="답변" onClick="location.href='reply?question_bno=${vo.question_bno}'">
	 <input type="button" value="목록" onClick="location.href='list'">
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
	
	//게시글 수정
	$(frm).on("submit", function(e){
		e.preventDefault();
		var info_title=$(frm.info_title).val();
		if(info_title==""){
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
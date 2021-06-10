<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>질문게시판 글쓰기</title>
</head>
<body>
	<h2>질문게시판 글쓰기</h2>
	<form name="frm">
	 <table class="tbl" border=1 width=500>
		 <tr>
			 <td width=100>번호</td>
			 <td><input type="text" name="question_bno" size=50 value="${vo.question_bno}" readonly></td>
		 </tr>
		 <tr>
			 <td width=100>제목</td>
			 <td><input type="text" name="question_title" size=50 value="${vo.question_title}" readonly></td>
		 </tr>
		 <tr>
			 <td width=100>내용</td>
			 <td><textarea rows="10" cols="52" name="question_content" readonly>${vo.question_content}</textarea></td>
		 </tr>
		 <tr>
			 <td>작성자</td>
			 <td><input type="text" name="question_writer" value="user00" readonly size=10></td>
		 </tr>
	 </table>
	 <input type="button" value="수정" onClick="location.href='update?question_bno=${vo.question_bno}'">
	 
	 <input type="button" value="삭제" onClick="funDelete();">
	 <input type="button" value="목록" onClick="location.href='list'">
	 </form>
</body>
<script>
 function funDelete(){
	 if(!confirm("삭제하시겠습니까?")) return;
	 frm.action="delete";
	 frm.method="post"
	 frm.submit();
 }
</script>
</html>
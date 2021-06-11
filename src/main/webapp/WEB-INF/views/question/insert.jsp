<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>질문게시판 글쓰기</title>
</head>
<body>
	<h2>질문게시판 글쓰기</h2>
	<form name="frm" action="insert" method="post">
	 <table class="tbl" border=1 width=500>
		 <tr>
			 <td width=100>제목</td>
			 <td><input type="text" name="question_title" size=50></td>
		 </tr>
		 <tr>
			 <td width=100>내용</td>
			 <td>
			 <textarea rows="10" cols="52" name="question_content"></textarea>
			 </td>
		 </tr>
		 <tr>
			 <td>작성자</td>
			 <td><input type="text" name="question_writer" value="user00" readonly size=10></td>
		 </tr>
	 </table>
	 <input type="submit" value="저장">
	 <input type="reset" value="취소">
	 <input type="button" value="목록" onClick="location.href='list'">
	 </form>
</body>

<script>
	$(frm).on("submit", function(e){
		e.preventDefault();
		if(!confirm("게시물을 등록하실래요?")) return;
		frm.submit();
	});
</script>
</html>
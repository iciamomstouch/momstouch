<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>질문게시판 수정</title>
</head>
<body>
 	<h2>질문게시판 수정</h2>
	 <form name="frm" action="update" method="post">
	 <table class="tbl" border=1 width=500>
		 <tr>
			 <td width=100>번호</td>
			 <td><input type="text" name="qbno" size=50 value="${vo.qbno}" readonly></td>
		 </tr>
		 <tr>
			 <td width=100>제목</td>
			 <td><input type="text" name="qtitle" size=50 value="${vo.qtitle}"></td>
		 </tr>
		 <tr>
			 <td width=100>내용</td>
			 <td><textarea rows="10" cols="52" name="qcontent">${vo.qcontent}</textarea></td>
		 </tr>
		 <tr>
			 <td>작성자</td>
			 <td><input type="text" name="qwriter" value="${vo.qwriter}" readonly size=10></td>
		 </tr>
	 </table>
	 <input type="submit" value="수정">
	 <input type="button" value="목록" onClick="location.href='list'">
	 </form>
</body>
<script>
 $(frm).submit(function(){
 	if(!confirm("수정하시겠습니까?")) return false;
 });
</script>
</html>
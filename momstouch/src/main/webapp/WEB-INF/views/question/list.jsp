<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
	<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>질문게시판</title>
</head>
<body>
	<h2>질문게시판</h2>
		<button onClick="location.href='question/insert'"  id="btnInsert">글쓰기</button>
		<table class="tbl" border=1 width=700>
			 <tr>
				 <td width=50>번호</td>
				 <td width=450>제목</td>
				 <td width=100>작성자</td>
				 <td width=100>작성일</td>
			 </tr>
			 <c:forEach items="${list}" var="vo">
			<tr>
				 <td><a href="read?qbno=${vo.qbno}">${vo.qbno}</a></td>
				 <td>${vo.qtitle}</td>
				 <td>${vo.qwriter}</td>
				 <td><fmt:formatDate value="${vo.qregdate}" pattern="yyyy-MM-dd"/></td>
				 <td>${vo.qviewcnt}</td>
			</tr>
			 </c:forEach>
		 </table>
</body>
<script>
	$(document).ready(function(){
		 var result="${result}";
		 if(result == "SUCCESS"){
		 	alert("처리가 완료 되었습니다.");
		 }
	});
	$("#btnInsert").click(function(){
		location.href="/question/insert";
	});
</script>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>중고거래 보기</title>
</head>
<body>
	<h1>중고거래 보기</h1>
	<form name="frm" enctype="multipart/form-data">
	<table border=1>
		<input type="text" name="trade_bno" value="${vo.trade_bno}" style="display:none"/>
		<tr>
			<td>${vo.trade_writer}</td>
			<td><fmt:formatDate value="${vo.trade_regdate}" pattern="yyyy-MM-dd kk:mm:ss"/></td>
			<td>조회수:</td>
		</tr>
		<tr>
			<td>${vo.trade_category}</td>
			<td colspan=2>${vo.trade_title}</td>
		</tr>
		<tr>
			<td colspan=3>
				<c:if test="${vo.trade_image==null}">
					<img src="http://placehold.it/100x80"/>
				</c:if>
				<c:if test="${vo.trade_image!=null}">
					<img src="/displayFile?fullName=${vo.trade_image}" width=100/>
				</c:if>	
			</td>
		</tr>
		<tr>
			<td colspan=3>${vo.trade_content}</td>
		<tr>
		<tr>
			<td>♡</td>
			<td>${vo.trade_price}</td>
			<td><button>채팅으로 거래하기</button></td>
		</tr>
	</table>
	<input type="submit" value="글수정"/>
	<input type="reset" value="수정취소"/>
	<input type="button" value="글삭제" id="btnDelete"/>
	<input type="button" value="목록이동" onClick="location.href='list'"/>
	</form>
</body>
<script>
	$("#btnDelete").on("click", function(){
		if(!confirm("삭제하실래요?")) return;
		frm.action="delete";
		frm.method="get";
		frm.submit();
	});
</script>
</html>
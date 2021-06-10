<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
	<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>글쓰기</title>
	
</head>
<body>
	<h1>[글정보]</h1>
	<form name="frm" action="update" method="post">
		<input type="hidden" name="board_bno" value="${vo.board_bno}"/>
		<table border=1 width=500>
			<tr>
				<td width=100>작성자</td>
				<td><input type="text" name="board_writer" value="${vo.board_writer}" readonly size=5/></td>
			</tr>
			<tr>
				<td>작성일</td>
				<td><input type="text" name="board_regdate" value="${vo.board_regdate}" size=50/></td>
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
				<td colspan=2>
					<textarea rows="10" cols="80" name="board_content">${vo.board_content}</textarea>
				</td>
			</tr>
			
		
		</table>
		<input type="submit" value="수정"/>
		<input type="button" value="삭제" id="btnDelete"/>
		<input type="button" value="목록" onClick="location.href='list'"/>
	</form>
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
		var board_bno=$(frm.board_bno).val();
		if(board_bno==""){
			alert("이름을 입력하세요!");
			return;
		}
		if(!confirm("주소를 수정하실래요?")) return;
		frm.action="update";
		frm.method="post";
		frm.submit();
})



</script>
</html>
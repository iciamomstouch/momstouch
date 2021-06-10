<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>글쓰기등록</title>
</head>
<body>
	<h1>[글쓰기등록]</h1>
	<form name="frm" action="insert" method="post">
		<table border=1 width=500>
			<tr>
				<td width=100>제목</td>
				<td><input type="text" name="board_title"  size=5/></td>
			</tr>
			<tr>
				<td width=100>카테고리</td>
				<td><input type="text" name="board_category"  size=5/></td>
			</tr>
			
			<tr>
				<td colspan=2>
					<textarea rows="10" cols="80" name="content"></textarea>
				</td>
			</tr>
			<tr>
				<td>이미지</td>
				<td>
					<img id="board_image" src="http://placehold.it/150x120" width=150/>
					<input type="file" name="file" style="display:none;"/>
				</td>
			</tr>
			<tr>
				<td width=100>작성자</td>
				<td><input type="text" name="board_writer"  size=5/></td>
			</tr>
			
		</table>
		<input type="submit" value="글쓰기등록" />
		<input type="reset" value="등록취소"/>
		<input type="button" value="목록이동" onClick="location.href='list'"/>
	</form>
</body>
<script>
$(frm).on("submit", function(e){
	e.preventDefault();
	
	var board_title=$(frm.board_title).val();
	if(board_title==""){
		alert("제목명을 입력하세요!");
		return;
	}
	
	if(!confirm("제목을 등록하실래요?")) return;
	frm.action="insert";
	frm.method="post";
	frm.submit();
	
});

</script>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>게시판2</title>
</head>
<body>
	<h1>[글쓰기등록]</h1>
	<form name="frm" encType="multipart/form-data">
		<table border=1 width=500>
			<tr>
				<td width=100>작성자</td>
				<td><input type="text" name="info_writer" size=50 value="${user_id }"/></td>
			</tr>
			<tr>
				<td width=100>제목</td>
				<td><input type="text" name="info_title" size=50/></td>
			</tr>						
			<tr>
				<td colspan=2>
					<textarea rows="10" cols="80" name="info_content"></textarea>
				</td>
			</tr>
			<tr>
				<td>이미지</td>
				<td>
					<img src="http://placehold.it/150x120" id="image" width=150/>
					<input type="file" name="file" style="display:none;"/>
				</td>
			</tr>			
			
		</table>
		<input type="submit" value="게시글등록" />
		<input type="reset" value="등록취소"/>
		<input type="button" value="목록이동" onClick="location.href='list'"/>
	</form>
</body>
<script>
$(frm).on("submit", function(e){
	e.preventDefault();
	
	var info_title=$(frm.info_title).val();
	if(info_title==""){
		alert("제목을 입력하세요!");
		return;
	}
	
	if(!confirm("게시글을 등록하실래요?")) return;
	frm.action="insert";
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
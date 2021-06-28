<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" href="/resources/css/board/insert.css"/>
	<title>오늘</title>
</head>
<body>
	<form name="frm" encType="multipart/form-data">
		<input type="hidden" name="board_writer" value="${user_id}" />
		<table class="tbl" style="width:800px; text-align:center; margin-bottom:10px;">			
			<tr>
				<td id="id">${user_id}</td>
			</tr>
			<tr>
				<td>
					<select name="board_category" id="option">
						<option value="정보">정보</option>
						<option value="유머">유머</option>
						<option value="이슈">이슈</option>
						<option value="계층">계층</option>
						<option value="감동">감동</option>
						<option value="기타">기타</option>
					</select>
				</td>
				<td id="title"><input type="text" name="board_title" size=60  placeholder="제목을 기재해주세요." style="font-size: 15px;background-color:transparent;border:0 solid black;text-align:left;"/></td>
			</tr>			
			<tr>
				<td colspan="2" id="img">
					<img src="http://placehold.it/800x600" id="image" width=800/>
					<input type="file" name="file" style="display:none;"/>
				</td>
			</tr>			
			<tr>
				<td colspan=2 id="content">
					<textarea rows="10" cols="85" name="board_content" placeholder="내용을 기재해주세요." style="font-size: 15px;background-color:transparent;border:0 solid black;text-align:left;"></textarea>
				</td>
			</tr>
						
			
		</table>
		<input type="submit" value="게시글등록" id="btnUpdate"/>
		<input type="reset" value="등록취소" id="btnReset"/>
		<input type="button" value="목록이동" onClick="location.href='list'" id="btnList"/>
	</form>
</body>
<script>
$(frm).on("submit", function(e){
	e.preventDefault();
	
	var board_title=$(frm.board_title).val();
	if(board_title==""){
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
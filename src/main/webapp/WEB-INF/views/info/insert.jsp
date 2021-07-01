<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" href="/resources/css/info/insert.css"/>
	<title>정보방</title>
</head>
<body>
	<form name="frm" encType="multipart/form-data">
		<input type="hidden" name="info_writer" value="${user_id}" />
		<table class="tbl" style="width:600px; margin: 0px auto; margin-bottom:10px;">			
			<tr>
				<td colspan=2 id="id">${user_id}</td>
			</tr>
			<tr>
				<td colspan=2 id="title"><input type="text" name="info_title" size=60  placeholder="제목을 기재해주세요." style="font-size: 15px;background-color:transparent;border:0 solid black;text-align:left;"/></td>
			</tr>
			<tr>
				<td colspan="2" id="img">
					<img src="http://placehold.it/600x600" id="image" width=600/>
					<input type="file" name="file" style="display:none;"/>
				</td>
			</tr>						
			<tr>
				<td colspan=2 id="content">
					<textarea rows="10" cols="60" name="info_content" placeholder="내용을 기재해주세요." style="font-size: 15px;background-color:transparent;border:0 solid black;text-align:left;"></textarea>
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
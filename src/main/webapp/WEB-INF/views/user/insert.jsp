<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
	<title>회원관리</title>
</head>
<body>
	<h1>[회원등록]</h1>
	<form name="frm" encType="multipart/form-data">		
		<table border=1>
			<tr>
				<td width=100>아이디</td>
				<td width=300><input type="text" name="user_id" size=30 value="user06"/></td>
			</tr>			
			<tr>
				<td width=100>닉네임</td>
				<td width=300><input type="text" name="user_nick" size=30 /></td>
			</tr>
			<tr>
				<td width=100>이메일</td>
				<td width=300><input type="text" name="user_email" size=30 /></td>
			</tr>
			<tr>
				<td width=100>이름</td>
				<td width=300><input type="text" name="user_name" size=30 /></td>
			</tr>
			<tr>
				<td width=100>전화번호</td>
				<td width=300><input type="text" name="user_tel" size=30 /></td>
			</tr>
			<tr>
				<td width=100>주소</td>
				<td width=300><input type="text" name="user_address" size=30 /></td>
			</tr>
			<tr>
				<td width=100>이미지</td>
				<td width=300>
					<img src="http://placehold.it/150x120" width=150 id="image"/>
					<input type="file" name="file" style="display:none;"/>
				</td>
			</tr>
		</table>
		<input type="submit" value="회원등록"/>
		<input type="reset" value="등록취소"/>		
		<input type="button" value="목록이동" onClick="location.href='list'"/>
	</form>
</body>
<script>
	//회원등록
	$(frm).on("submit", function(e){
		e.preventDefault();
		var name=$(frm.user_name).val();
		if(name==""){
			alert("이름을 입력하세요!");
			return;
		}
		if(!confirm("회원을    등록하실래요?")) return;
		frm.action="insert";
		frm.method="post";
		frm.submit();
	})
	$("#image").on("click", function(){
		$(frm.file).click();
	});
	//이미지 미리보기
	$(frm.file).on("change", function(){
		var file=$(frm.file)[0].files[0];
		$("#image").attr("src", URL.createObjectURL(file));
	});
</script>
</html>
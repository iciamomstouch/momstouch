<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<link rel="stylesheet" href="/resources/css/user/insert.css"/>
	<title>회원관리</title>
</head>
<body>
	<form name="frm" encType="multipart/form-data">		
		<table id="tbl" style="width:600px; margin: 0px auto; margin-bottom:30px;">
			<tr>
				<th width=100>아이디</th>
				<td width=300><input type="text" name="user_id" value="${vo.user_id }" size=30 placeholder="아이디를 기재해주세요." style="font-size: 15px;background-color:transparent;border:0 solid black;text-align:left;" readonly/></td>
			</tr>						
			<tr>
				<th width=100>닉네임</th>
				<td width=300><input type="text" name="user_nick" value="${vo.user_nick }" size=30 placeholder="닉네임을 기재해주세요." style="font-size: 15px;background-color:transparent;border:0 solid black;text-align:left;"/></td>
			</tr>
			<tr>
				<th width=100>이메일</th>
				<td width=300><input type="text" name="user_email" value="${vo.user_email }" size=30 placeholder="이메일을 기재해주세요." style="font-size: 15px;background-color:transparent;border:0 solid black;text-align:left;"/></td>
			</tr>
			<tr>
				<th width=100>이름</th>
				<td width=300><input type="text" name="user_name" value="${vo.user_name }" size=30 placeholder="이름을 기재해주세요." style="font-size: 15px;background-color:transparent;border:0 solid black;text-align:left;"/></td>
			</tr>
			<tr>
				<th width=100>전화번호</th>
				<td width=300><input type="text" name="user_tel" value="${vo.user_tel }" size=30 placeholder="전화번호를 기재해주세요." style="font-size: 15px;background-color:transparent;border:0 solid black;text-align:left;"/></td>
			</tr>
			<tr>
				<th width=100 rowspan=2 class="title">주소</th>
				<td>
					<input type="text" id="address1" size=30 readonly placeholder="주소를 기재해주세요." style="font-size: 15px;background-color:transparent;border:0 solid black;text-align:left;">
					<input type="button" value="검색" id="btnSearch">
				</td>
			</tr>
			<tr>
				<td width=400>
					<input type="text" name="user_address" value="${vo.user_address }" size=50 placeholder="나머지 상세 주소를 기재해주세요." style="font-size: 15px;background-color:transparent;border:0 solid black;text-align:left;">
				</td>
			</tr>
			<tr>
				<th width=100>이미지</th>
				<td width=300>
					<c:if test="${vo.user_image==null }">
						<img src="http://placehold.it/150x120" width=150 id="image"/>
					</c:if>
					<c:if test="${vo.user_image!=null }">
						<img src="/displayFile?fullName=${vo.user_image }" width=150 id="image"/>
					</c:if>
					<input type="file" name="file" style="display:none;"/>
				</td>
			</tr>
		</table>
		<input type="submit" value="정보수정" id="btnInsert"/>
		<input type="reset" value="수정취소" id="btnReset"/>			
		<input type="button" value="목록이동" onClick="location.href='list'" id="btnList"/>
		<input type="button" value="회원탈퇴" id="btnDel"/>	
	</form>
</body>
<script>
	//주소검색
	$("#btnSearch").click(function() {
		new daum.Postcode({
			oncomplete : function(data) {
				console.log(data)
				$("#address1").val(data.address);
				$(frm.user_address).val(data.address);
			}
		}).open();
	});
	$("#address1").click(function() {
		$("#btnSearch").click();
	})
	
	//회원정보삭제
	$("#btnDel").on("click", function(){
		if(!confirm("회원탈퇴 하실래요?")) return;
		frm.action="delete";
		frm.method="get";
		frm.submit();
	});
	
	//주소수정
	$(frm).on("submit", function(e){
		e.preventDefault();
		var name=$(frm.user_name).val();
		if(name==""){
			alert("이름을 입력하세요!");
			return;
		}
		if(!confirm("회원정보를 수정하실래요?")) return;
		frm.action="update";
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
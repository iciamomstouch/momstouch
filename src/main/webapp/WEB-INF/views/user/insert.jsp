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
				<td width=300>
					<input type="text" id="user_id" name="user_id" size=30 placeholder="아이디를 기재해주세요." style="font-size: 15px;background-color:transparent;border:0 solid black;text-align:left;"/>
					<button type="button" class="idChk">아이디 확인</button>
					<p class="result">
						<span class="msg">아이디를 확인해주세요.</span>
					</p>
				</td>
			</tr>
			<tr>
				<th width=100>비밀번호</th>
				<td width=300><input id="user_pass" type="password" name="user_pass" size=30 placeholder="비밀번호를 기재해주세요." style="font-size: 15px;background-color:transparent;border:0 solid black;text-align:left;"/></td>
			</tr>			
			<tr>
				<th width=100>닉네임</th>
				<td width=300><input id="user_nick" type="text" name="user_nick" size=30 placeholder="닉네임을 기재해주세요." style="font-size: 15px;background-color:transparent;border:0 solid black;text-align:left;"/></td>
			</tr>
			<tr>
				<th width=100>이메일</th>
				<td width=300><input id="user_email" type="text" name="user_email" size=30 placeholder="이메일을 기재해주세요." style="font-size: 15px;background-color:transparent;border:0 solid black;text-align:left;"/></td>
			</tr>
			<tr>
				<th width=100>이름</th>
				<td width=300><input id="user_name" type="text" name="user_name" size=30 placeholder="이름을 기재해주세요." style="font-size: 15px;background-color:transparent;border:0 solid black;text-align:left;"/></td>
			</tr>
			<tr>
				<th width=100>전화번호</th>
				<td width=300><input id="user_tel" type="text" name="user_tel" size=30 placeholder="전화번호를 기재해주세요." style="font-size: 15px;background-color:transparent;border:0 solid black;text-align:left;"/></td>
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
					<input type="text" name="user_address" size=50 placeholder="나머지 상세 주소를 기재해주세요." style="font-size: 15px;background-color:transparent;border:0 solid black;text-align:left;">
				</td>
			</tr>
			<tr>
				<th width=100>이미지</th>
				<td width=300>
					<img src="http://placehold.it/150x120" width=150 id="image"/>
					<input type="file" name="file" style="display:none;"/>
				</td>
			</tr>
		</table>
		<input type="submit" value="회원등록" id="btnInsert"/>
		<input type="reset" value="등록취소" id="btnReset"/>		
		<input type="button" value="목록이동" onClick="location.href='list'" id="btnList"/>
	</form>
</body>
<script>
	$(".idChk").click(function(){	

	var user_id = $("#user_id").val();
		$.ajax({
	  		url : "idChk",
	  		type : "get",
	  		datatype:"json",
	  		data : {"user_id":user_id},
	  		success : function(data) {
	  			alert(data);
		  		if(data == 1) {		  			
		    		$(".result .msg").text("사용 불가");
		    		$(".result .msg").attr("style", "color:#f00");    
		   		}else{
			   		$(".result .msg").text("사용 가능");
			   	    $(".result .msg").attr("style", "color:#00f");
		   		}
		  	}
		});  // ajax 끝
	});

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
	
	//회원등록
	$(frm).on("submit", function(e) {
	e.preventDefault();
		var user_id = document.getElementById("user_id");
		var user_pass = document.getElementById("user_pass");
		var user_nick = document.getElementById("user_nick");
		var user_email = document.getElementById("user_email");
		var user_naem = document.getElementById("user_name");
		var user_tel = document.getElementById("user_tel");
		if (user_id.value == "") { //해당 입력값이 없을 경우 같은말: if(!uid.value)
			alert("아이디를 입력하세요.");
		    user_id.focus(); //focus(): 커서가 깜빡이는 현상, blur(): 커서가 사라지는 현상
		    return false; //return: 반환하다 return false:  아무것도 반환하지 말아라 아래 코드부터 아무것도 진행하지 말것
		};

  	    if (user_pass.value == "") {
	        alert("비밀번호를 입력하세요.");
	        user_pass.focus();
	        return false;
	   	};
	
	  	//비밀번호 영문자+숫자+특수조합(8~25자리 입력) 정규식
	    var pwdCheck = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,25}$/;
	
	    if (!pwdCheck.test(user_pass.value)) {
	      alert("비밀번호는 영문자+숫자+특수문자 조합으로 8~25자리 사용해야 합니다.");
	      user_pass.focus();
	      return false;
	    };
	    
	    if (user_nick.value == "") {
		       alert("닉네임을 입력하세요.");
		       user_nick.focus();
		       return false;
		   };
	    
	   	var re2 = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
		   
	   	if (user_email.value == "") {
			alert("이메일 주소를 입력하세요.");
		    user_email.focus();
		    return false;
		}
		   

	   if (!re2.test(user_email.value)) {
	    	alert("적합하지 않은 이메일 형식입니다.");
	     	user_email.focus();
	     	return false;
	   }
	    
	   if (user_name.value == "") {
	       alert("이름을 입력하세요.");
	       user_name.focus();
	       return false;
	   };
	   
	   var re = /^[0-9]+/g; //숫자만 입력하는 정규식

	   if (!re.test(user_tel.value)) {
	     alert("전화번호는 숫자만 입력할 수 있습니다.");
	     user_tel.focus();
	     return false;
	   }
	   
		if (!confirm("회원을  등록하실래요?"))
			return;
		frm.action = "insert";
		frm.method = "post";
		frm.submit();
		alert("회원가입 되었습니다.")
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
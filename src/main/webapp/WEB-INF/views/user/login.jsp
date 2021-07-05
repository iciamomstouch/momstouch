<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	
<!-- 로그인 form------------------------------ -->
<head>
	<link rel="stylesheet" href="/resources/css/user/login.css"/>
</head>
<div class="panel panel-primary" style="width:400px;margin:0px auto;">
    <div class="panel-heading"><h2 class="panel-title">LOG IN</h2></div>
    <div class="panel-body">
        <form id="login-form" name="frm">
            <div style="margin-bottom:10px;">
                <input type="text" name="user_id" class="form-control" placeholder="아이디 입력" value="user06"/>
            </div>
            <div style="margin-bottom:10px;">
                <input type="password" name="user_pass" class="form-control" placeholder="비밀번호 입력" value="pass"/>
            </div>
            <div style="margin-bottom:10px;">
            	<span><input type="checkbox" name="chkLogin"/>로그인 상태유지</span>
            	<span><a href="insert"> [회원가입] </a></span>
            </div>
            <div style="margin-bottom:10px;">
                <button type="submit" class="form-control btn btn-primary">로그인</button>
             </div>
        </form>
    </div>
</div>   

<script>
	$(frm).on("submit", function(e){
		var user_id=$(frm.user_id).val();
		var user_pass=$(frm.user_pass).val();
		var chkLogin = $(frm.chkLogin).is(":checked")?"true":"false";				
		//alert(chkLogin);
		e.preventDefault();
		if(user_id==""||user_pass==""){
			alert("아이디와 비밀번호를 입력하세요!")
			return;
		}
		
		$.ajax({
			type:"post",
			url:"login",
			data:{"user_id":user_id, "chkLogin":chkLogin, "user_pass":user_pass},
			success:function(data){								
				if(data.result==0){
					alert("아이디가 존재하지 않습니다!");
				}else if(data.result==1){					
					alert(data.path);
					location.href="" + data.path;
				}else{
					alert("비밀번호가 일치하지 않습니다!");
				}
			}
		})
	})
</script>
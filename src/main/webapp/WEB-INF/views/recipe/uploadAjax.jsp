<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>파일업로드 Ajax</title>
</head>
<body>
	<h1>파일업로드 Ajax</h1>
	<div id="upload">
		<input type="file" id="file" accept="image/*">
	</div>
	<div id="uploaded">
		<ul id="uploadFiles"></ul>
	</div>
</body>
<script>
	$("#file").on("change", function(){
		var file=$("#file")[0].files[0];
		if(file == null) return;
		var formData=new FormData();
		formData.append("file", file);
		
		$.ajax({
			type:"post",
			url:"uploadFile",
			processData:false,
			contentType:false,
			data:formData,
			success:function(data){
				var str ="<li fullName=" + data + ">"; 
				    str+="<img src='/displayFile?fullName=" + data + "' width=100>";
				    str+="<br/><a href='/downloadFile?fullName="+data+"'>" + data + "</a>"
				    str+="<button>삭제</button>";
				    str+="</li>"
				$("#uploadFiles").append(str);
			}
		});
	});
	
	$("#uploadFiles").on("click", "li button", function(){
		var li=$(this).parent();
		var fullName=li.attr("fullName");
		if(!confirm(fullName + " 파일을 삭제하실래요?")) return;
		$.ajax({
			type:"get",
			url:"/deleteFile",
			data:{"fullName":fullName},
			success:function(){
				alert("삭제완료!");
				li.remove();
			}
		});
	});
</script>
</html>
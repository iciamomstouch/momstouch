<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>중고거래 보기</title>
	<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
	<!--<link rel="stylesheet" href="/resources/css/trade/style.css"/>-->
	<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.css" />
	<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css" />
	<script src="https://unpkg.com/swiper/swiper-bundle.js"></script>
	<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
	<style>
		.swiper-container {
			width: 600px;
			height: 300px;
		}
	</style>
</head>
<body>
	<h1>중고거래 보기</h1>
	<form name="frm" enctype="multipart/form-data">
	<input type="text" name="trade_bno" value="${vo.trade_bno}" style="display:none"/>
	<table border=1>		
		<tr>
			<td><input type="text" name="trade_writer" value="${vo.trade_writer}"/></td>
			<td><fmt:formatDate value="${vo.trade_regdate}" pattern="yyyy-MM-dd kk:mm:ss"/></td>
			<td>조회수:${vo.trade_viewcnt}</td>
		</tr>
		<tr>
			<td>
				<select name="trade_category" value="${vo.trade_category}">	
					<option>${vo.trade_category}</option>
					<option value="구매">구매</option>
					<option value="판매">판매</option>
					<option value="나눔">나눔</option>
				</select>
			</td>
			<td colspan=2><input type="text" name="trade_title" value="${vo.trade_title}"/></td>
		</tr>
		<tr>
			<td colspan=3>
			<!-- Slider main container -->
			<div class="swiper-container">
				<!-- Additional required wrapper -->
  				<div id="attachFiles" class="swiper-wrapper">
	                <script id="temp" type="text/x-handlebars-template">
					{{#each list}}
                    	<div class="swiper-slide">
							<img src="/displayFile?fullName={{trade_bno}}/{{trade_attach_image}}"width=200/>
						</div>
					{{/each}}
                  	</script>
            	</div>
            	<!-- If we need pagination -->
  				<div class="swiper-pagination"></div>
  				<!-- If we need navigation buttons -->
				<div class="swiper-button-prev"></div>
				<div class="swiper-button-next"></div>				
		    </div>
			</td>
		</tr>
		<tr>
			<td colspan=3>
				<textarea rows="10" cols="52" name="trade_content">${vo.trade_content}</textarea>
			</td>
		<tr>
		<tr>
			<td>♥</td>
			<td><input type="number" name=""trade_price" value="${vo.trade_price}"/></td>
			<td><button>채팅으로 거래하기</button></td>
		</tr>
	</table>
	<input type="button" value="글수정" onClick="location.href='update?trade_bno=${vo.trade_bno}'"/>
	<input type="button" value="글삭제" id="btnDelete"/>
	<input type="button" value="목록이동" onClick="location.href='list'"/>
	</form>
</body>
<script>
	var trade_bno=$(frm.trade_bno).val();
	
	$("#btnDelete").on("click", function(){
		if(!confirm("삭제하실래요?")) return;
		frm.action="delete";
		frm.method="get";
		frm.submit();
	});
	
	//첨부파일 출력
	   getAttach();   
	   function getAttach(){
	      $.ajax({
	         type:"get",
	         url:"getAttach",
	         data:{"trade_bno":trade_bno},
	         dataType:"json",
	         success:function(data){
	            var temp = Handlebars.compile($("#temp").html());
	            $(data).each(function(){	                     
	            $("#attachFiles").append(temp(data));
	            
	            const swiper = new Swiper('.swiper-container', {
	      		  // Optional parameters
	      		  direction: 'horizontal',
	      		  loop: true,
	      	
	      		  // If we need pagination
	      		  pagination: {
	      		    el: '.swiper-pagination',
	      		  },
	      	
	      		  // Navigation arrows
	      		  navigation: {
	      		    nextEl: '.swiper-button-next',
	      		    prevEl: '.swiper-button-prev',
	      		  },
	      	
	      		  // And if we need scrollbar
	      		  scrollbar: {
	      		    el: '.swiper-scrollbar',
	      		  },
	      		});
	            });
	         }
	      });
	   }

</script>
</html>
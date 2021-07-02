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
	<link rel="stylesheet" href="/resources/css/trade/read.css"/>
	<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.css" />
	<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css" />
	<script src="https://unpkg.com/swiper/swiper-bundle.js"></script>
	<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
	<style>
		.swiper-container {
			width: 300px;
			height: 300px;
		}
	</style>
</head>
<body>
	<form name="frm" enctype="multipart/form-data">
	<input type="hidden" name="trade_bno" value="${vo.trade_bno}" style="display:none"/>
	<table id="tbl" style="width:600px; margin: 0px auto; margin-bottom:30px;">		
		<tr>
			<td rowspan=6>
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
		<tr style="border-bottom: 1px solid #ccc;">
			<td id="twriter">${vo.trade_writer}</td>
			<td id="theart">
				<c:if test="${keep.trade_keep==1 }">
					<img src="/resources/css/heart-fill.svg" class="heart">
				</c:if>
				<c:if test="${keep.trade_keep!=1 }">
					<img src="/resources/css/heart.svg" class="heart">
				</c:if>	
			</td>
			<td id="chat"><img src="/resources/css/chat-left-dots.svg" class="chat" onClick="location.href='chat'" style="cursor:pointer;"></td>
		</tr>
		<tr>	
			<td colspan="2" id="tdate"><fmt:formatDate value="${vo.trade_regdate}" pattern="yyyy-MM-dd kk:mm:ss"/></td>
			<td id="tvcnt">조회수:${vo.trade_viewcnt}</td>
		</tr>
		<tr>
			<td id="tcate">${vo.trade_category}</td>
			<td colspan=2 id="ttitle">${vo.trade_title}</td>
		</tr>
		<tr>
			<td colspan=3 id="tprice">${vo.trade_price}원</td>			
		</tr>
		<tr>
			<td colspan=3 id="tcont">
				<textarea rows="10" cols="52" name="trade_content" style="font-size: 15px;background-color:transparent;border:0 solid black;text-align:left;">${vo.trade_content}</textarea>
			</td>
		<tr>		
	</table>
	<input type="button" value="글수정" onClick="location.href='update?trade_bno=${vo.trade_bno}'"id="btnUpdate"/>
	<input type="button" value="글삭제" id="btnDelete"/>
	<input type="button" value="목록이동" onClick="location.href='list'" id="btnList"/>
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
	   
	 //즐겨찾기 추가 삭제
		$(".heart").on("click", function(){
			var trade_bno = "${vo.trade_bno}";
			var user_id = "${user_id}";
			
			if(user_id==null || user_id==""){
				alert("로그인이 필요한 기능입니다.")
			}else{
				alert(trade_bno + user_id);
				$.ajax({
					type:"get",
					url:"keepRead.json",			
					data:{"trade_bno":trade_bno, "user_id":user_id},			
					success:function(result){				
						var strUid=result.user_id;
						var keep=result.trade_keep;
						alert(strUid + keep);
						if(strUid == user_id){
							if(keep == 0){						
								$.ajax({
									type:"post",
									url:"keepUpdate",
									data:{"trade_bno":trade_bno, "user_id":user_id, "trade_keep":1},
									success:function(){
										alert("즐겨찾기 추가!");
										location.reload();
									}
								});
							}else{
								$.ajax({
									type:"post",
									url:"keepUpdate",
									data:{"trade_bno":trade_bno, "user_id":user_id, "trade_keep":0},
									success:function(){
										alert("즐겨찾기 삭제!");
										location.reload();
									}
								});
							}					
						}else{					
							$.ajax({
								type:"post",
								url:"keepInsert",
								data:{"trade_bno":trade_bno, "user_id":user_id, "trade_keep":1},
								success:function(){
									alert("즐겨찾기 추가!");
									location.reload();
								}
							});
						}
					}
				});
			}
		})

</script>
</html>
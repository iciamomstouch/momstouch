<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>중고거래</title>
	<style>
		.row {cursor:pointer;}
		#pagination span {cursor: pointer; color:black; border:1px solid gray; padding:5px; background:white;}
		#pagination .active {background:gray; color:white;}
	</style>
	<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
</head>
<body>
	<h1>중고거래</h1>
	<table border=1 style=margin-top:10px;>
		<tr>
			<td>이미지</td>
			<td>카테고리</td>
			<td>제목</td>
			<td>가격</td>
			<td>작성자</td>
			<td>작성일</td>
			<td>관심목록</td>
		</tr>
		<c:forEach items="${list}" var="vo">
			<tr class="row" onClick="location.href='read?trade_bno=${vo.trade_bno}'">
				<td class="trade_image">
					<c:if test="${vo.trade_image==null}">
						<img src="http://placehold.it/100x80"/>
					</c:if>
					<c:if test="${vo.trade_image!=null}">
						<img src="/displayFile?fullName=${vo.trade_image}" width=100/>
					</c:if>	
				</td>
				<td class="trade_category"}>${vo.trade_category}</td>
				<td class="trade_title">${vo.trade_title}</td>
				<td class="trade_price"><fmt:formatNumber value="${vo.trade_price}" pattern="#,###원"/></td>
				<td class="trade_witer">${vo.trade_writer}</td>
				<td class="trade_regdate"><fmt:formatDate value="${vo.trade_regdate}" pattern="yyyy-MM-dd kk:mm:ss"/></td>
				<td>
				${vo.trade_keep}
				</td>
			</tr>
		</c:forEach>
	</table>
	<button onClick="location.href='insert'">글작성</button>
	<hr/>
	<div id="pagination">
		<c:if test="${pm.prev}">
			<span page="${pm.startPage-1}">◀</span>
		</c:if>
		<c:forEach begin="${pm.startPage}" end="${pm.endPage}" var="i">
			<c:if test="${i==cri.page}">
				<span page="${i}" class="active">${i}</span>
			</c:if>	
			<c:if test="${i!=cri.page}">
				<span page="${i}">${i}</span>
			</c:if>
		</c:forEach>
		<c:if test="${pm.next}">
			<span page="${pm.endPage+1}">▶</span>
		</c:if>
	</div>	
</body>
<script>
	var totalCount=${pm.totalCount};
	$("#totalCount").html(totalCount);
	
	$("#container").on("click", ".box", function(){
		var bno=$(this).attr("bno");
		location.href="read?bno="+bno;	
	});
	
	$("#pagination").on("click", "span", function(){
		var page=$(this).attr("page");
		location.href="list?page=" + page;
	});
</script>
</html>
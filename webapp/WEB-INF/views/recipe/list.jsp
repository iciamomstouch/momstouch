<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
	<title>레시피</title>
	<style>
		#pagination a{text-decoration:none;color:green;}
		#pagination .active{color:red;}
	</style>
</head>
<body>
	<h1>[레시피목록]</h1>
	<div>
		<button onClick="location.href='insert'">레시피등록</button>
		총갯수:<span id="totalCount">${pm.totalCount }</span>
	</div>
	<div>
		<input type="text" placeholder="검색어"/><button>검색</button>
	</div>
	<div>
		<table border=1>
			<tr>
				<span><button>산모</button></span>
				<span><button>4~6개월</button></span>
				<span><button>7~9개월</button></span>
				<span><button>10~12개월</button></span>
				<span><button>12개월 이상</button></span>
			</tr>
			<c:forEach items="${list}" var="vo">
			<tr>
				<td rowspan=2>
					<img src="/displayFile?fullName=${vo.recipe_image}" width=100/>
				</td>
				<td onClick="location.href='read?recipe_bno=${vo.recipe_bno}'">${vo.recipe_title}</td>
				<td><span>조회수:</span>${vo.recipe_viewcnt }</td>
			</tr>
			<tr>
				<td>${vo.recipe_userRatingAvg }</td>
				<td>❤</td>
			</tr>
			</c:forEach>
		</table>
	</div>
	<hr/>
	<div id="pagination">
		<c:if test="${pm.prev }">
			<a href="list?page=${pm.startPage-1}">이전</a>
		</c:if>
		<c:forEach begin="${pm.startPage }" end="${pm.endPage}" var="i">
			<c:if test="${i==cri.page }">
				<a class="active" href="list?page=${i}">${i}&nbsp;</a>
			</c:if>
			<c:if test="${i!=cri.page }">
				<a href="list?page=${i}">${i}&nbsp;</a>
			</c:if>
		</c:forEach>
		<c:if test="${pm.next }">
			<a href="list?page=${pm.endPage+1}">다음</a>
		</c:if>
</body>
</html>
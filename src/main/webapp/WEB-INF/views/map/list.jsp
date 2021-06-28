<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Insert title here</title>
	<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
 	<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
 	<script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=99fc73c0b157f0cc943b0f40fbf34711&libraries=services"></script>
</head>
<body>
	<div id="divHeader"><h2>장소 검색</h2></div>
	<div id="divCondition">
		<input type="text" id="query" value="요양원">
		<input type="button" value="검색" id="btnSearch">
		<select id="size">
			<option value=5>5행 출력</option>
			<option value=10>10행 출력</option>
		</select>
		<select id="sortBy">
			<option value=accuracy>정확도 순</option>
			<option value=distance>거리순</option>
		</select>
	 	검색데이타:<span id="total"></span>
 	</div>
 	
	<table id="tbl" border=1></table>
	<script id="temp" type="text/x-handlebars-template">
 	<tr class="title">
		<td width=200>장소이름</td>
 		<td width=300>주소</td>
 		<td width=130>전화번호</td>
 		<td width=70>위치보기</td>
 	</tr>
	{{#each documents}}
	<tr class="row">
 		<td>{{place_name}}</td>
 		<td>{{address_name}}
 		<td>{{phone}}</td>
 		<td>
			<button x={{x}} y={{y}} place="{{place_name}}" tel="{{phone}}">위치보기</button>
		</td>
 	</tr>
 	{{/each}}
 	</script>
 	
	<div id="pagination">
		<button id="btnPre">◀</button> 
		<button id="btnNext">▶</button>
	 	<span id="curPage"></span>/<span id="totPage"></span>
	 </div>
	 
	 <!-- 지도 출력 영역 -->
	 <div id="divMap">
		 <div id="map"></div>
		 <div style="text-align:center;"><a id="btnClose" href="#">닫기</a></div>
	 </div> 
</body>
<script>
$("#divMap").hide();
var page=1, size, query, total, totPage;
getList();

$("#tbl").on("click", ".row button", function(){
	$("#divMap").show();
	var lat=$(this).attr("y");
	var lng=$(this).attr("x");
	var place=$(this).attr("place");
	var tel=$(this).attr("tel");
	 
	var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
	//지도를 생성할 때 필요한 기본 옵션
	var options = { center: new kakao.maps.LatLng(lat, lng), level: 3 };
	var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
	var marker= new kakao.maps.Marker({ position: new kakao.maps.LatLng(lat, lng) });
	marker.setMap(map);
	 
	var str ="<div style='padding:5px;font-size:12px;'>";
	str += place + "<br>" + tel;
	str +="</div>";
	var info=new kakao.maps.InfoWindow({ content:str });
	 
	kakao.maps.event.addListener(marker, "mouseover", function(){ info.open(map, marker); });
	kakao.maps.event.addListener(marker, "mouseout", function(){ info.close(map, marker); });
});
	 
	 $("#btnClose").on("click", function(){ $("#divMap").hide(); });
	 $("#btnSearch").on("click",function(){ page=1; getList(); });
	 $("#size, #query").on("change", function(){ page=1; getList(); });
	 $("#btnNext").click(function(){ page++; getList(); });
	 $("#btnPre").click(function(){ page--; getList(); });
	 
function getList(){
	query=$("#query").val();
	size=$("#size").val();
	sortBy=$("#sortBy").val();
		$.ajax({
			type:"get", 
			url:"https://dapi.kakao.com/v2/local/search/keyword.json", 
			headers:{"Authorization":"KakaoAK 2c24467c55f72e8bf88cecfd0c84f74f"}, 
			dataType:"json", 
			data:{"query":query,"page":page,"size":size, "sortBy":sortBy}, 
			success:function(data){
				var template = Handlebars.compile($("#temp").html());
				$("#tbl").html(template(data));
				total=data.meta.pageable_count;
				if(total % size==0){
					totPage=total/size;
				}else{
					totPage=parseInt(total/size)+1;
				}
				 
				if(page==1){
					$("#btnPre").attr("disabled",true);
				}else{ $("#btnPre").attr("disabled",false); }
				 
				if(data.meta.is_end){
					$("#btnNext").attr("disabled",true);
				}else{ $("#btnNext").attr("disabled",false);}
				 
				$("#curPage").html(page);
				$("#totPage").html(totPage);
				$("#total").html(total);
			 }
		});
}
	 
</script>
</html>
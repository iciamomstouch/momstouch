<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=99fc73c0b157f0cc943b0f40fbf34711&libraries=services,clusterer,drawing"></script>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>지도</title>
</head>
<body>
	<h1>지도</h1>
	<input type=button value="내 위치 가져오기" onClick="getCurrentPosBtn()" />
	<input type=button value="산후조리원" id="btnPostpartumcareCenter" />
	<input type=button value="산부인과" id="btnObstetricsAndGynecology"/>
	<input type=button value="보건소" id="btnPublicHealth"/>
	<hr />

	<p style="margin-top: -12px">
		<b>Chrome 브라우저는 https 환경에서만 geolocation을 지원합니다.</b> 참고해주세요.
	</p>
	<div id="map" style="width: 100%; height: 500px;"></div>

	<!--지도출력 -->
	<div id="map" style="width: 500px; height: 500px;"></div>
</body>
<script>
var markers = [];
var lat;
var lon;
var locPosition;

var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };  

// 지도를 생성합니다    
var map = new kakao.maps.Map(mapContainer, mapOption);

//장소 검색 객체를 생성합니다
var ps = new kakao.maps.services.Places();

//지도에 idle 이벤트를 등록합니다
kakao.maps.event.addListener(map, 'idle', searchPlaces);

// HTML5의 geolocation으로 사용할 수 있는지 확인합니다 
if (navigator.geolocation) {
    
    // GeoLocation을 이용해서 접속 위치를 얻어옵니다
    navigator.geolocation.getCurrentPosition(function(position) {
        
        var lat = position.coords.latitude, // 위도
            lon = position.coords.longitude; // 경도
        
        var locPosition = new kakao.maps.LatLng(lat, lon), // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다
            message = '<div style="padding:5px;">여기에 계신가요?!</div>'; // 인포윈도우에 표시될 내용입니다
        
        // 마커와 인포윈도우를 표시합니다
        displayMarker2(locPosition, message);
            
     // 키워드로 장소를 검색합니다
        $("#btnPostpartumcareCenter").on("click",function(){
        	removeMarker();
        	var latlon= new daum.maps.LatLng(lat, lon);
        	ps.keywordSearch('산후조리원', placesSearchCB, {useMapBounds:true,location:latlon,sort:kakao.maps.services.SortBy.DISTANCE}); 
        });
     
        $("#btnObstetricsAndGynecology").on("click",function(){
        	removeMarker();
        	var latlon= new daum.maps.LatLng(lat, lon);
        	ps.keywordSearch('산부인과', placesSearchCB, {useMapBounds:true,location:latlon,sort:kakao.maps.services.SortBy.DISTANCE}); 
        });
        
        $("#btnPublicHealth").on("click",function(){
        	removeMarker();
        	var bounds = map.getBounds();
        	var latlon= new daum.maps.LatLng(lat, lon);
        	ps.keywordSearch('보건소', placesSearchCB, {bounds:bounds,location:latlon,sort:kakao.maps.services.SortBy.DISTANCE}); 
        });
            
      });
    
} else { // HTML5의 GeoLocation을 사용할 수 없을때 마커 표시 위치와 인포윈도우 내용을 설정합니다
    
    var locPosition = new kakao.maps.LatLng(33.450701, 126.570667),    
        message = 'geolocation을 사용할수 없어요..'
        
    displayMarker2(locPosition, message);
}

	function displayMarker2(locPosition, message) {
	
	    // 마커를 생성합니다
	    var marker = new kakao.maps.Marker({  
	        map: map, 
	        position: locPosition
	    }); 
	    
	    var iwContent = message, // 인포윈도우에 표시할 내용
	        iwRemoveable = true;
	
	    // 인포윈도우를 생성합니다
	    var infowindow = new kakao.maps.InfoWindow({
	        content : iwContent,
	        removable : iwRemoveable
	    });
	    
	    // 인포윈도우를 마커위에 표시합니다 
	    infowindow.open(map, marker);
	    
	    // 지도 중심좌표를 접속위치로 변경합니다
	    map.setCenter(locPosition);      
	}    
	
	function locationLoadSuccess(pos){
	    // 현재 위치 받아오기
	    var currentPos = new kakao.maps.LatLng(pos.coords.latitude,pos.coords.longitude);

	    // 지도 이동(기존 위치와 가깝다면 부드럽게 이동)
	    map.panTo(currentPos);

	    // 마커 생성
	    var marker = new kakao.maps.Marker({
	        position: currentPos
	    });

	    // 기존에 마커가 있다면 제거
	    marker.setMap(null);
	    marker.setMap(map);
	};

	function locationLoadError(pos){
	    alert('위치 정보를 가져오는데 실패했습니다.');
	};

	// 위치 가져오기 버튼 클릭시
	function getCurrentPosBtn(){
	    navigator.geolocation.getCurrentPosition(locationLoadSuccess,locationLoadError);
	};



//마커를 클릭하면 장소명을 표출할 인포윈도우 입니다
var infowindow = new kakao.maps.InfoWindow({zIndex:1});


// 키워드 검색 완료 시 호출되는 콜백함수 입니다
function placesSearchCB (data, status, pagination) {

    // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
    // LatLngBounds 객체에 좌표를 추가합니다
    var bounds = new kakao.maps.LatLngBounds();
    for (var i=0; i<data.length; i++) {
        displayMarker(data[i]);    
        bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
    }       
    // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
    map.setBounds(bounds);
}

// 지도에 마커를 표시하는 함수입니다
function displayMarker(place) { 
    // 마커를 생성하고 지도에 표시합니다
    	var marker = new kakao.maps.Marker({
        map: map,
        position: new kakao.maps.LatLng(place.y, place.x)
    });
    
    // 마커에 클릭이벤트를 등록합니다
    kakao.maps.event.addListener(marker, 'click', function() {
        // 마커를 클릭하면 장소명이 인포윈도우에 표출됩니다
        infowindow.setContent('<div style="padding:5px;font-size:12px;">' + place.place_name + '</div>');
        infowindow.open(map, marker); 
    });
    
	marker.setMap(map); // 지도 위에 마커를 표출합니다
   	markers.push(marker);  // 배열에 생성된 마커를 추가합니다

   	return marker;
}

//지도 위에 표시되고 있는 마커를 모두 제거합니다
function removeMarker() {
	for ( var i = 0; i < markers.length; i++ ) {
	infowindow.close();
	markers[i].setMap(null);
	}
	markers = [];
}
	
</script>
</html>
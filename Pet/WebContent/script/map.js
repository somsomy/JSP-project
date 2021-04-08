/**
 * 
 */

var container = document.getElementById('map');
var options = {
	center: new kakao.maps.LatLng(35.158425919461344, 129.06207189908764),
	level: 3
};

 var map = new kakao.maps.Map(container, options);

var marker = new kakao.maps.Marker({
    map: map, 
    position: new kakao.maps.LatLng(35.158425919461344, 129.06207189908764)
});

var content = '<div class="wrap">' + 
            '    <div class="info">' + 
            '        <div class="title">' + 
            '            고양이의 하루' + 
            '            <div class="close" onclick="closeOverlay()" title="닫기"></div>' + 
            '        </div>' + 
            '        <div class="body">' + 
            '            <div class="img">' +
            '                <img src="../images/company/mapimg.png" width="73" height="70">' +
            '           </div>' + 
            '            <div class="desc">' + 
            '                <div class="ellipsis">부산광역시 부산진구 부전동 동천로 109 7층 아이티윌 부산교육센터</div>' + 
            '                <div class="jibun ellipsis">(우) 47246 (지번) 부전동 112-3</div>' + 
            '                <div><a href="http://www.itwillbs.co.kr/" target="_blank" class="link">홈페이지</a> <a href="https://map.kakao.com/link/to/아이티윌 부산교육센터, 35.158425919461344, 129.06207189908764" target="_blank" class="link">길찾기</a></div>' + 
            '            </div>' + 
            '        </div>' + 
            '    </div>' +    
            '</div>';

var overlay = new kakao.maps.CustomOverlay({
    content: content,
    map: map,
    position: marker.getPosition()       
});

kakao.maps.event.addListener(marker, 'click', function() {
    overlay.setMap(map);
});

function closeOverlay() {
    overlay.setMap(null);     
}

var mapTypeControl = new kakao.maps.MapTypeControl();


map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);

var zoomControl = new kakao.maps.ZoomControl();
map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);
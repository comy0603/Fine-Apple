<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!-- ***** Footer Area Start ***** -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=2ffa19e587162bb88938c9c4e9b32e0e"></script>
<style>
	.wrap {position: absolute;left: 0;bottom: 40px;width: 288px;height: 132px;margin-left: -144px;text-align: left;overflow: hidden;font-size: 12px;font-family: 'Malgun Gothic', dotum, '돋움', sans-serif;line-height: 1.5;}
	.wrap * {padding: 0;margin: 0;}
	.wrap .info {width: 286px;height: 120px;border-radius: 5px;border-bottom: 2px solid #ccc;border-right: 1px solid #ccc;overflow: hidden;background: #fff;}
	.wrap .info:nth-child(1) {border: 0;box-shadow: 0px 1px 2px #888;}
	.info .title {padding: 5px 0 0 10px;height: 30px;background: #eee;border-bottom: 1px solid #ddd;font-size: 18px;font-weight: bold;}
	.info .close {position: absolute;top: 10px;right: 10px;color: #888;width: 17px;height: 17px;background: url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/overlay_close.png');}
	.info .close:hover {cursor: pointer;}
	.info .body {position: relative;overflow: hidden;}
	.info .desc {position: relative;margin: 13px 0 0 90px;height: 75px;}
	.desc .ellipsis {overflow: hidden;text-overflow: ellipsis;white-space: nowrap;}
	.desc .jibun {font-size: 11px;color: #888;margin-top: -2px;}
	.info .img {position: absolute;top: 6px;left: 5px;width: 73px;height: 71px;border: 1px solid #ddd;color: #888;overflow: hidden;}
	.info:after {content: '';position: absolute;margin-left: -12px;left: 50%;bottom: 0;width: 22px;height: 12px;background: url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')}
	.info .link {color: #5085BB;}
</style>

<footer class="footer-area section-padding-100">
    <!-- Main Footer Area -->
	<div class="main-footer-area">
		<div class="container-fluid">
			<div class="row">
				<div class="col-12 col-sm-6 col-xl-3">
					<div class="footer-widget-area">
						<div class="footer-logo">
                        	<img src="/resources/img/core-img/logo2.png" alt="">
                    	</div>
	                   	<p>Fine-Apple 팀은<br> 고객, 공급자 모두 만족할 수 있는 컨텐츠를 만들겠습니다.</p>
						<p>제품 생산자와 서비스 소비자들을 위한 팀이 되겠습니다.</p>
						<p>항상 제품의 목적에 부합하는 서비스를 제공하겠습니다.</p>
	                    <div class="footer-social-info">
	                    	<a href="#"><i class="fa fa-google-plus" aria-hidden="true"></i></a>
	                        <a href="#"><i class="fa fa-pinterest" aria-hidden="true"></i></a>
	                        <a href="#"><i class="fa fa-facebook" aria-hidden="true"></i></a>
	                        <a href="#"><i class="fa fa-twitter" aria-hidden="true"></i></a>
	                    </div>
					</div>
				</div>

				<div class="col-12 col-sm-6 col-xl-3">
					<div class="footer-widget-area">
						<div class="widget-title">
							<h6>최신 뉴스 / 공지사항</h6>
						</div>
						<div class="widget-blog-post">
	                        <!-- Single Blog Post -->
							<div class="widget-single-blog-post d-flex">
								<div class="widget-post-thumbnail">
									<img src="/resources/img/bg-img/handshake2.jpg" alt="">
	                  			</div>
			                  	<div class="widget-post-content">
			                    	<a href="/news/list">인천일보아카데미와 계약체결</a>
			                    	<p>Mar 15, 2021</p>
								</div>
							</div>
							<!-- Single Blog Post -->
							<div class="widget-single-blog-post d-flex">
								<div class="widget-post-thumbnail">
									<img src="/resources/img/bg-img/thingspeak.png" alt="">
			                  	</div>
			                  	<div class="widget-post-content">
			                    	<a href="/news/list">내 데이터 직접 열람하기!</a>
			                      	<p>Mar 15, 2021</p>
			                  	</div>
			              	</div>
			              	<!-- Single Blog Post -->
			              	<br>
			               	<div class="widget-single-blog-post d-flex">
			               		<div class="widget-post-thumbnail">
			                    	<img src="/resources/img/bg-img/ifttt.png" alt="">
			                   	</div>
			                   	<div class="widget-post-content">
			                    	<a href="/news/list">Fine-Apple 서비스 휴대폰 연동하기</a>
			                       	<p>Mar 15, 2021</p>
			                   	 </div>
			               	</div>
						</div>
					</div>
				</div>

				<div class="col-12 col-sm-6 col-xl-3">
					<div class="footer-widget-area">
						<div class="widget-title">
							<h6>찾아오시는 길</h6>
						</div>
						<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=2ffa19e587162bb88938c9c4e9b32e0e"></script>
						<div id="map" style="width:780px;height:380px;"></div>
						<script>
							var mapContainer = document.getElementById('map'), // 지도의 중심좌표
						    mapOption = { 
						        center: new kakao.maps.LatLng(37.438909, 126.675105), // 지도의 중심좌표
						        level: 3 // 지도의 확대 레벨
						    }; 

							var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
		
							// 지도에 마커를 표시합니다 
							var marker = new kakao.maps.Marker({
							    map: map, 
							    position: new kakao.maps.LatLng(37.438909, 126.675109)
							});

							// 커스텀 오버레이에 표시할 컨텐츠 입니다
							// 커스텀 오버레이는 아래와 같이 사용자가 자유롭게 컨텐츠를 구성하고 이벤트를 제어할 수 있기 때문에
							// 별도의 이벤트 메소드를 제공하지 않습니다 
							var content = '<div class="wrap">' + 
							            '    <div class="info">' + 
							            '        <div class="title">' + 
							            '            Fine-Apple' + 
							            '            <div class="close" onclick="closeOverlay()" title="닫기"></div>' + 
							            '        </div>' + 
							            '        <div class="body">' + 
							            '            <div class="img">' +
							            '                <img src="/resources/img/bg-img/fineApple.jpg" width="73" height="70">' +
							            '           </div>' + 
							            '            <div class="desc">' + 
							            '                <div class="ellipsis">인천 미추홀구 매소홀로488번길 6-32 태승빌딩 5층</div>' + 
							            '                <div class="jibun ellipsis">(우) 22223(지번) 학익동 663-1</div>' + 
							            '                <div><a href="https://www.icia.co.kr" target="_blank" class="link">홈페이지</a></div>' + 
							            '            </div>' + 
							            '        </div>' + 
							            '    </div>' +    
							            '</div>';
		
							// 마커 위에 커스텀오버레이를 표시합니다
							// 마커를 중심으로 커스텀 오버레이를 표시하기위해 CSS를 이용해 위치를 설정했습니다
							var overlay = new kakao.maps.CustomOverlay({
							    content: content,
							    map: map,
							    position: marker.getPosition()       
							});
		
							// 마커를 클릭했을 때 커스텀 오버레이를 표시합니다
							kakao.maps.event.addListener(marker, 'click', function() {
							    overlay.setMap(map);
							});
		
							// 커스텀 오버레이를 닫기 위해 호출되는 함수입니다 
							function closeOverlay() {
							    overlay.setMap(null);     
							}
						</script>						
			   			</div>
					</div>
				</div>
			</div>
	</div>
	<!-- Bottom Footer Area -->
	<div class="bottom-footer-area">
	    <div class="container-fluid">
	        <div class="row">
	            <div class="col-12">
	                <div class="bottom-footer-content">
	                    <!-- Copywrite Text -->
	          			<div class="copywrite-text">
	             			<p>	<!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
								Copyright &copy;<script>document.write(new Date().getFullYear());</script> The copyright of this site belongs to <i class="fa fa-heart-o" aria-hidden="true"></i> <a href="http://fine-apple.com:8088/" target="_blank">Fine-Apple</a> team
								<!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
							</p>
							<p>It was fun and good to do the project together. <a href="http://fine-apple.com:8088/" target="_blank">Thank you.</a><font color="#020f20">&nbsp&nbsp -Dahye</font>
							</p>                      
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</footer>
    <!-- ***** Footer Area End ***** -->
<!-- jQuery (Necessary for All JavaScript Plugins) -->




<script type="text/javascript" src="/resources/js/popper.min.js"></script>
<!-- Bootstrap js -->
<script type="text/javascript" src="/resources/js/bootstrap.min.js"></script>
<!-- Plugins js -->
<script type="text/javascript" src="/resources/js/plugins.js"></script>
<!-- Active js -->
<script type="text/javascript" src="/resources/js/active.js"></script>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<!-- The above 4 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<link rel="stylesheet" href="/resources/css/style.css?after" type="text/css">


<body>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
    <!-- ***** Hero Area Start ***** -->
    <section class="hero-area">
        <div class="hero-slides owl-carousel">
            <!-- Single Hero Slide -->
            <div class="single-hero-slide bg-img bg-overlay-white" style="background-image: url(/resources/img/bg-img/hangook2.jpg);">
                <div class="container h-100">
                    <div class="row h-100 align-items-center">
                        <div class="col-12">
                            <div class="hero-slides-content">
                                <h2 data-animation="fadeInUp" data-delay="100ms">Fine-Apple</h2>
                                <h6 data-animation="fadeInUp" data-delay="400ms">Home IoT Service</h6>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Single Hero Slide -->
            <div class="single-hero-slide bg-img bg-overlay-white" style="background-image: url(/resources/img/bg-img/dahyedoor1.png);">
                <div class="container h-100">
                    <div class="row h-100 align-items-center">
                        <div class="col-12">
                            <div class="hero-slides-content">
                                <h2 data-animation="fadeInUp" data-delay="100ms"><br>문열림 감지 센서</h2>
                                <h6 data-animation="fadeInUp" data-delay="400ms">보다 안전하고 안심되는 외출을 책임지는 센서</h6>
                                <a href="/show/product" class="btn medilife-btn mt-50" data-animation="fadeInUp" data-delay="700ms">더알아보기 <span>▶</span></a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Single Hero Slide -->
            <div class="single-hero-slide bg-img bg-overlay-white" style="background-image: url(/resources/img/bg-img/hyeeunfire.jpg);">
                <div class="container h-100">
                    <div class="row h-100 align-items-center">
                        <div class="col-12">
                            <div class="hero-slides-content">
                                <h2 data-animation="fadeInUp" data-delay="100ms"><br>화재 감지 센서</h2>
                                <h6 data-animation="fadeInUp" data-delay="400ms">원격으로 우리집 실내온도를 체크 및 이상 시 호출하는 센서</h6>
                                <a href="/show/product" class="btn medilife-btn mt-50" data-animation="fadeInUp" data-delay="700ms">더알아보기 <span>▶</span></a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- ***** Hero Area End ***** -->
    <!-- ***** About Us Area Start ***** -->
    <section class="medica-about-us-area section-padding-100-20">
        <div class="container">
            <div class="row" style="padding: 100px 0 125px 0;">
                <div class="col-12 col-lg-4">
                    <div class="medica-about-content">
                        <h2>Fine-Apple</h2>
                        <h2>최고의 서비스</h2>
                        <p> 저희 Fine-Apple 팀은 최고의 팀원들로 구성되어 최상의 서비스를 제공할 것을 약속합니다. 저희 팀이 제공하는 IoT 서비스는 소비자가 직접 서비스 연동을 하게되어 
                         개인정보유출 걱정 없이 소비자가 서비스를 이용할 수 있습니다. </p>
                        <a href="/show/aboutUs" class="btn medilife-btn btn-1 mt-50">About Us <span>▶</span></a>
                    </div>
                </div>
                <div class="col-12 col-lg-8">
                    <div class="row">
                        <!-- Single Service Area -->
                        <div class="col-12 col-sm-6">
                            <div class="single-service-area d-flex">
                            	<div class="service-icon">
                                	<i class="icon-doctor"></i>
                               	</div>
                                <div class="service-content">
                                    <h5>화재 감지 센서</h5>
                                    <p>실내 온도를 측정하여 사용자가 직접 기준 온도를 설정하고 기준 온도보다 실내온도가 높아지면 사용자 설정한 어플리케이션으로 알림이 가는 시스템</p>
                                </div>
                            </div>
                        </div>
                        <!-- Single Service Area -->
                        <div class="col-12 col-sm-6">
                            <div class="single-service-area d-flex">
                                <div class="service-icon">
                                    <i class="icon-blood-donation-1"></i>
                                </div>
                                <div class="service-content">
                                    <h5>문열림 감지 센서</h5>
                                    <p>문의 개폐여부를 원격으로 확인할 수 있고, 문이 열려있다면 어플리케이션을 통한 원격 조작으로 문을 잠글 수 있는 시스템</p>
                                </div>
                            </div>
                        </div>
                        <!-- Single Service Area -->
                        <div class="col-12 col-sm-6">
                            <div class="single-service-area d-flex">
                                <div class="service-icon">
                                    <i class="icon-flask-2"></i>
                                </div>
                                <div class="service-content">
                                    <h5>데이터 정보 체크 시스템</h5>
                                    <p>웹브라우저를 통해 사용자의 센서 데이터를 종합 및 도식화하여 사용자가 직접 시간대별 온도 변화, 문열림 개폐 시간을 확인할 수 있는 시스템</p>
                                </div>
                            </div>
                        </div>
                        <!-- Single Service Area -->
                        <div class="col-12 col-sm-6">
                            <div class="single-service-area d-flex">
                                <div class="service-icon">
                                    <i class="icon-emergency-call-1"></i>
                                </div>
                                <div class="service-content">
                                    <h5>실내 조도 센서(추후예정)</h5>
                                    <p>실내 조도를 감지하여 사용자가 원격으로 실내 조명을 on/off 하고 실내 조도를 조절할 수 있는 시스템</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- ***** About Us Area End ***** -->
    
            <!-- ***** Gallery Area Start ***** -->
    <div class="medilife-gallery-area owl-carousel">
        <!-- Single Gallery Item -->
        <div class="single-gallery-item">
            <img src="/resources/img/bg-img/door.png" alt="">
            <div class="view-more-btn">
                <a href="/resources/img/bg-img/door.png" class="btn gallery-img">See More +</a>
            </div>
        </div>
        <!-- Single Gallery Item -->
        <div class="single-gallery-item">
            <img src="/resources/img/bg-img/fire.png" alt="">
            <div class="view-more-btn">
                <a href="/resources/img/bg-img/fire.png" class="btn gallery-img">See More +</a>
            </div>
        </div>
        <!-- Single Gallery Item -->
        <div class="single-gallery-item">
            <img src="/resources/img/bg-img/ifttt.png" alt="">
            <div class="view-more-btn">
                <a href="/resources/img/bg-img/ifttt.png" class="btn gallery-img">See More +</a>
            </div>
        </div>
        <!-- Single Gallery Item -->
        <div class="single-gallery-item">
            <img src="/resources/img/bg-img/thingspeak.png" alt="">
            <div class="view-more-btn">
                <a href="/resources/img/bg-img/thingspeak.png" class="btn gallery-img">See More +</a>
            </div>
        </div>

        <!-- Single Gallery Item -->
        <div class="single-gallery-item">
            <img src="/resources/img/bg-img/handshake.png" alt="">
            <div class="view-more-btn">
                <a href="/resources/img/bg-img/handshake.png" class="btn gallery-img">See More +</a>
            </div>
        </div>
        
    </div>
    <!-- ***** Gallery Area End ***** -->
       
    <!-- ***** Video Area Start ***** -->
    <div style="padding: 250px 0 250px 0;">
    	<section class="medilife-video-area section-padding-100 bg-overlay bg-img" style="background-image: url(/resources/img/core-img/play.png);">
	        <div class="container">
	            <div class="row align-items-center">
	                <div class="col-12 col-lg-8">
	                    <div class="video-box bg-overlay-black">
	                        <img src="/resources/img/bg-img/playlink.png" alt="">
	                        <div class="play-btn">
	                            <a class="popup-video" href="https://www.youtube.com/watch?v=3l0QOv9KWpQ"><img src="/resources/img/core-img/play.png" alt=""></a>
	                        </div>
	                    </div>
	                </div>
	                <div class="col-12 col-lg-4">
	                    <div class="video-content">
	                        <h2>IoT Service</h2>
	                        <p>Fine-Apple의 IoT 서비스 영상으로 Fine-Apple 팀이 추구하는 서비스 방향과 우리가 왜 IoT를 이용해야하는지, IoT 서비스는 어떤 방식으로 이용할 수 있는지 알 수 있는 간단한 소개 영상</p>
	                    </div>
	                </div>
	            </div>
	        </div>
    	</section>
    </div>
    <!-- ***** Video Area End ***** -->
 
    <!-- ***** Emergency Area Start ***** -->
    <div class="medilife-emergency-area section-padding-100-50">
        <div class="container">
            <div class="row">
                <div class="col-12 col-lg-6">
                    <div class="emergency-content">
                        <i class="icon-smartphone"></i>
                        <h2>Representative Phone</h2>
                        <h3>032-123-1234</h3>
                    </div>
                </div>
                <div class="col-12 col-lg-6">
                    <div class="row">
                        <!-- Single Emergency Helpline -->
                        <div class="col-12 col-sm-6">
                            <div class="single-emergency-helpline mb-50">
                                <h5>Seoul</h5>
                                <p>02 123 1234 <br> contact@icia.co.kr <br> Seoul Seocho <br> 978 L Str</p>
                            </div>
                        </div>
                        <!-- Single Emergency Helpline -->
                        <div class="col-12 col-sm-6">
                            <div class="single-emergency-helpline mb-50">
                                <h5>Incheon</h5>
                                <p>032 123 1234 <br> contact@icia.co.kr <br> Incheon MichuHoll <br> HakIkdong 663-1 </p>
                            </div>
                        </div>
                        <!-- Single Emergency Helpline -->
                        <div class="col-12 col-sm-6">
                            <div class="single-emergency-helpline mb-50">
                                <h5>Bucheon</h5>
                                <p>031 123 1234 <br> contact@icia.co.kr <br> Bucheon Jungdong <br> Sohyang Str 248</p>
                            </div>
                        </div>
                        <!-- Single Emergency Helpline -->
                        <div class="col-12 col-sm-6">
                            <div class="single-emergency-helpline mb-50">
                                <h5>Sejong</h5>
                                <p>044 123 1234 <br> contact@icia.co.kr <br> Sejong Jochiwon <br> ShinAnn 363-28</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- ***** Emergency Area End ***** -->

<%@ include file="/WEB-INF/views/include/footer.jsp" %>


<script type="text/javascript" src="/resources/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/resources/js/active.js"></script>
<script type="text/javascript" src="/resources/js/popper.min.js"></script>





</body>

</html>
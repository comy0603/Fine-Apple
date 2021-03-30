<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<link rel="stylesheet" href="/resources/css/style.css?after" type="text/css">
<body>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
    <!-- ***** Breadcumb Area Start ***** -->
    <section class="breadcumb-area bg-img gradient-background-overlay" style="background-image: url(/resources/img/bg-img/iotpage.jpg);">
        <div class="container h-100">
            <div class="row h-100 align-items-center">
                <div class="col-12">
                    <div class="breadcumb-content">
                        <h3 class="breadcumb-title">Product</h3>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- ***** Breadcumb Area End ***** -->

    <!-- ***** Tabs Area Start ***** -->
    <section class="medilife-tabs-area section-padding-100">
        <div class="container">
            <div class="row">
                <div class="col-12">
                    <div class="medilife-tabs-content">
                        <ul class="nav nav-tabs" id="myTab" role="tablist">
                            <li class="nav-item" style="width: 23%; text-align: center;">
                                <a class="nav-link active" id="institution-tab" data-toggle="tab" href="#institution" role="tab" aria-controls="institution" aria-selected="false">화재감지</a>
                            </li>
                            <li class="nav-item" style="width: 23%; text-align: center;">
                                <a class="nav-link" id="faq-tab" data-toggle="tab" href="#faq" role="tab" aria-controls="faq" aria-selected="false">문열림감지</a>
                            </li>
                            <li class="nav-item" style="width: 23%; text-align: center;">
                                <a class="nav-link" id="specialities-tab" data-toggle="tab" href="#specialities" role="tab" aria-controls="specialities" aria-selected="true">출시예정1</a>
                            </li>
                            <li class="nav-item" style="width: 23%; text-align: center;">
                                <a class="nav-link" id="laboratory-tab" data-toggle="tab" href="#laboratory" role="tab" aria-controls="laboratory" aria-selected="false">출시예정2</a>
                            </li>
                        </ul>
                        <div class="tab-content" id="myTabContent">
                            <div class="tab-pane fade show active" id="institution" role="tabpanel" aria-labelledby="institution-tab">
                                <div class="medilife-tab-content d-md-flex align-items-center">
                               		<img src="/resources/img/bg-img/fireInfo.png" alt="">                      		
                                </div> 
                                <br />
                                <div class="medilife-tab-content d-md-flex align-items-center">
                               		<img src="/resources/img/bg-img/fireprice.png" alt="">                      		
                                </div> 
                                <div style="padding: 20px 0 30px 0;">
                                	<a href="/pay/firePayPage" class="btn medilife-btn mt-50">화재감지 서비스 가입하기 <span>▶</span></a>
                                </div>
                            </div>
                            <div class="tab-pane fade" id="faq" role="tabpanel" aria-labelledby="faq-tab">
                                <div class="medilife-tab-content d-md-flex align-items-center">
                                	<img src="/resources/img/bg-img/doorInfo.png" alt="">
                                </div>
                                <br />
                                <div class="medilife-tab-content d-md-flex align-items-center">
                                	<img src="/resources/img/bg-img/doorprice.png" alt="">
                                </div>
                                <div style="padding: 20px 0 30px 0;">
                                	<a href="/pay/doorPayPage" class="btn medilife-btn mt-50">문열림감지 서비스 가입하기 <span>▶</span></a>
                                </div>
                            </div>
                            <div class="tab-pane fade" id="specialities" role="tabpanel" aria-labelledby="specialities-tab">
                                <div class="medilife-tab-content d-md-flex align-items-center">
                                	<img src="/resources/img/bg-img/questionmark.png" alt="">                          
                                </div>
                                <br />
                                <div class="medilife-tab-content d-md-flex align-items-center">
                                	<img src="/resources/img/bg-img/questionmark.png" alt="">                          
                                </div>
                            </div>
                            <div class="tab-pane fade" id="laboratory" role="tabpanel" aria-labelledby="laboratory-tab">
                                <div class="medilife-tab-content d-md-flex align-items-center">
                                	<img src="/resources/img/bg-img/questionmark.png" alt="">
                                </div>
                                <br />
                                <div class="medilife-tab-content d-md-flex align-items-center">
                                	<img src="/resources/img/bg-img/questionmark.png" alt="">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- ***** Tabs Area End ***** -->
    
    <!-- ***** Video Area Start ***** -->
    <section class="medilife-video-area section-padding-100 bg-overlay bg-img">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-12 col-lg-8">
                    <div class="video-box bg-overlay-black">
                        <img src="/resources/img/bg-img/playlink.png" alt="">
                        <div class="play-btn">
                            <a class="popup-video" href="/resources/img/bg-img/product.mp4"><img src="/resources/img/core-img/play.png" alt=""></a>
                            <h6>제품 시연 동영상</h6>
                        </div>
                    </div>
                </div>
                <div class="col-12 col-lg-4">
                    <div class="video-content">
                        <h2>Fine-Apple Product Video</h2>
                        <p>Fine-Apple 팀에서 제공하는 서비스에 대한 동영상입니다.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- ***** Video Area End ***** -->
    
<%@ include file="/WEB-INF/views/include/footer.jsp" %>

<script type="text/javascript" src="/resources/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/resources/js/active.js"></script>
<script type="text/javascript" src="/resources/js/popper.min.js"></script>
</body>
</html>
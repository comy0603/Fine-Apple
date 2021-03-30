<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>    
    
<!DOCTYPE html>
<html>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<link rel="stylesheet" href="/resources/css/style.css?after" type="text/css">
<body>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
    <!-- ***** Breadcumb Area Start ***** -->
    <section class="breadcumb-area bg-img gradient-background-overlay" style="background-image:url(/resources/img/bg-img/iotpage.jpg);">
        <div class="container h-100">
            <div class="row h-100 align-items-center">
                <div class="col-12">
                    <div class="breadcumb-content">
                        <h3 class="breadcumb-title">Reservation Complete</h3>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- ***** Breadcumb Area End ***** -->
    
    <!-- ***** Features Area Start ***** -->
	<div class="medilife-features-area section-padding-100">			
		<div class="container">    	
	        <div class="row align-items-center">
	            <div class="col-12 col-lg-6">
	                <div class="features-content">
	                	<h3>상세 예약 정보 확인과 수정 및 취소는 <br />My Info 페이지에서 가능합니다.</h3>
	                    <a href="/user/myInfo" class="btn medilife-btn mt-50">My Info <span>▶</span></a>
	                </div>
	            </div>
	            <div class="col-12 col-lg-6">
	                <div class="features-thumbnail">
	                    <img src="/resources/img/bg-img/breadcumb2.jpg" alt="">
	                </div>
	            </div>
	        </div>
		</div>
	</div>
	<!-- ***** Features Area End ***** -->
<div style="padding: 200px 0 0 0;"></div>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
<script type="text/javascript" src="/resources/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/resources/js/active.js"></script>
<script type="text/javascript" src="/resources/js/popper.min.js"></script>
</body>



</html>
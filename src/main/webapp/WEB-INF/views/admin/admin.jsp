<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<link rel="stylesheet" href="/resources/css/style.css?after" type="text/css">
<body>
<%@ include file="/WEB-INF/views/include/headerAd.jsp" %>
    <section class="breadcumb-area bg-img gradient-background-overlay" style="background-image: url(/resources/img/bg-img/iotpage.jpg)">
        <div class="container h-100">
            <div class="row h-100 align-items-center">
                <div class="col-12">
                    <div class="breadcumb-content">
                        <h3 class="breadcumb-title">Admin Page</h3>
                    </div>
                </div>
            </div>
        </div>
    </section>
    
	<section class="section-padding-50">
    	<div class="container" style="padding: 80px 0 100px 0;">
    	    <div class="medilife-services-area clearfix">
		        <!-- Single Services Area -->
		        <div class="singleServiceArea equalize d-flex">
		           <div class="singleServiceText">
			           <a href="/news/list">
							<h2>News</h2>
							<h6>See More +</h6>  
						</a>
					</div>
		        </div>
		        <!-- Single Services Area -->
		        <div class="singleServiceArea equalize d-flex">
		            <div class="singleServiceText">
			            <a href="/admin/userInfo">
			               	<h2 style="color: #081f3e">User Info</h2>
			            	<h6>See More +</h6>
			            </a>
		            </div>
		        </div>
		        <!-- Single Services Area -->
		        <div class="singleServiceArea equalize d-flex">
		            <div class="singleServiceText">
			            <a href="/admin/userIotInfo">
			            	<h2>User IoT Info</h2>
			            	<h6 style="color: #ffffff">See More+</h6> 
			           	</a>           
		            </div>
		        </div>
    		</div>
		</div>
	</section>
	
<%@ include file="/WEB-INF/views/include/footer.jsp" %>

<script type="text/javascript" src="/resources/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/resources/js/active.js"></script>
<script type="text/javascript" src="/resources/js/popper.min.js"></script>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<!-- The above 4 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<link rel="stylesheet" href="/resources/css/style.css?after" type="text/css">
</head>
<body>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
    <!-- ***** Breadcumb Area Start ***** -->
    <section class="breadcumb-area bg-img gradient-background-overlay" style="background-image:url(/resources/img/bg-img/iotpage.jpg);">
        <div class="container h-100">
            <div class="row h-100 align-items-center">
                <div class="col-12">
                    <div class="breadcumb-content">
                        <h3 class="breadcumb-title">Pay Complete</h3>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- ***** Breadcumb Area End ***** -->
    
    <!-- ***** Features Area Start ***** -->
	<div class="medilife-features-area section-padding-100">			
		<div class="container">    	
			<div class="row h-100 align-items-center">
				<h3 class="h_tit2">결제완료정보</h3>
			</div>
			<br />
			<table class="table table-hover">
				<tbody>
					<tr>
				   		<td>Name</td>
				   		<td>${pay.userName}</td>
					</tr>
					
					<tr>
				   		<td>Phone</td>
				   		<td>${pay.userPhone}</td>					
					</tr>
					
					<tr>
				   		<td>Email</td>
				   		<td>${pay.userEmail}</td>					
					</tr>
					
					<tr>
				   		<td>OrderName</td>
				   		<td>${pay.orderName}</td>					
					</tr>
					
					<tr>
				   		<td>Payment</td>
				   		<td>${pay.payment} 원</td>					
					</tr>
					
					<tr>
						<td>Address</td>
						<td>							
							${pay.userAddr} / ${pay.userPostcode }
						</td>
					</tr>
					

					 
				</tbody>
			</table>  
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
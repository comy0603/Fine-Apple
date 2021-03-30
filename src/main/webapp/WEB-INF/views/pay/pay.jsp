<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<link rel="stylesheet" href="/resources/css/style.css?after" type="text/css">
  <!-- iamport.payment.js -->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>

</head>
<body>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
    <!-- ***** Breadcumb Area Start ***** -->
    <section class="breadcumb-area bg-img gradient-background-overlay" style="background-image: url(img/bg-img/breadcumb1.jpg);">
        <div class="container h-100">
            <div class="row h-100 align-items-center">
                <div class="col-12">
                    <div class="breadcumb-content">
                        <h3 class="breadcumb-title">Pay Page</h3>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- ***** Breadcumb Area End ***** -->
	
	<script>
		
		var IMP = window.IMP; // 생략해도 괜찮습니다.
		IMP.init("imp60131023"); // "imp00000000" 대신 발급받은 "가맹점 식별코드"를 사용합니다.

	
		function requestPay() {
			// IMP.request_pay(param, callback) 호출
			IMP.request_pay({ // param
				pg: "html5_inicis",
				pay_method: "card",
				merchant_uid: 'merchant_' + new Date().getTime(),
				name: "주문명 : 결제테스트",
				amount: 100,
				buyer_email: 'iamport@siot.do',
				buyer_name: '구매자 이름',
				buyer_tel: '010-1234-5678',
				buyer_addr: "서울특별시 강남구 신사동",
				buyer_postcode: "01181"
				
			}, function (rsp) { // callback
				
					if ( rsp.success ) {
						
						var msg = '결제가 완료되었습니다.';
						msg += '고유ID : ' + rsp.imp_uid;
						msg += '상점 거래ID : ' + rsp.merchant_uid;
						msg += '결제 금액 : ' + rsp.paid_amount;
						msg += '카드 승인번호 : ' + rsp.apply_num;
						
					}	else {
						
						var msg = '결제에 실패하였습니다. 에러내용 : ' + rsp.error_msg
					
					}
			
					alert(msg);
					
			});
    	}
  </script>
    
    
    <!-- ***** Features Area Start ***** -->
	<div class="medilife-features-area section-padding-100">
	    <div class="container">
	        <div class="row align-items-center">
	            <div class="col-12 col-lg-6">
	                <div class="features-content">
	                	<h2>We always put our pacients first</h2>
	                    <p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Lorem ipsum dolor sit amet, consectetuer adipiscing eli.Lorem ipsum dolor sit amet, consec tetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Lorem ipsum dolor sit amet, consectetuer.</p>
						<button onclick="requestPay()" class="btn medilife-btn mt-50">Payment<span>▶</span></button>
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

<%@ include file="/WEB-INF/views/include/footer.jsp" %>


<script type="text/javascript" src="/resources/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/resources/js/active.js"></script>
<script type="text/javascript" src="/resources/js/popper.min.js"></script>




</body>

</html>
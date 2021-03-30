<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<link rel="stylesheet" href="/resources/css/style.css?after" type="text/css">
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script>
$(document).ready(function() {
    		
	$("#btnPay").on("click", function() {
		
		$("#btnPay").prop("disabled", true); // 글쓰기 버튼 비활성화
		
		if($.trim($("#reserve-name").val()).length <= 0)
		{
			alert("이름을 입력하세요.");
			$("#reserve-name").val("");
			$("#reserve-name").focus();
			
			$("#btnPay").prop("disabled", false);  // 글쓰기 버튼 활성화
			
			return;
		}
		
		if($.trim($("#reserve-tel").val()).length <= 0)
		{
			alert("전화번호를 입력하세요.");
			$("#reserve-tel").val("");
			$("#reserve-tel").focus();
			
			$("#btnPay").prop("disabled", false); // 글쓰기 버튼 활성화
			
			return;
		}
		
		if($.trim($("#postcode").val()).length <= 0)
		{
			alert("주소를 입력하세요.");
			$("#postcode").val("");
			$("#postcode").focus();
			
			$("#btnPay").prop("disabled", false); // 글쓰기 버튼 활성화
			
			return;
		}
		
        var tdArr = new Array();
        var rowData = new Array(); 
        var radioBtn = $("input[name=fireService]:checked");
        
        var serviceName = "";
        var amount = "";
        var serviceData = "";
		
        radioBtn.each(function(i) {
            var tr = radioBtn.parent().parent().eq(i);
            var td = tr.children();

			rowData.push(tr.text());
			
			serviceName = td.eq(1).text();
			amount = td.eq(2).text();
			serviceData = td.eq(3).text();			

        });


		
		
		if( serviceName == 0 )
		{
			alert("요금제를 선택하세요.");
			
			$("#btnPay").prop("disabled", false); // 글쓰기 버튼 활성화
			
			return;
		}
		
		var IMP = window.IMP; // 생략해도 괜찮습니다.
		IMP.init("imp60131023"); // "imp00000000" 대신 발급받은 "가맹점 식별코드"를 사용합니다.
		
		IMP.request_pay({ // param
			pg: "html5_inicis",
			pay_method: "card",
			merchant_uid: 'merchant_' + new Date().getTime(),
			name: serviceName,
			amount: amount,
			buyer_email: "${fineUser.userEmail}",
			buyer_name: "${fineUser.userName}",
			buyer_tel: $("#reserve-tel").val(),
			buyer_addr: $("#roadAddress").val() + " " + $("#detailAddress").val() + $("#extraAddress").val(),
			buyer_postcode: $("#postcode").val()
			
		}, function (rsp) { // callback
			
				if ( rsp.success ) {
					
					var msg = "결제가 완료되었습니다."
					var merUid = 'merchant_' + new Date().getTime()

					$.ajax({
						type : "POST",
						url : "/pay/payProc",
						data : {
							pgCompany: "html5_inicis",
							kind: "card",
							merUid : merUid,
							orderName: serviceName + "(fire)",
							payment: amount,
							userEmail: "${fineUser.userEmail}",
							userName: "${fineUser.userName}",
							userPhone: $("#reserve-tel").val(),
							userAddr: $("#roadAddress").val() + " " + $("#detailAddress").val() + $("#extraAddress").val(),
							userPostcode: $("#postcode").val(),
							status : "paid"
							
						},
						datatype : "JSON",
						beforeSend : function(xhr){
				            xhr.setRequestHeader("AJAX", "true");
				        },
						success : function(response) {
							// var data = JSON.parse(obj);

							if(response.code == 0)
							{
								document.payForm.merUid.value = merUid;
								document.payForm.action = "/pay/complete";
								document.payForm.submit();
							}
							else if(response.code == 400)
							{
								alert("파라미터 값이 올바르지 않습니다.");
							}
							else if(response.code == 404)
							{
								alert("올바른 결제가 아닙니다.");
								location.href = "/show/product";
							}
							else
							{
								alert("결제 중 오류가 발생했습니다.");
							}	
						},
						error : function(xhr, status, error) 
						{
							icia.common.error(error);
						}
					});
					
					
				}	else {
					
					var msg = '결제에 실패하였습니다. 에러내용 : ' + rsp.error_msg
				
				}
				
				alert(msg);
				$("#btnPay").prop("disabled", false); // 글쓰기 버튼 활성화
		});
	});
	
	$("#btnPostcode").on("click", function() {
	    new daum.Postcode({
	        oncomplete: function(data) {
	            var addr = '';
	            var extraAddr = ''; 

	            if (data.userSelectedType === 'R') { //도로명 주소
	                addr = data.roadAddress;
	            }else { //지번 주소(J)
	                addr = data.jibunAddress;
	            }

	            if(data.userSelectedType === 'R'){
	                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                    extraAddr += data.bname;
	                }
	                if(data.buildingName !== '' && data.apartment === 'Y'){
	                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                }
	                if(extraAddr !== ''){
	                    extraAddr = ' (' + extraAddr + ')';
	                }
	                document.getElementById("extraAddress").value = extraAddr;
	            }else {
	                document.getElementById("extraAddress").value = '';
	            }

	            document.getElementById('postcode').value = data.zonecode;
	            document.getElementById("address").value = addr;
	            document.getElementById("detailAddress").focus();
	        }
	    }).open();
	});
	
});


</script>

</head>
<body>
<%@ include file="/WEB-INF/views/include/header.jsp" %>

    <!-- ***** Breadcumb Area Start ***** -->
    <section class="breadcumb-area bg-img gradient-background-overlay" style="background-image: url(/resources/img/bg-img/iotpage.jpg);">
        <div class="container h-100">
            <div class="row h-100 align-items-center">
                <div class="col-12">
                    <div class="breadcumb-content">
                        <h3 class="breadcumb-title">Payment Page</h3>
                    </div>
                </div>
            </div>
        </div>
    </section>
  
    <!-- ***** Breadcumb Area End ***** -->

    
	
	<!-- ***** Tabs Area Start ***** -->
	<section class="section-padding-50">	
		<div class="container">    	
			<div style="padding: 50px 0 70px 0;">
				<div class="row h-100 align-items-center">
					<h3 class="h_tit2">고객정보</h3>
				</div>
				<br />
				<table class="table table-hover">
					<tbody>
						<tr>
					   		<td>Name</td>
					   		<td><input type="text" id="reserve-name" maxlength="10" class="form3-control3" style="width:auto;" value="${fineUser.userName}" readonly /></td>
						</tr>
						<tr>
					   		<td><span class="ess">*</span>Phone</td>
					   		<td><input type="text" placeholder="예) 01012345678" id="reserve-tel" maxlength="11" class="form3-control3" style="width:auto;" value="${fineUser.userphone}" /></td>					
						</tr>
						<tr>
							<td><span class="ess">*</span>주소검색</td>
							<td>							
								<div class="mr-auto input-group" style="width:50%; align:center;">
									<input type="text" class="form3-control3" maxlength="20" style="width:auto; margin-right: 10px;" id="postcode" placeholder="우편번호" value="${fineUser.postcode}" >
									<button type="button" class="btn btn-secondary mb-3 mx-1" id="btnPostcode">우편번호 찾기</button>
								</div>
								<input type="text" class="form3-control4" maxlength="20" style="width:70%;" id="address" placeholder="주소" value="${fineUser.address}">
								<input type="text" class="form3-control4" maxlength="20" style="width:35%;float:left;margin-right:10px;"id="detailAddress" placeholder="상세주소" value="${fineUser.detailAddress}"> 
								<input type="text" class="form3-control4" maxlength="20" style="width:35%;float;"id="extraAddress" placeholder="참고항목" value="${fineUser.extraAddress}">
							</td>
						</tr>
					</tbody>
				</table>
			</div>                  
			<div class="row h-100 align-items-center">
				<h3 class="h_tit2">요금제 선택</h3>
			</div>
			<br />
			<form>
				<table class="table table-hover" style="text-align: center">
			  		<thead>
			    		<tr>
			      			<th></th>
			      			<th>요금제</th>
			      			<th>월정액(VAT포함)</th>
			      			<th>기본제공데이터</th>                                     
			    		</tr>
			  		</thead>
			  		<tbody style="align-text:center">
			     		<tr>	              			
	              			<td><input type="radio" name="fireService" value="Fine-IoT50(fire)"></td>
	              			<td>Fine-IoT50</td>
	              			<td>100</td>
	              			<td>500MB</td>
	            		</tr>	            	
	            		<tr>
	              			<td><input type="radio" name="fireService" value="Fine-IoT75(fire)"></td>
	              			<td>Fine-IoT75</td>
	              			<td>7500</td>
	              			<td>750MB</td>
	            		</tr>
	            		<tr>
	              			<td><input type="radio" name="fireService" value="Fine-IoT100(fire)"></td>
	              			<td>Fine-IoT100</td>
	              			<td>10000</td>
	              			<td>1.5GB</td>
	            		</tr>
	            		<tr>
	              			<td><input type="radio" name="fireService" value="Fine-IoT150(fire)"></td>
	              			<td>Fine-IoT150</td>
	              			<td>14000</td>
	              			<td>4GB</td>
	            		</tr>
			  		</tbody>
				</table>
	 		</form>
			<div style="text-align:right; padding: 40px 20px 0 0;">
				<button type="button" id="btnPay" class="btn btn-primary mb-3">Payment</button>
			</div>
		    <form name="payForm" id="payForm" method="post">
				<input type="hidden" name="merUid" value="" />
			</form>   	       
		</div>
	</section>
	<!-- ***** Tabs Area End ***** -->

<div style="padding: 200px 0 0 0;"></div>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>

<script type="text/javascript" src="/resources/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/resources/js/active.js"></script>
<script type="text/javascript" src="/resources/js/popper.min.js"></script>
</body>
</html>
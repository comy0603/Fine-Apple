<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<link rel="stylesheet" href="/resources/css/style.css?after" type="text/css">
<script>
$(document).ready(function() {
	

	$("#btnAdminUpdate").on("click", function() {
		
 		var admin = "";
		
		var check_count = document.getElementsByName("userListValue").length;
        
    	for (var i=0; i<check_count; i++) {
    		
            if (document.getElementsByName("userListValue")[i].checked == true) {
				
            	admin = document.getElementsByName("userListValue")[i].value;

        		if(confirm("관리자 권한을 부여하시겠습니까?") == true) {
        			$.ajax({
        		        type: "POST",
        		        url: "/admin/adminUpdate",
        		        data: {
        					userId: admin
        		        },
        				datatype : "JSON",
        				beforeSend : function(xhr){
        		            xhr.setRequestHeader("AJAX", "true");
        		        },
        		        success: function (response) 
        		        {
        		        	if(response.code == 0)
        		        	{
        		        		alert("해당 유저에게 관리자 권한을 부여했습니다.");
        		        		location.href = "/admin/userInfo";
        		        	}
        		        	else if(response.code == 400)
        		        	{
        		        		alert("파라미터 값이 올바르지 않습니다.");	
        		        		$("#btnAdminUpdate").prop("disabled", false);  // 글쓰기 버튼 활성화
        		        	}
        		        	else
        		        	{
        		        		alert("취소 요청 중 오류가 발생하였습니다.");
        		        		$("#btnAdminUpdate").prop("disabled", false);  // 글쓰기 버튼 활성화
        		        	}
        		        },
        				error : function(xhr, status, error) 
        				{
        					icia.common.error(error);
        				}
        		    });
        		}
			}
        }
    
	});
	
	$("#btnUserStatusUpdate").on("click", function() {
		
 		var status = "";
		
		var check_count = document.getElementsByName("userListValue").length;
        
    	for (var i=0; i<check_count; i++) {
    		
            if (document.getElementsByName("userListValue")[i].checked == true) {
				
            	status = document.getElementsByName("userListValue")[i].value;

        		if(confirm("해당 유저를 강제 탈퇴시키겠습니까?") == true) {
        			$.ajax({
        		        type: "POST",
        		        url: "/user/userStatusUpdate",
        		        data: {
        					userId: status
        		        },
        				datatype : "JSON",
        				beforeSend : function(xhr){
        		            xhr.setRequestHeader("AJAX", "true");
        		        },
        		        success: function (response) 
        		        {
        		        	if(response.code == 0)
        		        	{
        		        		alert("해당 유저를 강제 탈퇴시켰습니다.");
        		        		location.href = "/admin/userInfo";
        		        	}
        		        	else if(response.code == 400)
        		        	{
        		        		alert("파라미터 값이 올바르지 않습니다.");	
        		        		$("#btnUserStatusUpdate").prop("disabled", false);  // 글쓰기 버튼 활성화
        		        	}
        		        	else
        		        	{
        		        		alert("탈퇴 요청 중 오류가 발생하였습니다.");
        		        		$("#btnUserStatusUpdate").prop("disabled", false);  // 글쓰기 버튼 활성화
        		        	}
        		        },
        				error : function(xhr, status, error) 
        				{
        					icia.common.error(error);
        				}
        		    });
        		}
			}
        }
    
	});

	$("#btnCancelConfirm").on("click", function() {
		
 		var paySeq = "";
		
		var check_count = document.getElementsByName("payListValue").length;
        
    	for (var i=0; i<check_count; i++) {
    		
            if (document.getElementsByName("payListValue")[i].checked == true) {
				
            	paySeq = document.getElementsByName("payListValue")[i].value;

        		if(confirm("해당 결제를 취소하셨습니까?") == true) {
        			$.ajax({
        		        type: "POST",
        		        url: "/pay/payCancel",
        		        data: {
        					paySeq: paySeq
        		        },
        				datatype : "JSON",
        				beforeSend : function(xhr){
        		            xhr.setRequestHeader("AJAX", "true");
        		        },
        		        success: function (response) 
        		        {
        		        	if(response.code == 0)
        		        	{
        		        		alert("결체 취소 요청을 처리했습니다.");
        		        		location.href = "/admin/userInfo";
        		        	}
        		        	else if(response.code == 400)
        		        	{
        		        		alert("파라미터 값이 올바르지 않습니다.");	
        		        		$("#btnCancelConfirm").prop("disabled", false);  // 글쓰기 버튼 활성화
        		        	}
        		        	else
        		        	{
        		        		alert("취소 요청 중 오류가 발생하였습니다.");
        		        		$("#btnCancelConfirm").prop("disabled", false);  // 글쓰기 버튼 활성화
        		        	}
        		        },
        				error : function(xhr, status, error) 
        				{
        					icia.common.error(error);
        				}
        		    });
        		}
			}
        }
    
	});


});
</script>


<body>
<%@ include file="/WEB-INF/views/include/headerAd.jsp" %>
<section class="breadcumb-area bg-img gradient-background-overlay" style="background-image:url(/resources/img/bg-img/iotpage.jpg);">
    <div class="container h-100">
        <div class="row h-100 align-items-center">
            <div class="col-12">
                <div class="breadcumb-content">
                    <h3 class="breadcumb-title">UserInfo</h3>                        
                </div>
            </div>
        </div>
    </div>
</section>
    
<section class="section-padding-50">			
	<div class="container">    
		<div class="row h-100 align-items-center" style="padding: 20px 0 35px 20px;">
			<h3 class="h_tit2">가입자정보</h3>
		</div>
		
		<table class="table table-hover">
			<thead><%--테이블 헤드 --%>
				<tr style="background-color: #4da6f5a1;">
					<th scope="col" class="text-center" style="width:5%">선택</th>
					<th scope="col" class="text-center" style="width:10%">아이디</th>
					<th scope="col" class="text-center" style="width:10%">이름</th>
					<th scope="col" class="text-center" style="width:15%">이메일</th>
					<th scope="col" class="text-center" style="width:15%">전화번호</th>
					<th scope="col" class="text-center" style="width:35%">주소</th>
					<th scope="col" class="text-center" style="width:10%">관리자</th>
				</tr>
			</thead>
			<tbody><%-- 테이블 바디(내용보여줌) --%>			   
				<c:if test="${!empty userList}">	
					<c:forEach var="fineUser" items="${userList}" varStatus="status">	
						<tr>
							<td class="text-center"><input type="radio" name="userListValue" value="${fineUser.userId}"></td>
							<td class="text-center"><c:out value="${fineUser.userId}" /></td>
							<td class="text-center">${fineUser.userName}</td>
							<td class="text-center">${fineUser.userEmail}</td>
							<td class="text-center">${fineUser.userphone}</td>
							<td class="text-center">${fineUser.address}</td>
							<td class="text-center">${fineUser.manager}</td>
						</tr>							
					</c:forEach>
				</c:if>		   
			</tbody>
			<tfoot>
				<tr>
					<td colspan="7"></td>
				</tr>
			<tfoot>
		</table>
		<div class="col-sm-12" align="right">
			<button type="button" id="btnAdminUpdate" class="btn btn-primary mb-3 mx-1">관리자권한부여</button>
			<button type="button" id="btnUserStatusUpdate" class="btn btn-secondary mb-3 mx-1">회원강제탈퇴</button>
		</div>
	</div>
</section>
<section class="section-padding-50">			
	<div class="container">
		<div class="row h-100 align-items-center" style="padding: 0 0 35px 20px;">
			<h3 class="h_tit2">결제정보</h3>
		</div>
		<table class="table table-hover">
			<thead><%--테이블 헤드 --%>
				<tr style="background-color: #4da6f5a1;">
					<th scope="col" class="text-center" style="width:5%">선택</th>
					<th scope="col" class="text-center" style="width:10%">아이디</th>
					<th scope="col" class="text-center" style="width:10%">결제종류</th>
					<th scope="col" class="text-center" style="width:15%">상품명</th>
					<th scope="col" class="text-center" style="width:15%">결제금액</th>
					<th scope="col" class="text-center" style="width:35%">결제일자</th>
					<th scope="col" class="text-center" style="width:10%">결제상태</th>
				</tr>
			</thead>
			<tbody><%-- 테이블 바디(내용보여줌) --%>			   
				<c:if test="${!empty payList}">	
					<c:forEach var="pay" items="${payList}" varStatus="status">	
						<tr>
							<td class="text-center"><input type="radio" name="payListValue" value="${pay.paySeq}"></td>
							<td class="text-center"><c:out value="${pay.userId}" /></td>
							<td class="text-center">${pay.kind}</td>
							<td class="text-center">${pay.orderName}</td>
							<td class="text-center">${pay.payment}</td>
							<td class="text-center">${pay.buyDate}</td>
							<td class="text-center">${pay.status}</td>
						</tr>							
					</c:forEach>
				</c:if>		   
			</tbody>
			<tfoot>
				<tr>
					<td colspan="7"></td>
				</tr>
			<tfoot>
		</table>
		<div class="col-sm-12" align="right">
			<button type="button" id="btnCancelConfirm" class="btn btn-primary mb-3 mx-1">결제취소확인</button>
		</div>
	</div>  		
</section>

<section class="section-padding-50">			
	<div class="container">    
		<div class="row h-100 align-items-center" style="padding: 0 0 35px 20px;">
			<h3 class="h_tit2">예약정보</h3>
		</div>
		<table class="table table-hover">
			<thead><%--테이블 헤드 --%>
				<tr style="background-color: #4da6f5a1;">
					<th scope="col" class="text-center" style="width:10%">아이디</th>
					<th scope="col" class="text-center" style="width:20%">예약자주소</th>
					<th scope="col" class="text-center" style="width:10%">고장분류</th>
					<th scope="col" class="text-center" style="width:10%">모델명</th>
					<th scope="col" class="text-center" style="width:30%">상세 내용</th>
					<th scope="col" class="text-center" style="width:20%">날짜/시간</th>
				</tr>
			</thead>
			<tbody><%-- 테이블 바디(내용보여줌) --%>			   
				<c:if test="${!empty resList}">	
					<c:forEach var="reservation" items="${resList}" varStatus="status">	
						<tr>
							<td class="text-center"><c:out value="${reservation.userId}" /></td>
							<td class="text-center">${reservation.buyerAddr}</td>							
							<td class="text-center">
								<c:if test="${reservation.resTitle ne null}">
									<c:choose>
										<c:when test="${reservation.resTitle eq '1'}">기기문제</c:when>
								   		<c:when test="${reservation.resTitle eq '2'}">서비스문제</c:when>
								   		<c:when test="${reservation.resTitle eq '3'}">기타</c:when>
								   	</c:choose>
								</c:if>
							</td>
							<td class="text-center">
								<c:if test="${reservation.resModel ne null}">
									<c:choose>
										<c:when test="${reservation.resTitle eq '1'}">문열림센서</c:when>
								   		<c:when test="${reservation.resTitle eq '2'}">화재경보센서</c:when>
								   		<c:when test="${reservation.resTitle eq '3'}">기타</c:when>
								   	</c:choose>
								</c:if>
							</td>
							<td class="text-center">${reservation.resContent}</td>
							<td class="text-center">${reservation.resDate}</td>
						</tr>							
					</c:forEach>
				</c:if>		   
			</tbody>
			<tfoot>
				<tr>
					<td colspan="6"></td>
				</tr>
			<tfoot>
		</table>
		<div class="col-sm-12" align="right">
		</div>
	</div>
</section>
	
<div style="padding: 200px 0 0 0;"></div>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>

<script type="text/javascript" src="/resources/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/resources/js/active.js"></script>
<script type="text/javascript" src="/resources/js/popper.min.js"></script>
</body>
</html>
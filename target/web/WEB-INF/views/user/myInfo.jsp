<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<link rel="stylesheet" href="/resources/css/style.css?after" type="text/css">
<script type="text/javascript">
$(document).ready(function() {
    
	$("#btnAdmin").on("click", function() {
		
		location.href="/admin/admin";
		
	});
	
	$("#btnUpdate").on("click", function() {
		
		location.href="/user/updateForm";
		
	});
	
	$("#btnUserStatusUpdate").on("click", function() {
		
		if(confirm("탈퇴 하시겠습니까?") == true)
		{
			$.ajax({
				type : "POST",
				url : "/user/userStatusUpdate",
				data : {
					userId : "${fineUser.userId}"
				},
				datatype : "JSON",
				beforeSend : function(xhr){
		            xhr.setRequestHeader("AJAX", "true");
		        },
				success : function(response) {
					// var data = JSON.parse(obj);

					if(response.code == 0)
					{
						alert("회원 탈퇴가 완료되었습니다.");
						location.href = "/user/loginOut";
					}
					else if(response.code == 400)
					{
						alert("파라미터 값이 올바르지 않습니다.");
					}
					else if(response.code == 404)
					{
						alert("사용자 정보를 찾을수 없습니다.");
						location.href = "/user/myInfo";
					}
					else
					{
						alert("회원 탈퇴 중 오류가 발생하였습니다.");
					}	
				},
				error : function(xhr, status, error) 
				{
					icia.common.error(error);
				}
			});
		}
		
	});
	
	$("#btnPayWait").on("click", function() {
		
 		var paySeq = "";
		
		var check_count = document.getElementsByName("payListValue").length;
        
    	for (var i=0; i<check_count; i++) {
    		
            if (document.getElementsByName("payListValue")[i].checked == true) {
				
            	paySeq = document.getElementsByName("payListValue")[i].value;

        		if(confirm("선택한 결제를 취소하시겠습니까?") == true) {
        			$.ajax({
        		        type: "POST",
        		        url: "/pay/payWait",
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
        		        		alert("결제 취소 요청이 완료 됐습니다.");
        		        		location.href = "/user/myInfo";
        		        	}
        		        	else if(response.code == 400)
        		        	{
        		        		alert("파라미터 값이 올바르지 않습니다.");	
        		        		$("#btnPayWait").prop("disabled", false);  // 글쓰기 버튼 활성화
        		        	}
        		        	else
        		        	{
        		        		alert("취소 요청 중 오류가 발생하였습니다.");
        		        		$("#btnPayWait").prop("disabled", false);  // 글쓰기 버튼 활성화
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
	
	$("#btnResCancel").on("click", function() {
		
 		var resSeq = "";
		
		var check_count = document.getElementsByName("resListValue").length;
        
    	for (var i=0; i<check_count; i++) {
    		
            if (document.getElementsByName("resListValue")[i].checked == true) {
				
            	resSeq = document.getElementsByName("resListValue")[i].value;

        		if(confirm("선택한 예약을 취소하시겠습니까?") == true) {
        			$.ajax({
        		        type: "POST",
        		        url: "/reservation/resCancel",
        		        data: {
        					resSeq: resSeq
        		        },
        				datatype : "JSON",
        				beforeSend : function(xhr){
        		            xhr.setRequestHeader("AJAX", "true");
        		        },
        		        success: function (response) 
        		        {
        		        	if(response.code == 0)
        		        	{
        		        		alert("예약 취소가 완료 됐습니다.");
        		        		location.href = "/user/myInfo";
        		        	}
        		        	else if(response.code == 400)
        		        	{
        		        		alert("파라미터 값이 올바르지 않습니다.");	
        		        		$("#btnResCancel").prop("disabled", false);  // 글쓰기 버튼 활성화
        		        	}
        		        	else
        		        	{
        		        		alert("취소 요청 중 오류가 발생하였습니다.");
        		        		$("#btnResCancel").prop("disabled", false);  // 글쓰기 버튼 활성화
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
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<section class="breadcumb-area bg-img gradient-background-overlay" style="background-image:url(/resources/img/bg-img/iotpage.jpg);">
    <div class="container h-100">
        <div class="row h-100 align-items-center">
            <div class="col-12">
                <div class="breadcumb-content">
                    <h3 class="breadcumb-title">My Info</h3>
                </div>
            </div>
        </div>
    </div>
</section>

<section class="section-padding-50">			
	<div class="container">    	
		<div class="row h-100 align-items-center">
			<h3 class="h_tit2">나의 정보</h3>
		</div>
		<br />
		<table class="table table-hover">
			<tbody>
				<tr>
			   		<td>Id</td>
			   		<td>${fineUser.userId}</td>
				</tr>			
				<tr>
			   		<td>Name</td>
			   		<td>${fineUser.userName}</td>
				</tr>				
				<tr>
			   		<td>Phone</td>
			   		<td>${fineUser.userphone}</td>					
				</tr>				
				<tr>
			   		<td>Email</td>
			   		<td>${fineUser.userEmail}</td>					
				</tr>
				<tr>
					<td>Address</td>
					<td>							
						${fineUser.address} / ${fineUser.postcode }
					</td>
				</tr>					 
			</tbody>
			<tfoot><%-- 테이블 끝 --%>
				<tr>
					<td colspan="2"></td>
				</tr>
			<tfoot>
		</table>
		<div class="col-sm-12" align="right">
			<c:if test="${fineUser.manager eq 'Y'}">
				<button type="button" id="btnAdmin" class="btn btn-primary mb-3 mx-1">관리자페이지</button>
			</c:if>
			<button type="button" id="btnUpdate" class="btn btn-primary mb-3 mx-1">회원정보수정</button>
			<button type="button" id="btnUserStatusUpdate" class="btn btn-secondary mb-3 mx-1">회원탈퇴</button>
		
		</div>  
	</div>
</section>
    
    
   	<section class="section-padding-50">
		<div class="container">
			<div class="row h-100 align-items-center">
				<h3 class="h_tit2">상품 정보</h3>
			</div> <br />
			<table class="table table-hover">
				<thead><%--테이블 헤드 --%>
					<tr style="background-color: #4da6f5a1;">
						<th scope="col" class="text-center" style="width:10%">선택</th>
						<th scope="col" class="text-center" style="width:15%">상품명</th>
						<th scope="col" class="text-center" style="width:15%">결제방법</th>
						<th scope="col" class="text-center" style="width:15%">결제요금</th>
						<th scope="col" class="text-center" style="width:30%">결제일자</th>
						<th scope="col" class="text-center" style="width:15%">결제상태</th>
					</tr>
				</thead>
				<tbody><%-- 테이블 바디(내용보여줌) --%>			   
					<c:if test="${!empty paylist}">	
						<c:forEach var="pay" items="${paylist}" varStatus="status">	
					
							<tr>
								<td class="text-center">
									<c:if test="${pay.status ne 'Cancel'}">
										<input type="radio" name="payListValue" value="${pay.paySeq}">
									</c:if>
								</td>
								<td class="text-center"><c:out value="${pay.orderName}" /></td>
								<td class="text-center">${pay.kind}</td>
								<td class="text-center"><fmt:formatNumber type="number" maxFractionDigits="3" value="${pay.payment}"></fmt:formatNumber></td>
								<td class="text-center">${pay.buyDate}</td>
								<td class="text-center">${pay.status}</td>
							</tr>							
						</c:forEach>
					</c:if>
			   
				</tbody>
				<tfoot><%-- 테이블 끝 --%>
					<tr>
						<td colspan="6"></td>
					</tr>
				<tfoot>
			</table>
			<div class="col-sm-12" align="right">
				<button type="button" id="btnPayWait" class="btn btn-secondary mb-3 mx-1">결제취소</button>			
			</div>

		</div>
	</section>


<section class="section-padding-50">
		<div class="container">
			<div class="row h-100 align-items-center">
				<h3 class="h_tit2">예약 정보</h3>
			</div> <br />
			<table class="table table-hover">
				<thead><%--테이블 헤드 --%>
					<tr style="background-color: #4da6f5a1;">
						<th scope="col" class="text-center" style="width:10%">선택</th>
						<th scope="col" class="text-center" style="width:15%">고장분류</th>
						<th scope="col" class="text-center" style="width:15%">모델</th>
						<th scope="col" class="text-center" style="width:30%">고장상세내용</th>
						<th scope="col" class="text-center" style="width:30%">예약날짜/시간</th>
					</tr>
				</thead>
				<tbody><%-- 테이블 바디(내용보여줌) --%>			   
					<c:if test="${!empty reslist}">	
						<c:forEach var="reservation" items="${reslist}" varStatus="status">	
							<tr>
								<td class="text-center"><input type="radio" name="resListValue" value="${reservation.resSeq}"></td>
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
				<tfoot><%-- 테이블 끝 --%>
					<tr>
						<td colspan="5"></td>
					</tr>
				<tfoot>
			</table>
			<div class="col-sm-12" align="right">
				<button type="button" id="btnResCancel" class="btn btn-secondary mb-3 mx-1">예약취소</button>
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
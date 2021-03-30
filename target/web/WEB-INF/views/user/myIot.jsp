<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<link rel="stylesheet" href="/resources/css/style.css?after" type="text/css">

<body>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<section class="breadcumb-area bg-img gradient-background-overlay" style="background-image:url(/resources/img/bg-img/iotpage.jpg);">
    <div class="container h-100">
        <div class="row h-100 align-items-center">
            <div class="col-12">
                <div class="breadcumb-content">
                    <h3 class="breadcumb-title">My IoT</h3>
                </div>
            </div>
        </div>
    </div>
</section>
<c:if test="${fineUser.doorId ne 0 || fineUser.tmpId ne 0}">
<!-- ***** Tabs Area Start ***** -->
<section class="medilife-tabs-area section-padding-100">
    <div class="container">
        <div class="row">
            <div class="col-12">
                <div class="medilife-tabs-content">
                    <ul class="nav nav-tabs" id="myTab" role="tablist">
                    	<c:if test="${fineUser.tmpId ne 0}">
                        <li class="nav-item">
                            <a class="nav-link active" id="institution-tab" data-toggle="tab" href="#institution" role="tab" aria-controls="institution" aria-selected="false"><c:out value="${fineUser.userName}" />님의 온도 데이터</a>
                        </li>
                        </c:if>
                        <c:if test="${fineUser.doorId ne 0 }">
                        <li class="nav-item">
                            <a class="nav-link" id="faq-tab" data-toggle="tab" href="#faq" role="tab" aria-controls="faq" aria-selected="false"><c:out value="${fineUser.userName}" />님의 문열림 데이터</a>
                        </li>                        
                        </c:if>                      
                    </ul>
                    
                    <div class="tab-content" id="myTabContent">
                        <div class="tab-pane fade show active" id="institution" role="tabpanel" aria-labelledby="institution-tab">
                            <div class="medilife-tab-content d-md-flex align-items-center">                            
								<table style="width: 970px">
									<tr>
										<td><h4>실시간 온도 데이터</h4></td>
									</tr>
									<tbody>
										<tr>
											<td>
												<iframe width="450" height="260" style="border: 1px solid #cccccc;" src="https://thingspeak.com/channels/${fineUser.tmpId}/charts/1?bgcolor=%23ffffff&color=%23d62020&dynamic=true&results=60&type=line&update=15"></iframe>
											</td>
	
											<td style="padding-left:90px">
												<h5>30초 주기로 센서가 방의 온도 값을 읽어 현재까지의 온도를 그래프로 나타냅니다.</h5>
											</td>
										</tr>
										
										<tr>
											<td><h4>현재 온도 데이터</h4></td>
										</tr>
										<tbody>
										<tr>
	
										</tr>
										<tr>
										<td></td>
										</tr>
										<tr>
											<td>
												<iframe width="450" height="260" style="border: 1px solid #cccccc;" src="https://thingspeak.com/channels/${fineUser.tmpId}/widgets/${fineUser.widgetTmp}"></iframe>							</div>
											</td>
	
											<td style="padding-left:90px">
												<h5>현재 센서가 설치된 방의 온도를 <br>나타냅니다.</h5>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>	
						
                        <div class="tab-pane fade" id="faq" role="tabpanel" aria-labelledby="faq-tab">
                            <div class="medilife-tab-content d-md-flex align-items-center">                              
								<table style="width: 970px">
									<tr>
										<td><h4>실시간 문열림 데이터</h4></td>
									</tr>
									<tbody>
										<tr>
	
										</tr>
										<tr>
											<td>
												<iframe width="450" height="260" style="border: 1px solid #cccccc;" src="https://thingspeak.com/channels/${fineUser.doorId}/charts/1?bgcolor=%23ffffff&color=%23d62020&dynamic=true&results=60&type=line&update=15"></iframe>
											</td>
	
											<td style="padding-left:90px">
												<h5>30초 주기로 센서가 문의 센서 값을 읽어 현재시간까지 문이 열린 시간을 그래프로 나타냅니다.</h5>
											</td>
										</tr>
										
										<tr>
											<td><h4>현재 문열림 데이터</h4></td>
										</tr>
										<tbody>
										<tr>
	
										</tr>
										<tr>
										<td></td>
										</tr>
										<tr>
										<td>
											<iframe width="450" height="260" style="border: 1px solid #cccccc;" src="https://thingspeak.com/channels/${fineUser.doorId }/widgets/${fineUser.widgetDoor}"></iframe>
										</td>

										<td style="padding-left:90px">
											<h5>현재 센서가 설치된 문의 개폐 여부를 나타냅니다. </h5>
											<h7>*초록불 : 문이 잠겨있는 상태</h7>
										</td>
									</tr>
									</tbody>
								</table>
							</div>   
						</div>
					</div>
				</div>
				</div>
			</div>
		</div>
</section>
    <!-- ***** Tabs Area End ***** -->													

</c:if>
<c:if test="${fineUser.doorId eq 0 && fineUser.tmpId eq 0}">
<section class="section-padding-50">			
	<div class="container"> 
		<h3 class="breadcumb-title">등록된 사용자가 아닙니다!</h3>
	</div>
</section>
</c:if>

<div style="padding: 200px 0 0 0;"></div>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>
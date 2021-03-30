<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<link rel="stylesheet" href="/resources/css/style.css?after" type="text/css">
<script>
$(document).ready(function() {
	
	$("#btnSensorUpdate").on("click", function() {
		
 		var sensor = "";
		
		var check_count = document.getElementsByName("sensorListValue").length;
        
    	for (var i=0; i<check_count; i++) {
    		
            if (document.getElementsByName("sensorListValue")[i].checked == true) {
				
            	sensor = document.getElementsByName("sensorListValue")[i].value;

        		if(confirm("해당 유저의 키값을 입력하겠습니까?") == true) {
        			$.ajax({
        		        type: "POST",
        		        url: "/admin/userSensorUpdate",
        		        data: {
        					userId: sensor,
        					doorId: document.getElementsByName("doorId")[i].value,
        					tmpId: document.getElementsByName("tmpId")[i].value,
        					widgetDoor: document.getElementsByName("widgetDoor")[i].value,
        					widgetTmp: document.getElementsByName("widgetTmp")[i].value
        		        },
        				datatype : "JSON",
        				beforeSend : function(xhr){
        		            xhr.setRequestHeader("AJAX", "true");
        		        },
        		        success: function (response) 
        		        {
        		        	if(response.code == 0)
        		        	{
        		        		alert("해당 유저의 키값을 수정했습니다.");
        		        		location.href = "/admin/userIotInfo";
        		        	}
        		        	else if(response.code == 400)
        		        	{
        		        		alert("파라미터 값이 올바르지 않습니다.");	
        		        		$("#btnSensorUpdate").prop("disabled", false);  // 글쓰기 버튼 활성화
        		        	}
        		        	else
        		        	{
        		        		alert("탈퇴 요청 중 오류가 발생하였습니다.");
        		        		$("#btnSensorUpdate").prop("disabled", false);  // 글쓰기 버튼 활성화
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
                    <h3 class="breadcumb-title">User IoT Info</h3>                        
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
					<th scope="col" class="text-center" style="width:5%"></th>
					<th scope="col" class="text-center" style="width:10%">아이디</th>
					<th scope="col" class="text-center" style="width:10%">이름</th>
					<th scope="col" class="text-center" style="width:35%">주소</th>
					<th scope="col" class="text-center" style="width:10%">문열림 키</th>
					<th scope="col" class="text-center" style="width:10%">문열림 위젯</th>
					<th scope="col" class="text-center" style="width:10%">온도 키</th>
					<th scope="col" class="text-center" style="width:10%">온도 위젯</th>
				</tr>
			</thead>
			<tbody><%-- 테이블 바디(내용보여줌) --%>			   
				<c:if test="${!empty userList}">	
					<c:forEach var="fineUser" items="${userList}" varStatus="status">	
						<tr>
							<td class="text-center"><input type="radio" name="sensorListValue" value="${fineUser.userId}"></td>
							<td class="text-center"><c:out value="${fineUser.userId}" /></td>
							<td class="text-center">${fineUser.userName}</td>
							<td class="text-center">${fineUser.address}</td>
							<td class="text-center">
								<input type="text" class="form-control" name="doorId" value="${fineUser.doorId}" />
							</td>
							<td class="text-center">
								<input type="text" class="form-control" name="widgetDoor" value="${fineUser.widgetDoor}" />
							</td>
							<td class="text-center">
								<input type="text" class="form-control" name="tmpId" value="${fineUser.tmpId}" />
							</td>
							<td class="text-center">
								<input type="text" class="form-control" name="widgetTmp" value="${fineUser.widgetTmp}" />
							</td>
							
						</tr>							
					</c:forEach>
				</c:if>		   
			</tbody>
			<tfoot>
				<tr>
					<td colspan="8"></td>
				</tr>
			<tfoot>
		</table>
		<div class="col-sm-12" align="right">
			<button type="button" id="btnSensorUpdate" class="btn btn-primary mb-3 mx-1">키값부여</button>
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
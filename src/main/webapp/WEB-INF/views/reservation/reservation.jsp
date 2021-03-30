<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<style>
.form3-control3 {
  display: block;
  width: 100%;
  height: calc(1.5em + 0.75rem + 2px);
  padding: 0.375rem 0.75rem;
  font-size: 1rem;
  font-weight: 400;
  line-height: 1.5;
  color: #495057;
  background-color: #fff;
  background-clip: padding-box;
  border: 1px solid #ced4da;
  border-radius: 0.25rem;
  transition: border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out;
}
.form3-control4 {
  margin: .2em 0;
  display: inline;
  width: 100%;
  height: calc(1.5em + 0.75rem + 2px);
  padding: 0.375rem 0.75rem;
  font-size: 1rem;
  font-weight: 400;
  line-height: 1.5;
  color: #495057;
  background-color: #fff;
  background-clip: padding-box;
  border: 1px solid #ced4da;
  border-radius: 0.25rem;
  transition: border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out;
}
</style>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<link rel="stylesheet" href="/resources/css/style.css?after" type="text/css">
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<link rel="stylesheet" href="/resources/css/datepicker.min.css" type="text/css">
<script src="/resources/js/datepicker.min.js"></script>

<!-- Include English language -->
<script src="/resources/js/datepicker.en.js"></script>

<script type="text/javascript">
$(document).ready(function(){
	
	$("#btnCancel").on("click", function() {
		location.href="/index";
	});

	$("#btnReserv").on("click", function() {
	
		$("#btnReserv").prop("disabled", true); // 글쓰기 버튼 비활성화
		
		if($.trim($("#reserve-name").val()).length <= 0)
		{
			alert("이름을 입력하세요.");
			$("#reserve-name").val("");
			$("#reserve-name").focus();
			
			$("#btnReserv").prop("disabled", false);  // 글쓰기 버튼 활성화
			
			return;
		}
		
		if($.trim($("#reserve-tel").val()).length <= 0)
		{
			alert("전화번호를 입력하세요.");
			$("#reserve-tel").val("");
			$("#reserve-tel").focus();
			
			$("#btnReserv").prop("disabled", false); // 글쓰기 버튼 활성화
			
			return;
		}
		
		if($.trim($("#postcode").val()).length <= 0)
		{
			alert("주소를 입력하세요.");
			$("#postcode").val("");
			$("#postcode").focus();
			
			$("#btnReserv").prop("disabled", false); // 글쓰기 버튼 활성화
			
			return;
		}
		
		if($.trim($("#modelkind").val()) == "")
		{
			alert("기기종류를 선택하세요.");
		
			$("#btnReserv").prop("disabled", false); // 글쓰기 버튼 활성화
			
			return;
		}

		if($.trim($("#request-message").val()).length <= 0)
		{
			alert("내용을 입력하세요.");
			$("#request-message").val("");
			$("#request-message").focus();
			
			$("#btnReserv").prop("disabled", false); // 글쓰기 버튼 활성화
			
			return;
		}
		
 		var reserveType = "";

		
        var check_count = document.getElementsByName("reserve-type").length;
    	for (var i=0; i<check_count; i++) {
            if (document.getElementsByName("reserve-type")[i].checked == true) {
				reserveType = document.getElementsByName("reserve-type")[i].value;
            }
        }
     

	    
		$.ajax({
	        type: "POST",
	        url: "/reservation/resInsertProc",
	        data: {
	        	userPhone: $("#reserve-tel").val(),
				modelkind: $("#modelkind").val(),
				resTitle: reserveType,
				resDate: $("#timepicker-actions-exmpl").val(),
				resContent: $("#request-message").val(),			
	        	
				postcode: $("#postcode").val(),
				roadAddress: $("#roadAddress").val(),
				detailAddress: $("#detailAddress").val(),
				extraAddress: $("#extraAddress").val()
	        },
			datatype : "JSON",
			beforeSend : function(xhr){
	            xhr.setRequestHeader("AJAX", "true");
	        },
	        success: function (response) 
	        {
	        	if(response.code == 0)
	        	{
	        		alert("예약이 완료되었습니다.");
	        		location.href = "/reservation/complete";
	        	}
	        	else if(response.code == 400)
	        	{
	        		alert("파라미터 값이 올바르지 않습니다.");	
	        		$("#btnReserv").prop("disabled", false);  // 글쓰기 버튼 활성화
	        	}
	        	else
	        	{
	        		alert("예약 중 오류가 발생하였습니다.");
	        		$("#btnReserv").prop("disabled", false);  // 글쓰기 버튼 활성화
	        	}
	        },
			error : function(xhr, status, error) 
			{
				icia.common.error(error);
			}
	    });
	});
	
	$("#btnConfirm").on("click", function() {
		
		$.ajax({
			type : "POST",
			url : "/reservation/resSelect",
			data : {
				resDate: $("#timepicker-actions-exmpl").val(),
			},
			datatype : "JSON",
			beforeSend : function(xhr){
	            xhr.setRequestHeader("AJAX", "true");
	        },
			success : function(response) {
				// var data = JSON.parse(obj);

				if(response.code == 500)
				{
					alert("예약이 가능합니다.");
				}
				else
				{
					alert("예약이 불가능합니다.");
				}	
			},
			error : function(xhr, status, error) 
			{
				icia.common.error(error);
			}
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

<body>
<%@ include file="/WEB-INF/views/include/header.jsp" %>


    <!-- ***** Breadcumb Area Start ***** -->
    <section class="breadcumb-area bg-img gradient-background-overlay" style="background-image:url(/resources/img/bg-img/iotpage.jpg);">
        <div class="container h-100">
            <div class="row h-100 align-items-center">
                <div class="col-12">
                    <div class="breadcumb-content">
                        <h3 class="breadcumb-title">Reservation</h3>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- ***** Breadcumb Area End ***** -->
	<section class="section-padding-50">
			
    	<div class="container">
    	
			<div class="row h-100 align-items-center">
				<h3 class="h_tit2">고객정보</h3>
			</div>
			    <table class="table table-hover">
					<tbody>
						<tr>
					   		<td width="141px"><span class="ess">*</span>이름</td>
					   		<td><input type="text" id="reserve-name" maxlength="10" class="form3-control3" style="width:auto;" value="${fineUser.userName}" readonly /></td>
						</tr>
						
						<tr>
					   		<td><span class="ess">*</span>전화번호</td>
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
				<br /> <br />
				<div class="row h-100 align-items-center">
					<h3 class="h_tit2">고장정보</h3>
				</div>					
					
				<table class="table table-hover">				
					<tbody>									
						<tr>
							<td width="141px"><span class="ess">*</span>고장분류</td>
							<td>
						    	<label><input type="radio" name="reserve-type" value="1" checked="checked">&nbsp;기기문제&nbsp;&nbsp;&nbsp;</label>
						    	<label><input type="radio" name="reserve-type" value="2">&nbsp;서비스문제&nbsp;&nbsp;&nbsp;</label>
						    	<label><input type="radio" name="reserve-type" value="3">&nbsp;기타</label>
							</td>
						</tr>

						<tr>
					   		<td><span class="ess">*</span>Model</td>
					   		<td>
					   			<select name="modelkind" id="modelkind" class="custom-select" style="width:auto;">
									<option value="">기기종류</option>
									<option value="1">문열림센서</option> 
									<option value="2">화재감지센서</option>
					   				<option value="3">기타</option>
								</select>
							</td>
						</tr>
						
						<tr>
				            <td><span class="ess">*</span>상세내용</td>
				            <td>
								<textarea placeholder="어떤 서비스를 받고 싶으신지 간략히 기재해주세요. (200자 이내)" style="height:105px;border:1px solid #ced4da;border-radius:0.25rem;" id="request-message" maxlength="200" value="${resContent}"></textarea>
							</td>
						</tr>
				   </tbody>
				</table>
				<br /> <br />
				<div class="row h-100 align-items-center">
					<h3 class="h_tit2">예약정보</h3>
				</div>
				
				<table class="table table-hover">
					<tr>
						<td width="141px"><span class="ess">*</span>예약일 선택</td>
						<td>
							<div class="mr-auto input-group" style="width:50%; align:center;">
								<input type='text' class="form3-control3" style="width:70%; margin-right: 10px;" id='timepicker-actions-exmpl' /> 
								<button type="button" id="btnConfirm" class="btn btn-secondary mb-3">예약확인</button>
							</div>
						</td>

					</tr>
					<tr>
						<td>
						<p></p>
						</td>
						<td>
<pre>
* 예약시간은 평일 오전 9시부터 오후 6시 30분까지, 30분 단위로 예약이 가능합니다. 
  설정을 다하셨다면 예약 가능 확인 버튼을 통해 접수 가능 여부를 알려드립니다.	
</pre>
						</td>
					</tr>
					
				</table>
				<div class="form-group row">
					<div class="col-sm-12" align="right">
						<button type="button" id="btnReserv" class="btn btn-primary mb-3">예약하기</button>
						<button type="button" id="btnCancel" class="btn btn-secondary mb-3">취소</button>
					</div>
				</div>
			</div>

	</section>

 

<script>
	// Create start date
	var start = new Date(),
	    prevDay,
	    startHours = 9;
	
	// 09:00 AM
	start.setHours(9);
	start.setMinutes(0);
				
				    
 	// Make Sunday and Saturday disabled
    var disabledDays = [0, 6];

    $('#timepicker-actions-exmpl').datepicker({
        language: 'en',
        onRenderCell: function (date, cellType) {
            if (cellType == 'day') {
                var day = date.getDay(),
                    isDisabled = disabledDays.indexOf(day) != -1;

                return {
                    disabled: isDisabled
                }
            }
        },
				    
 
	    timepicker: true,
        startDate: start,
        minDate: start,
        minHours: startHours,
        maxHours: 18,
        minutesStep: 30,
        onSelect: function (fd, d, picker) {
            // Do nothing if selection was cleared
            if (!d) return;

            var day = d.getDay();

            // Trigger only if date is changed
            if (prevDay != undefined && prevDay == day) return;
            prevDay = day;
				
            // If chosen day is Saturday or Sunday when set
            // hour value for weekends, else restore defaults
            picker.update({
            	minHours: 9,
            	maxHours: 18
            });
        }
    });			

</script>




<div style="padding: 200px 0 0 0;"></div>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>

<script type="text/javascript" src="/resources/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/resources/js/active.js"></script>
<script type="text/javascript" src="/resources/js/popper.min.js"></script>
</body>
</html>
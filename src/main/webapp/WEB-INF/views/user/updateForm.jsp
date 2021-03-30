<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>   
<html>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<link rel="stylesheet" href="/resources/css/style.css?after" type="text/css">
<link rel="stylesheet" href="/resources/css/login.css" type="text/css">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script src="https://www.google.com/recaptcha/api.js"></script>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script type="text/javascript">
$(document).ready(function() {

	$("#btnUpdate").on("click", function() {
		
		// 모든 공백 체크 정규식
		var emptCheck = /\s/g;
		// 영문 대소문자, 숫자로만 이루어진 4~12자리 정규식
		var idPwCheck = /^[a-zA-Z0-9]{4,12}$/;
				
		if($.trim($("#userPwd1").val()).length <= 0)
		{
			alert("비밀번호를 입력하세요.");
			$("#userPwd1").val("");
			$("#userPwd1").focus();
			return;
		}
		
		if (emptCheck.test($("#userPwd1").val())) 
		{
			alert("비밀번호는 공백을 포함할 수 없습니다.");
			$("#userPwd1").focus();
			return;
		}
		
		if (!idPwCheck.test($("#userPwd1").val())) 
		{
			alert("비밀번호는 영문 대소문자와 숫자로 4~12자리 입니다.");
			$("#userPwd1").focus();
			return;
		}
		
		if ($("#userPwd1").val() != $("#userPwd2").val()) 
		{
			alert("비밀번호가 일치하지 않습니다.");
			$("#userPwd2").focus();
			return;
		}
		
		if($.trim($("#userName").val()).length <= 0)
		{
			alert("사용자 이름을 입력하세요.");
			$("#userName").val("");
			$("#userName").focus();
			return;
		}
		
		if(!fn_validateEmail($("#userEmail").val()))
		{
			alert("사용자 이메일 형식이 올바르지 않습니다.");
			$("#userEmail").focus();
			return;	
		}
		
		if($.trim($("#userphone").val()).length <= 0)
		{
			alert("사용자 연락처를 입력하세요.");
			$("#userphone").val("");
			$("#userphone").focus();
			return;
		}
		
		$("#userPwd").val($("#userPwd1").val());
		
		$.ajax({
			type : "POST",
			url : "/user/updateProc",
			data : {
				userId: $("#userId").val(),
				userPwd: $("#userPwd").val(),
				userName: $("#userName").val(),
				userEmail: $("#userEmail").val(),
				userphone: $("#userphone").val(),
				postcode: $("#postcode").val(),
				address: $("#address").val(),
				detailAddress: $("#detailAddress").val(),
				extraAddress: $("#extraAddress").val()
			},
			datatype : "JSON",
			beforeSend : function(xhr){
	            xhr.setRequestHeader("AJAX", "true");
	        },
			success : function(response) {
				// var data = JSON.parse(obj);

				if(response.code == 0)
				{
					fn_recaptcha();
				}
				else if(response.code == 400)
				{
					alert("파라미터 값이 올바르지 않습니다.");
					$("#userId").focus();
				}
				else if(response.code == 404)
				{
					alert("회원 정보가 없습니다.");
					location.href = "/";
				}
				else if(response.code == 500)
				{
					alert("회원정보 수정 중 오류가 발생하였습니다.");
					$("#userId").focus();
				}
				else
				{
					alert("회원정보 수정 중 오류가 발생하였습니다.");
					$("#userId").focus();
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

function fn_recaptcha(){
	$.ajax({
        url: "/model/VerifyRecaptcha",
        type: 'post',
        data: {
            recaptcha: $("#g-recaptcha-response").val()
        },
        success: function(data) {
        	if(data == 0) {
        		alert("회원 정보가 수정되었습니다.");
				location.href = "/index";
        	}else if(data == 1) {
        		alert("자동 가입 방지 봇을 확인 한뒤 진행 해 주세요.");
        	}else {
        		alert("자동 가입 방지 봇을 실행 하던 중 오류가 발생 했습니다. [Error bot Code : " + Number(data) + "]");
        	}
        }
    });
}

function fn_validateEmail(value)
{
	var emailReg = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;
	
	return emailReg.test(value);
}
</script>
<body>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
	<section class="section-padding-50">

		<section class="section-padding-100">
		<!-- Form-->
		<div class="form">
			<div class="form-toggle"></div>
				<div class="form-panel one">
					<div class="form-header">
						<h1 align="center">회원정보수정</h1>
					</div>
					<div class="form-content">
						<form>
							<div class="form-group">
			                    <label for="userId">사용자 아이디</label>
			                    <input type="text" id="userId" name="userId" value="${user.userId}" maxlength="12" readonly/>
			                </div>
			                <div class="form-group">
			                    <label for="userPwd1">비밀번호</label>
			                    <input type="password" id="userPwd1" name="userPwd1" value="${user.userPwd}" placeholder="비밀번호" maxlength="12" />
			                </div>
			                <div class="form-group">
			                    <label for="userPwd2">비밀번호 확인</label>
			                    <input type="password" id="userPwd2" name="userPwd2" value="${user.userPwd}" placeholder="비밀번호 확인" maxlength="12" />
			                </div>
			                <div class="form-group">
			                    <label for="username">사용자 이름</label>
			                    <input type="text" id="userName" name="userName" value="${user.userName}" placeholder="사용자 이름" maxlength="15" />
			                </div>
			                <div class="form-group">
			                    <label for="userEmail">사용자 이메일</label>
			                    <input type="text" id="userEmail" name="userEmail" value="${user.userEmail}" placeholder="사용자 이메일" maxlength="30" readonly/>
			                </div>
			                
			                <!-- Phone -->
							<div class="form-group">
								<label for="userphone">사용자 연락처</label>
								<input type="text" id="userphone" name="userphone" value="${user.userphone}" placeholder="010-0000-0000" maxlength="20"/>
							</div>
			                
			                
			                <!-- 주소입력 시작 -->
			                <div class="form-group2">
			                    <label for="address">사용자 주소(※선택사항)</label>
			                </div>
			                <div class="form-group2">    
			                    <input type="text" id="postcode" class="d_form mini" value="${user.postcode}" placeholder="우편번호">
						        <button type="button" id="btnPostcode" class="d_btn">우편번호 찾기</button>
						    </div>
						    <div class="form-group2">    
						        <input type="text" id="address" class="d_form large" value="${user.address}" placeholder="주소">
						    </div>
						    <div class="form-group2">    
						        <input type="text" id="detailAddress" class="d_form" value="${user.detailAddress}" placeholder="상세주소">
						    </div>
						    <div class="form-group2">    
						        <input type="text" id="extraAddress" class="d_form" value="${user.extraAddress}" placeholder="참고항목">
						    </div>  
			                <br>
			                <!-- 주소입력 끝 -->
			                
			                <!-- 구글 recaptcha 시작 -->
							<div id="google_recaptcha" style="padding:0px 0px 30px 0px;">
			           			<div class="g-recaptcha" data-sitekey="6LdCfEsaAAAAAFKUj_8ed6t8bWKzo7Ah_I4S5dNL"></div>
			         		</div>
			         		<!-- 구글 recaptcha 끝 -->
			         		
			                <input type="hidden" id="userId" name="userId" value="${user.userId}" />
			                <input type="hidden" id="userPwd" name="userPwd" value="" />
			                <div class="form-group">
			                   	<button type="button" id="btnUpdate" class="btn btn-primary">수정</button>
		                   	</div>
			            </form>
		            </div>
				</div>
			</div>
		</section>				
	</section>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>

<script type="text/javascript" src="/resources/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/resources/js/active.js"></script>
<script type="text/javascript" src="/resources/js/popper.min.js"></script>
</body>
</html>
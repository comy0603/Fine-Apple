<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<link rel="stylesheet" href="/resources/css/style.css?after" type="text/css">
<link rel="stylesheet" href="/resources/css/login.css" type="text/css">

<script type="text/javascript">
$(document).ready(function() {
	
	$("#userId").focus();
	
	$("#userId").on("keypress", function(e){
		
		if(e.which == 13)
		{	
			fn_loginCheck();
		}
		
	});
	
	$("#userPwd").on("keypress", function(e){
		
		if(e.which == 13)
		{	
			fn_loginCheck();
		}
		
	});
		
	$("#btnLogin").on("click", function() {
		
		fn_loginCheck();
		
	});
	
	$("#btnReg").on("click", function() {
		location.href = "/user/regForm";
	});
	
	
});

function fn_loginCheck()
{
	if($.trim($("#userId").val()).length <= 0)
	{
		alert("아이디를 입력하세요.");
		$("#userId").focus();
		return;
	}
	
	if($.trim($("#userPwd").val()).length <= 0)
	{
		alert("비밀번호를 입력하세요.");
		$("#userPwd").focus();
		return;
	}
	
	$.ajax({
		type : "POST",
		url : "/user/login",
		data : {
			userId: $("#userId").val(),
			userPwd: $("#userPwd").val() 
		},
		datatype : "JSON",
		beforeSend : function(xhr){
            xhr.setRequestHeader("AJAX", "true");
        },
		success : function(response) {
			
			if(!icia.common.isEmpty(response))
			{
				icia.common.log(response);
				
				// var data = JSON.parse(obj);
				var code = icia.common.objectValue(response, "code", -500);				
				
				if(code == 2)
				{
					alert("관리자님 어서오세요 !");
					location.href = "/admin/admin";
				}
				else
				{
					if(code == 0)
					{			
						location.href = "/index";

					}					
					else if(code == -1)
					{
						alert("비밀번호가 올바르지 않습니다.");
						$("#userPwd").focus();
					}
					else if(code == 404)
					{
						alert("아이디와 일치하는 사용자 정보가 없습니다.");
						$("#userId").focus();
					}
					else if(code == 400)
					{
						alert("파라미터 값이 올바르지 않습니다.");
						$("#userId").focus();
					}
					else
					{
						alert("오류가 발생하였습니다.");
						$("#userId").focus();
					}	
				}	
			}
			else
			{
				alert("오류가 발생하였습니다.");
				$("#userId").focus();
			}
		},
		error : function(xhr, status, error) 
		{
			icia.common.error(error);
		}
	});
}
</script>
<body>
<%@ include file="/WEB-INF/views/include/header.jsp" %>

<!--  로그인 박스 -->
<section class="section-padding-50">

	<section class="section-padding-100">
		<div class="form">
			<div class="form-toggle"></div>
			<div class="form-panel one">
				<div class="form-header" >
               		<h1 align="center">로그인</h1>
            	</div>
            	<div class="col-12">      
	            	<div class="form-content">
	              		<div class="form-group">
	                  		<label for="userId">아이디</label>
	                  		<input type="text" id="userId" name="userId" />
	               		</div>
	               		<div class="form-group">
	                		<label for="userPwd">패스워드</label>
	                  		<input type="password" id="userPwd" name="userPwd" />
	               		</div>
	               		<br />
	               		<div class="form-group">
	                  		<button type="button" id="btnLogin" style="width: 500px;">로그인</button>
	                  		<br />
	                  		<button type="button" id="btnReg" style="width:500px" type="submit">회원가입</button>
	                  		
                  		</div>                    	

					</div>
	        	</div>
       		</div>
  		</div>
	</section>   
</section>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
<input type="hidden" id="userManage" value="${fineUser.manager}" />


<script type="text/javascript" src="/resources/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/resources/js/active.js"></script>
<script type="text/javascript" src="/resources/js/popper.min.js"></script>
</body>

</html>
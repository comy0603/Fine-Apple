<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<link rel="stylesheet" href="/resources/css/style.css?after" type="text/css">
<script type="text/javascript">
$(document).ready(function() {
    
	$("#hiBbsTitle").focus();
	
	$("#btnWrite").on("click", function() {
		
		$("#btnWrite").prop("disabled", true); // 글쓰기 버튼 비활성화
		
		if($.trim($("#bbsTitle").val()).length <= 0)
		{
			alert("제목을 입력하세요.");
			$("#bbsTitle").val("");
			$("#bbsTitle").focus();
			
			$("#btnWrite").prop("disabled", false);  // 글쓰기 버튼 활성화
			
			return;
		}
		
		if($.trim($("#bbsContent").val()).length <= 0)
		{
			alert("내용을 입력하세요.");
			$("#bbsContent").val("");
			$("#bbsContent").focus();
			
			$("#btnWrite").prop("disabled", false); // 글쓰기 버튼 활성화
			
			return;
		}
		
		var form = $("#writeForm")[0];
		var formData = new FormData(form);
		
		$.ajax({
	        type: "POST",
	        enctype: 'multipart/form-data',
	        url: "/board/writeProc",
	        data: formData,
	        processData: false,
	        contentType: false,
	        cache: false,
	        timeout: 600000,
	        beforeSend : function(xhr) 
	        {
	            xhr.setRequestHeader("AJAX", "true");
	        },
	        success: function (response) 
	        {
	        	if(response.code == 0)
	        	{
	        		alert("게시물이 등록되었습니다.");
	        		location.href = "/board/list";
	        		/*
	        		document.bbsForm.action = "/board/list";
					document.bbsForm.submit();
	        		*/
	        	}
	        	else if(response.code == 400)
	        	{
	        		alert("파라미터 값이 올바르지 않습니다.");	
	        		$("#btnWrite").prop("disabled", false);  // 글쓰기 버튼 활성화
	        	}
	        	else
	        	{
	        		alert("게시물 등록중 오류가 발생하였습니다.");
	        		$("#btnWrite").prop("disabled", false);  // 글쓰기 버튼 활성화
	        	}
	        },
	        error: function (error) 
	        {
	        	icia.common.error(error);
	        	alert("게시물 등록중 오류가 발생하였습니다.");
        		$("#btnWrite").prop("disabled", false);  // 글쓰기 버튼 활성화
	        }
	    });
	});
	
	$("#btnList").on("click", function() {
		document.bbsForm.action = "/board/list";
		document.bbsForm.submit();
	});
});

function setThumbnail(event)
{ 
	var reader = new FileReader();
	reader.onload = function(event) {
	var img = document.createElement("img");
	img.setAttribute("src", event.target.result);
	document.querySelector("div#image_container").appendChild(img); };
	reader.readAsDataURL(event.target.files[0]); 
	
} 

</script>
</head>
<body>
<%@ include file="/WEB-INF/views/include/header.jsp" %>

<section class="section-padding-100">


	<section class="section-padding-100">
		<div class="container">
			<h1 align=center>게시물 쓰기</h1>
			<br><hr><br>
			<form name="writeForm" id="writeForm" method="post" enctype="multipart/form-data">
				<input type="text" name="userName" id="userName" maxlength="20" value="${fineUser.userName}" style="ime-mode:active;" class="form2-control2 mt-4 mb-2" placeholder="이름을 입력해주세요." readonly />
				<input type="text" name="userEmail" id="userEmail" maxlength="30" value="${fineUser.userEmail}" style="ime-mode:inactive;" class="form2-control2 mb-2" placeholder="이메일을 입력해주세요." readonly />
				<input type="password" name="password" id="password" maxlength="30" style="ime-mode:inactive;" class="form2-control2 mb-2" placeholder="비밀번호를 입력해주세요." required />
				<input type="text" name="bbsTitle" id="bbsTitle" maxlength="100" style="ime-mode:active;" class="form2-control2 mb-2" placeholder="제목을 입력해주세요." required />
				<div class="form-group">
					<textarea class="form2-control2" rows="10" name="bbsContent" id="bbsContent" style="ime-mode:active; height: 200px !important;" placeholder="내용을 입력해주세요" required></textarea>
				</div>
				<label class="input-file-button" for="input-file">파일 선택
               		<input type="file" style="display:none" name="fineNewsFile"  id="input-file" onchange="setThumbnail(event);" required /> 
                </label>
            	<div id="image_container"></div>
				<div class="form-group row">
					<div class="col-sm-12" align="right">
						<button type="button" id="btnWrite" class="btn btn-primary" title="저장">저장</button>
						<button type="button" id="btnList" class="btn btn-secondary" title="리스트">리스트</button>
					</div>
				</div>
			</form>
			<form name="bbsForm" id="bbsForm" method="post">
				<input type="hidden" name="searchType" value="${searchType}" />
				<input type="hidden" name="searchValue" value="${searchValue}" />
				<input type="hidden" name="curPage" value="${curPage}" />
			</form>
		</div>
	</section>
</section>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>

<script type="text/javascript" src="/resources/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/resources/js/active.js"></script>
<script type="text/javascript" src="/resources/js/popper.min.js"></script>
</body>
</html>
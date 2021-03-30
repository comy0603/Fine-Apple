<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<link rel="stylesheet" href="/resources/css/style.css?after" type="text/css">

<script type="text/javascript">
$(document).ready(function() {
<c:choose>
	<c:when test="${empty fineBoard}">
	
	alert("답변할 게시물이 존재하지 않습니다.");
	location.href = "/board/list";
	
	</c:when>
	<c:otherwise>
	
	$("#bbsTitle").focus();
	
	$("#btnReply").on("click", function() {
		
		$("#btnReply").prop("disabled", true);  // 답변 버튼 비활성화
		
		if($.trim($("#bbsTitle").val()).length <= 0)
		{
			alert("제목을 입력하세요.");
			$("#bbsTitle").val("");
			$("#bbsTitle").focus();
			return;
		}
		
		if($.trim($("#bbsContent").val()).length <= 0)
		{
			alert("내용을 입력하세요.");
			$("#bbsContent").val("");
			$("#bbsContent").focus();
			return;
		}
		
		var form = $("#replyForm")[0];
		var formData = new FormData(form);
		
		$.ajax({
	        type: "POST",
	        enctype: 'multipart/form-data',
	        url: "/board/replyProc",
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
	        		alert("답변이 완료되었습니다.");
	        		location.href = "/board/list";
	        	}
	        	else if(response.code == 400)
	        	{
	        		alert("파라미터 값이 올바르지 않습니다.");	
	        		$("#btnReply").prop("disabled", false);  // 수정 버튼 활성화
	        	}
	        	else if(response.code == 404)
	        	{
	        		alert("게시물을 찾을수 없습니다.");
	        		location.href = "/board/list";
	        	}
	        	else
	        	{
	        		alert("게시물 답변중 오류가 발생하였습니다.");
	        		$("#btnReply").prop("disabled", false);  // 수정 버튼 활성화
	        	}
	        },
	        error: function (error) 
	        {
	        	icia.common.error(error);
	        	alert("게시물 답변중 오류가 발생하였습니다.");
        		$("#btnReply").prop("disabled", false);  // 수정 버튼 활성화
	        }
	    });
	});
	
	$("#btnList").on("click", function() {
		document.bbsForm.action = "/board/list";
		document.bbsForm.submit();
	});
	</c:otherwise>
</c:choose>	
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
<c:if test="${!empty fineBoard}">
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<section class="section-padding-100">
	<section class="section-padding-100">
		<div class="container">
			<h1 align=center>게시물 답변</h1>
			<br><hr><br>
			<form name="replyForm" id="replyForm" method="post" enctype="multipart/form-data">
				<input type="text" name="userName" id="userName" maxlength="20" value="${fineUser.userName}" style="ime-mode:active;" class="form2-control2 mt-4 mb-2" placeholder="이름을 입력해주세요." readonly />
				<input type="text" name="userEmail" id="userEmail" maxlength="30" value="${fineUser.userEmail}"  style="ime-mode:inactive;" class="form2-control2 mb-2" placeholder="이메일을 입력해주세요." readonly />
				<input type="text" name="bbsTitle" id="bbsTitle" maxlength="100" style="ime-mode:active;" value="" class="form2-control2 mb-2" placeholder="제목을 입력해주세요." required />
				<div class="form-group">
					<textarea class="form2-control2" rows="10" name="bbsContent" id="bbsContent" style="ime-mode:active; height: 200px !important;" placeholder="내용을 입력해주세요" required></textarea>
				</div>
				<label class="input-file-button" for="input-file">File selection
					<input type="file" style="display:none" name="fineNewsFile"  id="input-file" onchange="setThumbnail(event);" required /> 
           		</label>
				<input type="hidden" name="bbsSeq" value="${fineBoard.bbsSeq}" />
				<input type="hidden" name="searchType" value="${searchType}" />
				<input type="hidden" name="searchValue" value="${searchValue}" />
				<input type="hidden" name="curPage" value="${curPage}" />
			</form>
			<div style="text-align:right;">
				<button type="button" id="btnReply" class="btn btn-primary" title="답변">답변</button>
				<button type="button" id="btnList" class="btn btn-secondary" title="리스트">리스트</button>
			</div>
		</div>
	</section>
</section>
<form name="bbsForm" id="bbsForm" method="post">
	<input type="hidden" name="bbsSeq" value="${fineBoard.bbsSeq}" />
	<input type="hidden" name="searchType" value="${searchType}" />
	<input type="hidden" name="searchValue" value="${searchValue}" />
	<input type="hidden" name="curPage" value="${curPage}" />
</form>
</c:if>

<%@ include file="/WEB-INF/views/include/footer.jsp" %>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<%
   // 개행문자 값을 저장한다.
   // 개행문자 값을 newLine에 저장해서 JSTL에서 쓴다는 것
   pageContext.setAttribute("newLine", "\n");
%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<link rel="stylesheet" href="/resources/css/style.css?after" type="text/css">

<script type="text/javascript">
$(document).ready(function() {
<c:choose>
   <c:when test="${empty fineNews}">
   alert("조회하신 게시물이 존재하지 않습니다.");
   
   
   document.bbsForm.action = "/news/list";
   document.bbsForm.submit();
   </c:when>
   <c:otherwise>
   
   $("#btnList").on("click", function() {
      document.bbsForm.action = "/news/list";
      document.bbsForm.submit();
   });
   

   
      <c:if test="${boardMe eq 'Y'}">
   $("#btnUpdate").on("click", function() {
      document.bbsForm.action = "/news/newsUpdate";
      document.bbsForm.submit();
   });
   
   $("#btnDelete").on("click", function(){
      if(confirm("게시물을 삭제 하시겠습니까?") == true)
      {
         $.ajax({
            type : "POST",
            url : "/news/delete",
            data : {
               bbsSeq : <c:out value="${fineNews.bbsSeq}" />
            },
            datatype : "JSON",
            beforeSend : function(xhr){
                  xhr.setRequestHeader("AJAX", "true");
              },
            success : function(response) {
               // var data = JSON.parse(obj);

               if(response.code == 0)
               {
                  alert("게시물이 삭제되었습니다.");
                  location.href = "/news/list";
               }
               else if(response.code == 400)
               {
                  alert("파라미터 값이 올바르지 않습니다.");
               }
               else if(response.code == 404)
               {
                  alert("게시물을 찾을수 없습니다.");
                  location.href = "/news/list";
               }
               else
               {
                  alert("게시물이 삭제중 오류가 발생하였습니다.");
               }   
            },
            complete : function(data) 
            {
               // 응답이 종료되면 실행, 잘 사용하지않는다
               icia.common.log(data);
            },
            error : function(xhr, status, error) 
            {
               icia.common.error(error);
            }
         });
      }
   });
      </c:if>
   </c:otherwise>
</c:choose>   
});
</script>
</head>
<body>
<c:if test="${!empty fineNews}">
	<%@ include file="/WEB-INF/views/include/header.jsp" %>
	
	<section class="section-padding-100">
		<section class="section-padding-100">
			<div class="container">
				<h1 align=center>게시물 보기</h1>
				<br><hr><br>
				<div class="row" style="margin-right:0; margin-left:0;">
					<table class="table">
						<thead>
							<tr style="background-color: #a9d4ff;" class="table-active">
								<th scope="col" style="width:60%">
									<c:out value="${fineNews.bbsTitle}" /><br/>
									<c:out value="${fineNews.userName}" />&nbsp;&nbsp;&nbsp;
									<a href="mailto:${fineNews.userEmail}" style="color:#828282;">${fineNews.userEmail}</a>
								</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>
									<ul>
										<li><img src="/resources/upload/${fineNews.fileName}" /></li>
										<li style="padding: 40px 0 0 0;"><pre><font size="6em"><c:out value="${fineNews.bbsContent}" /></font></pre></li>
									</ul>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div style="text-align:right;">
					<button type="button" id="btnList" class="btn btn-secondary">리스트</button>
					<c:if test="${boardMe eq 'Y'}">
					<button type="button" id="btnUpdate" class="btn btn-secondary">수정</button>
					<button type="button" id="btnDelete" class="btn btn-secondary">삭제</button>
					</c:if>
				</div>
			</div>
		</section>
	</section>
</c:if>

<%@ include file="/WEB-INF/views/include/footer.jsp" %>

<form name="bbsForm" id="bbsForm" method="post">
   <input type="hidden" name="bbsSeq" value="${bbsSeq}" />
   <input type="hidden" name="searchType" value="${searchType}" />
   <input type="hidden" name="searchValue" value="${searchValue}" />
   <input type="hidden" name="curPage" value="${curPage}" />
</form>

<script type="text/javascript" src="/resources/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/resources/js/active.js"></script>
<script type="text/javascript" src="/resources/js/popper.min.js"></script>
</body>
</html>
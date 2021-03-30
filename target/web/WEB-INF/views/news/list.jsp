<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %> 
<link rel="stylesheet" href="/resources/css/style.css?after" type="text/css">
<script type="text/javascript">
$(document).ready(function() {
    
	$("#btnWrite").on("click", function() {
		
		document.bbsForm.bbsSeq.value = "";
		document.bbsForm.action = "/news/newsWrite";
		document.bbsForm.submit();
		
	});
	
	$("#btnSearch").on("click", function() {
		
		document.bbsForm.bbsSeq.value = "";
		document.bbsForm.searchType.value = $("#_searchType").val();
		document.bbsForm.searchValue.value = $("#_searchValue").val();
		document.bbsForm.curPage.value = "1";
		document.bbsForm.action = "/news/list";
		document.bbsForm.submit();
		
	});
});

function fn_view(bbsSeq)
{
	document.bbsForm.bbsSeq.value = bbsSeq;
	document.bbsForm.action = "/news/view";
	document.bbsForm.submit();
}

function fn_list(curPage)
{
	document.bbsForm.bbsSeq.value = "";
	document.bbsForm.curPage.value = curPage;
	document.bbsForm.action = "/news/list";
	document.bbsForm.submit();	
}
</script>
</head>
<body>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
    <section class="breadcumb-area bg-img gradient-background-overlay" style="background-image: url(/resources/img/bg-img/iotpage.jpg);">
        <div class="container h-100">
            <div class="row h-100 align-items-center">
                <div class="col-12">
                    <div class="breadcumb-content">
                        <h3 class="breadcumb-title">Information & News</h3>
                    </div>
                </div>
            </div>
        </div>
    </section>
	<section class="section-padding-50">
		<div class="container">
			<div class="d-flex" style="padding: 0 0 13px 0;">
		    	<div style="width:50%;"></div>
				<div class="ml-auto input-group" style="width:50%;">
				   <select name="_searchType" id="_searchType" class="custom-select" style="width:auto;">
				      <option value="">조회 항목</option>
				      <option value="1" <c:if test="${searchType eq '1'}">selected</c:if>>작성자</option> <%-- if절이 참일때 예를들어 selected: 장동건이면 조회누르고 페이지가 바껴도 조회값은 장동건 그대로 --%>
				      <option value="2" <c:if test="${searchType eq '2'}">selected</c:if>>제목</option><%--  --%>
				      <option value="3" <c:if test="${searchType eq '3'}">selected</c:if>>내용</option>
				   </select>
				   <input type="text" name="_searchValue" id="_searchValue" value="${searchValue}" class="form-control mx-1" maxlength="20" style="width:auto;ime-mode:active;" placeholder="조회값을 입력하세요." />
				   <button type="button" id="btnSearch" class="btn btn-secondary mb-3 mx-1">조회</button>
				</div>
			</div>
			<table class="table table-hover" style="margin: auto;">
				<thead><%--테이블 헤드 --%>
					<tr style="background-color: #4da6f5a1;">
						<th scope="col" class="text-center" style="width:10%">번호</th>
						<th scope="col" class="text-center" style="width:20%"></th>
						<th scope="col" class="text-center" style="width:45%">제목</th>
						<th scope="col" class="text-center" style="width:10%">작성자</th>
						<th scope="col" class="text-center" style="width:15%">날짜</th>
					</tr>
				</thead>
				<tbody><%-- 테이블 바디(내용보여줌) --%>
					<c:if test="${!empty list}">	
						<c:forEach var="fineNews" items="${list}" varStatus="status">
							<tr>
								<td class="text-center">${fineNews.bbsSeq}</td>
								<td class="text-center"><img src="/resources/upload/${fineNews.fileName}" style="height: 100px"/></td>
								<td>
									<a href="javascript:void(0)" onclick="fn_view(${fineNews.bbsSeq})">
										<c:out value="${fineNews.bbsTitle}" />					
									</a>
								</td><%--제목누르면 상세 페이지로 이동 --%>
								<td class="text-center"><c:out value="${fineNews.userName}" /></td>
								<td class="text-center">${fineNews.regDate}</td>
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
		
		<%-- paging(페이지 기능) --%>
		<nav>
			<ul class="pagination justify-content-center">
				<c:if test="${!empty paging}">
					<c:if test="${paging.prevBlockPage gt 0 }">
						<li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="fn_list(${paging.prevBlockPage})">이전</a></li>
					</c:if>    
					<c:forEach var="i" begin="${paging.startPage}" end="${paging.endPage}">
						<c:choose>
							<c:when test="${i ne curPage}">    
		            			<li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="fn_list(${i})">${i}</a></li>               
							</c:when>
							<c:otherwise>
								<li class="page-item active"><a class="page-link" href="javascript:void(0)" style="cursor:default;">${i}</a></li>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					<c:if test="${paging.nextBlockPage gt 0}">
						<li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="fn_list(${paging.nextBlockPage})">다음</a></li>
					</c:if>
				</c:if>
			</ul>
		</nav>
		
		<div style="text-align:right;">
			<c:if test="${user.manager eq 'Y'}">     
			<button type="button" id="btnWrite" class="btn btn-secondary mb-3">글쓰기</button>
			</c:if>
		</div>
		<%-- post로 넘길려면 form태그를 써야한다 --%>
			<form name="bbsForm" id="bbsForm" method="post">
				<input type="hidden" name="bbsSeq" value="" />
				<input type="hidden" name="searchType" value="${searchType}" /><%-- searchType조회항목 --%>
				<input type="hidden" name="searchValue" value="${searchValue}" /><%-- searchValue입력값 --%>
				<input type="hidden" name="curPage" value="${curPage}" />
			</form>
		</div>
	</section>
	<div style="padding: 200px 0 0 0;"></div>
	
<%@ include file="/WEB-INF/views/include/footer.jsp" %>

<script type="text/javascript" src="/resources/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/resources/js/active.js"></script>
<script type="text/javascript" src="/resources/js/popper.min.js"></script>

</body>
</html>
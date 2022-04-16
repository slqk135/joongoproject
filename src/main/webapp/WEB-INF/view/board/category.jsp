<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- css  -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/asset/css/common.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/asset/css/sub.css" />
<style>
	#header {position: fixed;}
	.table_wrap{width:auto;}
</style>
<script type="text/javascript"src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		$('#btnCreate').click(function(){
			location.href="boardCreate";
		});
	});
</script>
<script>
var frm = document.frm;
	$(document).ready(function(){
		$('#btnSearch').click(function(){
			if($('#Search').val() == ""){
				alert("검색할 내용을 입력해주세요.");
				frm.Search.focus();
				return;
			}
			else{
				var Search = $('#Search').val();
				location.href="/board/categoryMuti?boardTitle="+Search;
			}
			
		});
	});
</script>
</head>
<body class="category">
	<%@ include file="/WEB-INF/view/resources/include/skipNav.jsp"%>
	<div id="wrap">
		<%@ include file="/WEB-INF/view/resources/include/header.jsp"%>
		<div id="container">
			<!-- 검색창 -->
			<div class="joonmain">
				<div class="inner">
					<div class="search">
						<dl>						
							<dt>
								<span>중고나라</span>
							</dt>
							<dd>찾는 물건을 검색해주세요.</dd>	
							<dd class="form_wrap">
								<form action="Search" method="post" name="frm">
									<!-- 주소 작업  --> 
									<input type="text" id="Search" name="Search" placeholder="통합 검색" />
								</form>
								<button type="button" class="addrBtn" id="btnSearch" >검색</button>
							</dd>
						</dl>
					</div>
				</div>
			</div>
			<!-- //검색창 -->
			<!-- 상단카테고리 -->
			<%@ include file="/WEB-INF/view/resources/include/top_category.jsp"%>
			<!-- //상단카테고리 -->
			<!-- 업체 리스트 -->
			<div class="rightInfo">
				<div class="inner">
					<div>
					<c:if test="${not empty authInfo}">
					<input type="button" id="btnCreate" name="btnCreate" value="글작성" style="float:right;"/>
					</c:if>
						<table>
							<tr>
								<td colspan="2" style="width:550pt;">게시글 제목</td>
								<td style="width:60pt" >작성 일자</td>
								<td>작성자</td>
								<td>조회수</td>								
							</tr>
							<c:if test="${not empty Blist }">
							<!--for문 구간 -->
							<c:forEach items="${Blist}" var="dto" varStatus="cnt">
								<tr>
									<td style="text-align:left;border:0;width:50pt; font-size : 10pt;">${dto.boardNum }</td>
									<td style="border:0; text-align:left;">
										<a href="boardContent?boardNum=${dto.boardNum}">${dto.boardTitle }</a>
									</td>
									<td style="border:0;width:50pt">${dto.boardDate }</td>
									<td style = "border:0;width:50pt">${dto.memId }</td>
									<td style="border:0;width:10pt">${dto.boardCount }</td>
								</tr>									
							</c:forEach>
							</c:if>
							<c:if test="${empty Blist }">
							<table>
							<tbody>
								<tr>
									<td style = "border:0; width:50pt;">
										<span>등록된 게시물이 없습니다</span>
									</td>
								</tr>
							</tbody>
							</table>
						</c:if>																
						</table>				
					</div>
				</div>
				<table>
				<tbody>
					<tr>
						<td colspan="8" style="border:0">
							<% String Category = request.getParameter("category"); %>
							<c:if test="${page <= 1 }">[이전]</c:if>
							<c:if test="${page > 1 }">
							<a href="${pageUrl }?page=${page -1 }">[이전]</a>
							</c:if>
							<c:set var="currentPageNo" value="1"/>
							<c:forEach begin="${startPage }" end="${endPage }" var="i" step="1">
							<c:choose>
							<c:when test="${i == page }">
							<a href="${pageUrl }?category=<%=Category %>&page=${i }">[${i }]</a> &nbsp;
							</c:when>
							<c:otherwise>
							<a href="${pageUrl }?category=<%=Category %>&page=${i }">${i }</a> &nbsp;
							</c:otherwise>
							</c:choose>
							</c:forEach>
							<c:if test="${page >= maxPage }">[다음]</c:if>
							<c:if test="${page < maxPage }">
							<a href="${pageUrl }?page=${page + 1 }">[다음]</a>
							</c:if>
						</td>
					</tr>
				</tbody>
			</table>
			</div>
		</div>
	</div>
</body>
</html>
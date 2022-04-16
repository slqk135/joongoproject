<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/asset/css/common.css" />
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/asset/css/sub.css" />
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.form/4.3.0/jquery.form.js"></script>
<script type="text/javascript"src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
<style>
	.star_rating {font-size:0; letter-spacing:-4px;}
	.star_rating span {
	    font-size:22px;
	    letter-spacing:0;
	    display:inline-block;
	    margin-left:5px;
	    color:#ccc;
	    text-decoration:none;
	}
	.star_rating span:first-child {margin-left:0;}
	.star_rating span.on {color:#777;}
</style>
</head>
<body class="foodsReview sub">
	<%@ include file="/WEB-INF/view/resources/include/skipNav.jsp"%>
	<div id="wrap">
		<%@ include file="/WEB-INF/view/resources/include/header.jsp"%>
		<div class="container">
			<div class="review">
				<div class="content">
					<%@ include file="/WEB-INF/view/resources/include/leftMenu.jsp"%>
					<div class="rightInfo">
						<div class="table_wrap">
							<h2 class="tit">나의 상품 확인</h2>
							<c:if test="${not empty board}">
									<table>
										<tbody>
											<tr>
												<td>게시글 번호</td>
												<td>게시글 제목</td>
												<td>작성 일자</td>
												<td>조회수</td>
											</tr>
											<!--for문 구간 -->
											<c:forEach items="${board}" var="dto" varStatus="cnt">
												<tr>
												<td>${dto.boardNum }</td>
												<td>${dto.boardTitle }</td>
												<td>${dto.boardDate }</td>
												<td>${dto.boardCount }</td>
											</tr>
											</c:forEach>
																				
										</tbody>										
									</table>
								<br />
							</c:if>
						</div>
						<!--  if문구간 -->
						
						<c:if test="${empty board }">
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
						
						
						
						<table>
							<tbody>
								<tr>
									<td colspan="8" style="border:0">
										<c:if test="${page <= 1 }">[이전]</c:if>
										<c:if test="${page > 1 }">
										<a href="${pageUrl }?page=${page -1 }">[이전]</a>
										</c:if>
										<c:set var="currentPageNo" value="1"/>
										<c:forEach begin="${startPage }" end="${endPage }" var="i" step="1">
										<c:choose>
										<c:when test="${i == page }">
										<a href="${pageUrl }?page=${i }">[${i }]</a> &nbsp;
										</c:when>
										<c:otherwise>
										<a href="${pageUrl }?page=${i }">${i }</a> &nbsp;
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
		</div>
		<%@ include file="/WEB-INF/view/resources/include/footer.jsp"%>
	</div>
</body>
</html>
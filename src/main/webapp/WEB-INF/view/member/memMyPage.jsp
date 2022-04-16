<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- css  -->
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/asset/css/common.css" />
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/asset/css/sub.css" />
<title>Insert title here</title>
<style>
.leftMypage {height: 980px;}
</style>
</head>
<body class="myPageMain sub">
	<%@ include file="/WEB-INF/view/resources/include/skipNav.jsp"%>
	<div id="wrap">
		<%@ include file="/WEB-INF/view/resources/include/header.jsp"%>
		<div class="container">
			<div class="content">
				<%@ include file="/WEB-INF/view/resources/include/leftMenu.jsp"%>
				<div class="rightInfo">
					<h2 class="right_tit">마이페이지</h2>
					<div class="rightContet">
						<div class="event_area">
							<h3 class="eventTit">현재 결제중인 상품</h3>
							<table>
								<tr>
									<td style="width:20pt;">
										결제번호
									</td>
									<td>
										게시글
									</td>
									<td style="width:40pt;">
										결제금액
									</td>
									<td style="width:30pt;">
										결제일
									</td>
									<td style="width:40pt;">
										구매자
									</td>
									<td style ="width:30pt;">
										결제상태
									</td>
								</tr>
							<c:if test="${not empty Mlist }">
									<c:forEach items="${Mlist }" var="dto" varStatus="cnt"> 
										<tr>
											<td style="width:20pt;">
												${dto.paymentNum }
											</td>
											<td>
												${dto.boardTitle }
											</td>
											<td style="width:40pt;">
												${dto.goodsPrice }
											</td>
											<td style="width:30pt;">
												${dto.orderDate }
											</td>
											<td style="width:40pt;">
												${dto.orderMemId }
											</td>
											<td style ="width:30pt;">
												${dto.orderState }
											</td>
										</tr>
									</c:forEach>
							</c:if>
							</table>
						</div>
						<c:if test="${empty Mlist }">
							<table>
							<tbody>
								<tr>
									<td style = "border:0; width:50pt;">
										<span>결제 중인 상품이 없습니다</span>
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
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- css  -->
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/asset/css/common.css" />
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/asset/css/sub.css" />
<title>Insert title here</title>
<style>
.leftMypage {height: 809px;}
</style>
<script type="text/javascript"src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src="https://service.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script>
</script>
</head>
<body class="memDetail sub">
	<%@ include file="/WEB-INF/view/resources/include/skipNav.jsp"%>
	<div class="wrap">
		<%@ include file="/WEB-INF/view/resources/include/header.jsp"%>
		<div id="container">
			<div class="content">
				<%@ include file="/WEB-INF/view/resources/include/leftMenu.jsp"%>
				<div class="rightInfo">
					<div class="table_wrap">
						<div class="inner">
							<h2 class="tit">결제내역</h2>

								<table>
									<tbody>
										<tr>
											<td style="width:20pt;">
												결제번호
											</td>
											<td>
												결제내용
											</td>
											<td style="width:50pt;">
												결제금액
											</td>
											<td style="width:20pt;">
												결제상태
											</td>
										</tr>
										<c:forEach items="${Plist}" var="dto" varStatus="cnt">
											<tr>
											<td style="width:20pt;">
												${dto.paymentNum }
											</td>
											<td>
												${dto.paymentContent }
											</td>
											<td style="width:50pt;">
												${dto.paymentPrice }원
											</td>
											<td style="width:20pt;">
												${dto.paymentState }
											</td>
										</tr>
										</c:forEach>
									</tbody>
								</table>

							<c:if test="${empty Plist }">
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
		</div>
		<%@ include file="/WEB-INF/view/resources/include/footer.jsp"%>
	</div>
</body>
</html>
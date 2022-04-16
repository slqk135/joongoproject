<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
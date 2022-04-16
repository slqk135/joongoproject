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
<script>
$(document).ready(function(){
	
	$(btnClear).click(function(){
		
		if (confirm("정말 삭제하시겠습니까?") == true){
			location.href="boardClear?boardNum=${bCon.boardNum}";
			alert("삭제가 완료 되었습니다.");

		 }else{
		     return false;
		 }
		
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
<script>
	$(document).ready(function(){
		$('#txtQuestion').hide();
		$('#btnQuestion').click(function(){
			status = $('#txtQuestion').css("display");
			if(status == "none"){
				$('#txtQuestion').attr('style', "display:block;");
			}
			else{
				$('#txtQuestion').attr('style', "display:none;"); 
			}
		});
		
		$('#AddQuestion').click(function(){
			var question = $('#createContent').val();
			var boardNum = ${bCon.boardNum};
				$.ajax({
					type : 'POST',
					url : "AddQeustion?boardNum=${bCon.boardNum}",
					data : {"question" : question},
					datatype : "text",
					success : function(){
						alert("댓글작성완료");
						document.location.reload();
					}
				});
		});
		
	});
</script>
<script type="text/javascript">
	function Conclear(id){
		if (confirm("정말 삭제하시겠습니까?") == true){
			$.ajax({
				type:"POST",
				url : "QuestionCle?QuestionNum="+id,
				cache : false,
				success : function(){
					alert("댓글 삭제 완료");
					document.location.reload();
				}
			});
		}else{
			return false;
		}
		
	}
	
	function BoardOnclick(id){
		if(confirm("수정하시겠습니까?") == true){
			location.href="boardMo?boardNum="+id;
		}else{
			return false;
		}
		
	}
	
	function btnOrder(){
		if(confirm("현재 게시물의 상품을 구매하시겠습니까?") == true){
			var userMoney = ${authInfo.memBalance}
			var boardPrice = ${bCon.goodsPrice}

			if( boardPrice > userMoney){
				alert("현재 잔액이 상품금액보다 적습니다. 충전 후 이용해주세요");
				return false;
			}
			else{
				var price = ${bCon.goodsPrice}
				$.ajax({
					type : "POST",
					url : "PaySuccess",
					data : {"price" : price},
					datatype : "text",
					success : function(){
						var content = "상품 구매";
						$.ajax({
							type : "POST",
							url : "/member/paymentInsert?memId=${authInfo.memId}",
							data : {"price" : price , "content" : content },
							success : function(){
								
								$.ajax({
									type : "POST",
									url : "/member/orderpayment?memId=${bCon.memId}&boardNum=${bCon.boardNum}",
									data : {"price" : price},
									success : function(){
										alert("결제가 완료되었습니다.");
										document.location.reload();
									}
								});
							}
						});
				
						
					}
				});
			}
		}else{
			return false;
		}
	}

</script>
<script type="text/javascript">
	$(document).ready(function(){
		function trim(str) {
		    return str.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
		}
		 
		String.prototype.trim = function() {
		    return this.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
		}
		 
		// textarea 내용을 문장별 <p> 태그 지정하여 HTML로 반환
		function getTextareaHTML(content) {
		    return "</p><p>"+ document.getElementById(content).value.trim().replace(/\n\r?/g,"</p><p>") +"</p>";
		}
		 
		document.Write( getTextareaHTML("content") );
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
							<c:set var = "auth" value ="${authInfo.memId }"/>
							<c:set var = "id" value ="${bCon.memId }"/>
							<c:if test="${auth eq id}">
								<input type ="button" value="삭제" id="btnClear" name="btnClear" style="Width:30pt;float:right;"/>
								<input type ="button" value="수정하기" id="${bCon.boardNum }" name="btnMo" onclick="BoardOnclick(this.id)" style="Width:50pt;float:right;"/>
							</c:if>
						</c:if>
						<table style = "border:1pt solid black; border-color:#EAEAEA; table-layout: fixed;">
							<tr>
								<td colspan="2" style="width:550pt; border:0; text-align:left;"><b style="font-size:20pt;">${bCon.boardTitle }</b></td>								
							</tr>
							<tr>
								<td colspan="2" style="border:0; font-size:10pt; text-align:left;">${bCon.memId } 회원님</td>
							</tr>
							<tr style="border-bottom:1pt solid; border-color:#EAEAEA; border-width:80%;">
								<td colspan="2" style="border:0; font-size:10pt; text-align:left;">${bCon.boardDate } 조회 ${bCon.boardCount }</td>
							</tr>
							<tr>
								<td colspan="2" style="border:0; font-size:10pt; text-align:left;"></td>
							</tr>
							<tr>
								<td style="border-color:#EAEAEA;" rowspan="6">
									<img src="<%=request.getContextPath() %>/resources/asset/image/reviewImg/${bCon.goodsImg }" />
								</td>
								<td style="border-color:#EAEAEA; border-bottom:0px; text-align:left;">${bCon.goodsName }</td>
							</tr>
							<tr>
								<td style=" border-color:#EAEAEA;text-align:left;"><b>${bCon.goodsPrice }원</b></td>
							</tr>
							<tr>
								<c:set var = "state" value="${bCon.goodsState }"/>
								<c:choose>
								
								<c:when test="${state eq 'old'}">
									<c:set var = "boardState" value ="중고제품"/>
								</c:when>
								<c:otherwise>
									<c:set var = "boardState" value ="미개봉 제품"/>
								</c:otherwise>
								</c:choose>
								<td style=" border-color:#EAEAEA;text-align:left;">상품 상태 : ${boardState }</td>
							</tr>
							<tr>
							<c:set var = "Pay" value="${bCon.boardPay }"/>
							<c:choose>
							
							<c:when test="${Pay eq 'self'}">
								<c:set var = "boardPay" value ="직접결제"/>
							</c:when>
							<c:otherwise>
								<c:set var = "boardPay" value ="온라인결제"/>
							</c:otherwise>
							</c:choose>
								
								<td style=" border-color:#EAEAEA;text-align:left;">결제 방법 : ${boardPay }</td>
							</tr>
							<tr>
								<td style=" border-color:#EAEAEA;text-align:left;">판매자 : ${bCon.memEmail }</td>
							</tr>
							<tr>
								<td style=" border-color:#EAEAEA;text-align:left;">
									연락처 : ${bCon.memPhone }
								</td>
							</tr>
							<tr>
								<td colspan="2" style="border-color:#EAEAEA;">
									<img src="<%=request.getContextPath() %>/resources/asset/image/reviewImg/${bCon.goodsImg }" />
									<p id ="pdpContent">${bCon.boardContent }</p>
								</td>
							</tr>
							<tr>
								<td style=" border-color:#EAEAEA;" colspan="2">
									<a id="btnQuestion">댓글</a>
								</td>
							</tr>
							<tbody  id="txtQuestion" style=" border-color:#EAEAEA;">
							<c:set var = "id" value ="${bCon.memId }"/>
							<c:set var = "auth" value ="${authInfo.memId }"/>
							<c:forEach items="${qCon }" var="dto">
							<c:set var = "memid" value ="${dto.memId }"/>
							<tr>
								<c:choose>
									<c:when test="${auth eq id}">
										<td style="width:600pt; border-color:#EAEAEA;"><textarea id="viewContent" name="viewContent" style="width:863pt; height:50px; border-color:#EAEAEA;" readonly>${dto.boardQuestionContent }</textarea></td>
										<td>
											<input type="button" value="삭제" disabled="disabled"/>
										</td>
									</c:when>
									<c:when test="${auth eq memid}">
									<td style="width:600pt; border-color:#EAEAEA;"><textarea id="${dto.boardQuestionNum }" name="viewContent${dto.boardQuestionNum }" style="width:863pt; height:50px; border-color:#EAEAEA;" readonly>${dto.boardQuestionContent }</textarea></td>
										<td>
											<input type="button" id="${dto.boardQuestionNum }" name="Conclear" onclick="Conclear(this.id)" value="삭제"/>
										</td>
									</c:when>
									<c:otherwise>
										<td colspan="2" style="width:600pt; border-color:#EAEAEA;"><textarea id="viewContent" name="viewContent" style="width:863pt; height:50px; border-color:#EAEAEA;" readonly>${dto.boardQuestionContent }</textarea></td>
									</c:otherwise>
								</c:choose>
							</tr>
							
							</c:forEach>
							<c:choose>
								<c:when test="${not empty authInfo}">
								<tr>
									<td style="width:600pt; border-color:#EAEAEA;"><textarea id="createContent" name="createContent" style="width:863pt; height:50px; "></textarea></td>
									<td style=" border-color:#EAEAEA;"><input type="button" id="AddQuestion" value="등록하기"/></td>
								</tr>
								</c:when>
							
								<c:otherwise>
								<tr>
									<td style="width:600pt; border-color:#EAEAEA;"><textarea id="createContent" name="createContent" style="width:863pt; height:50px;" placeholder="로그인 후 등록 가능합니다." readonly></textarea></td>
									<td style=" border-color:#EAEAEA;"><input type="button" id="AddQuestion" value="등록하기" disabled="disabled"/></td>
								</tr>
								</c:otherwise>
							</c:choose>
							</tbody>
							<c:set var ="check" value="${bCon.boardState }"/>
							<c:choose>
							<c:when test="${check eq 'N'}">
								<c:if test="${not empty authInfo}">
									<c:set var ="aId" value="${authInfo.memId }"/>
									<c:set var ="bId" value="${bCon.memId }"/>
									<c:choose>
										<c:when test="${aId ne bId}">
											<tr>
												<td colspan="2" style="border:0;"><input type="button"  onclick="btnOrder()" value="구매하기" /></td>
											</tr>
										</c:when>
										<c:otherwise>
											<tr>
												<td colspan="2" style="border:0;"><input type="button" value="구매하기" disabled="disabled"/></td>
											</tr>
										</c:otherwise>
									</c:choose>
								</c:if>
								<c:if test="${empty authInfo}">
									<tr>
										<td colspan="2" style="border:0;"><input type="button" value="구매하기" disabled="disabled"/></td>
									</tr>
								</c:if>
							</c:when>
							<c:otherwise>
								<tr>
									<td colspan="2" style="border:0;"><input type="button" value="구매하기" disabled="disabled"/></td>
								</tr>
							</c:otherwise>	
							</c:choose>					
						</table>				
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
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
$(document).ready(function(){
	$('#check_module').click(function(){
		var IMP = window.IMP;
		IMP.init('imp61852976');
		IMP.request_pay({
			pg:'kakaopay',
			pay_method:'card',
			merchant_uid:'merchant_' + new Date().getTime(),
			name: '중고페이충전',
			amount : $('#Price').val(),
			buyer_name : '${Mdto.memName}',
			customer_uid : '${Mdto.memName}' + new Date().getTime(),
			buyer_email :'${Mdto.memEmail}',
			buyer_tel : '${Mdto.memPhone}',
			buyer_addr : '${Mdto.memAddress}',
		}, 
		function(rsp){
			if( rsp.success ){
				var msg = "결제가 완료되었습니다.";
				var price = $('#Price').val();
				var content = rsp.name;
				$.ajax({
					type : "POST",
					url : "paymentSuccess?memId=${Mdto.memId}",
					data : {"price" : price},
					success : function(){
						$.ajax({
							type : "POST",
							url : "paymentInsert?memId=${Mdto.memId}",
							data : {"price" : price , "content" : content },
							success : function(){
								
							}
						});
						document.location.reload();
					}
					
				});
			}else{
				var msg = "결제가 실패하였습니다.";
				msg += "에러내용 : " + rsp.error_msg;
			}
			alert(msg);
		});
	});
});
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
							<h2 class="tit">중고페이 충전</h2>
							<form action="#">
								<table>
									<colgroup>
										<col style="width: 50%" />
										<col style="width: 50%" />
									</colgroup>
									<tbody>
										<tr>
											<th>
												현재 잔액
											</th>
											<td>
												<input type="text" style="text-align:right;" value="${Mdto.memBalance } 원" readonly/>						
											</td>
										</tr>
										<tr>
											<th>
												충전 금액
											</th>
											<td>
												<input type="text" id="Price" style="text-align:right;"/>
											</td>
										</tr>
										<tr>
											<td colspan="2" style="border:0;">
												<input type="button" id="check_module" value="충전하기"/>
											</td>
										</tr>
									</tbody>
								</table>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
		<%@ include file="/WEB-INF/view/resources/include/footer.jsp"%>
	</div>
</body>
</html>
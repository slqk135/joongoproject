<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- css  -->
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/asset/css/common.css" />
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/asset/css/main.css" />
<script type="text/javascript"src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
<style>
.tit {padding-top: 0;}
.login_form .inner {padding: 200px 0;}
.login_form .table_wrap {margin-bottom: 100px;}
</style>
<script>
	function popUp(page){		
		var url = 'search/' + page;
		var width = '300';
	    var height = '150';
	    var left = Math.ceil(( window.screen.width - width )/2);
	    var top = Math.ceil(( window.screen.height - height )/2); 
	    window.open(url, 'popUp', 'width=' + width + ', height=' + height + ', left=' + left + ', top=' + top );
	}
	
</script>
<script type="text/javascript">
	$(document).ready(function(){
		var frm = document.frm;
		
		
		$('#btnLogin').click(function(){
			var userId = $('#memId').val();
			var userPw = $('#memPw').val();
			if(frm.memId.value && frm.memPw.value){
				$.ajax({
					type : 'POST',
					url : "memberCheck",
					data : {"userId" : userId, "userPw" : userPw},
					datatype : "text",
					success : function(cnt){
						if(cnt == 1){
							frm.submit();
						}else{
							alert("사용자 정보가 없습니다.");
						}
					},
					error : function(request,status,error){
						alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
					}
				});
			}else if(!frm.memPw.value){
				alert("비밀번호를 입력해주세요.");
				frm.memPw.focus();
				return;
			}else if(!frm.memId.value){
				alert("아이디를 입력해주세요.");
				frm.memId.focus();
				return;
			}
		
		});
		
	});
</script>

</head>
<body class="login_main">
	<%@ include file="/WEB-INF/view/resources/include/skipNav.jsp"%>
	<div id="wrap">
		<%@ include file="/WEB-INF/view/resources/include/header.jsp"%>
		<div class="container">
			<div class="login_form">
				<div class="inner">
					<div class="table_wrap">
						<h2 class="tit">로그인해주세요.</h2>
						<!-- 로그인 테이블 -->
						<form action="logIn" method="post" name="frm" modelAttribute="logInCommand">
							<table>
								<caption>로그인해주세요.</caption>
								<colgroup>
									<col style="width: 50%" />
									<col style="width: auto" />
								</colgroup>
								<tbody>
									<tr>
										<th>아이디</th>
										<td><input type="text" id="memId" name="memId"/>
									</tr>
									<tr>
										<th>비밀번호</th>
										<td><input type="password" id="memPw" name="memPw"/>
									</tr>
									<tr>
										<td colspan="2" class="last">
											<div class="checkbox">
												<ul>
													<li><a href="javascript:popUp('findId');" >아이디</a></li>
													<li><a href="javascript:popUp('findPw');">비밀번호 찾기</a></li>
												</ul>
											</div>
											<div class="rightLogin">
												<input type="button" value="로그인" id="btnLogin" name="btnLogin" />
											</div>
										</td>
									</tr>
								</tbody>
							</table>
						</form>
					</div>
				</div>
			</div>
		</div>
		<%@ include file="/WEB-INF/view/resources/include/footer.jsp"%>
	</div>
</body>
</html>
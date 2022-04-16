<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
	<%@ page import = "java.sql.*" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- css  -->
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/asset/css/common.css" />
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/asset/css/main.css" />
<title>Insert title here</title>
<!-- js -->
<script src="<%=request.getContextPath() %>/resources/asset/js/main.js"></script>
<script type="text/javascript"src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
<style>
.content {margin-bottom:100px;}
.content .inner {padding:100px 0;}
.content .tit {padding-top: 0;}
.last input {height: 50px; font-size: 16px; letter-spacing: -1.5px;}
</style>

<script type="text/javascript">
$(document).ready(function() {
	$('#btnJoin').click(function(){
		var frm = document.frm;
		var userPw = $('#memPw').val();
		var userPwCheck = $('#memPwCheck').val();
		
		if(userPw == userPwCheck){
			if(frm.memId.value && frm.memPw.value && frm.memPwCheck.value && frm.memName.value && frm.memIdCard && frm.memEmail.value && frm.memPhone.value && frm.memAddress.value){
				
				if(frm.btnCheck.disabled == false){
					alert("아이디 중복체크 해주세요.")
					return;
				}
				if(frm.btnNumCheck.disabled == false){
					alert("휴대폰 본인 인증 해주세요.");
					frm.btnNumCheck.focus();
					return;
				}
				frm.submit();
				alert("회원가입완료 되었습니다.");
				
			}else if(!frm.memId.value){
				alert("아이디를 입력해주세요");
				frm.memId.focus();
				return;
			}
			else if(!frm.memPw.value){
				alert("비밀번호를 입력해주세요");
				frm.memPw.focus();
				return;
			}
			else if(!frm.memPwCheck.value){
				alert("비밀번호확인을 입력해주세요");
				frm.memPwCheck.focus();
				return;
			}
			else if(!frm.memName.value){
				alert("이름을 입력해주세요");
				frm.memName.focus();
				return;
			}
			else if(!frm.memIdCard.value){
				alert("주민번호를 입력해주세요");
				frm.memIdCard.focus();
				return;
			}
			else if(!frm.memEmail.value){
				alert("이메일을 입력해주세요");
				frm.memEmail.focus();
				return;
			}
			else if(!frm.memPhone.value){
				alert("연락처를 입력해주세요");
				frm.memPhone.focus();
				return;
			}
			else if(!frm.memAddress.value){
				alert("주소를 입력해주세요");
				frm.memAddress.focus();
				return;
			}
		}else{
			alert("비밀번호가 틀립니다.");
			frm.memPwCheck.focus();
		}
		
		
	});
	
	// 아이디 중복 체크
	$('#btnCheck').click(function(){
		var userId = $('#memId').val();
		if(frm.memId.value){
			$.ajax({
				type : 'POST',
				url : "IdCheckService",
				data : {"userId" : userId},
				datatype : "text",
				success : function(cnt){
					if(cnt != 0){
						alert("중복된 아이디 입니다.");
						frm.memId.focus();
					}else{
						alert("사용 가능한 아이디입니다.");
						frm.btnCheck.disabled = "disabled";
					}
				},
				error : function(request,status,error){
					alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
			});
		}else{
			alert("아이디를 입력해주세요.");
			return;
		}
		
	});
});
	
</script>
<script
	src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	//본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
	function sample4_execDaumPostcode() {
		new daum.Postcode(
				{
					oncomplete : function(data) {
						// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
						// 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
						// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
						var roadAddr = data.roadAddress; // 도로명 주소 변수
						var extraRoadAddr = ''; // 참고 항목 변수
						// 법정동명이 있을 경우 추가한다. (법정리는 제외)
						// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
						if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
							extraRoadAddr += data.bname;
						}
						// 건물명이 있고, 공동주택일 경우 추가한다.
						if (data.buildingName !== '' && data.apartment === 'Y') {
							extraRoadAddr += (extraRoadAddr !== '' ? ', '
									+ data.buildingName : data.buildingName);
						}
						// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
						if (extraRoadAddr !== '') {
							extraRoadAddr = ' (' + extraRoadAddr + ')';
						}
						// 우편번호와 주소 정보를 해당 필드에 넣는다.
						document.getElementById('sample4_postcode').value = data.zonecode;
						document.getElementById("sample4_roadAddress").value = roadAddr;

						// 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
						if (roadAddr !== '') {
							document.getElementById("memAddress").value = extraRoadAddr;
						} else {
							document.getElementById("memAddress").value = '';
						}
						var guideTextBox = document.getElementById("guide");
						// 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
						if (data.autoRoadAddress) {
							var expRoadAddr = data.autoRoadAddress
									+ extraRoadAddr;
							guideTextBox.innerHTML = '(예상 도로명 주소 : '
									+ expRoadAddr + ')';
							guideTextBox.style.display = 'block';
						} else {
							guideTextBox.innerHTML = '';
							guideTextBox.style.display = 'none';
						}
					}
				}).open();
	}
</script>
<script type="text/javascript">
$(document).ready(function(){
	var code2 = "";
	$('#btnPhCheck').click(function(){
		alert("인증번호 발송이 완료되었습니다.\n휴대폰에서 인증번호 확인을 해주세요.");
		var phone = $('#memPhone').val();
		$.ajax({
			type : "GET",
			url: "member/phoneCheck?phone=" + phone,
			cache : false,
			success:function(data){
					code2 = data;
				
			}
		});
	});
	
	
	$('#btnNumCheck').click(function(){
		if($('#numCheck').val() == code2){
			alert("번호가 일치합니다.");
			frm.btnNumCheck.disabled = "disabled";
			frm.numCheck.disabled = "disabled";
			
		}
		else{
			alert("번호가 일치하지 않습니다.");
		}
	});
});
</script>

</head>
<body>
	<%@ include file="/WEB-INF/view/resources/include/skipNav.jsp"%>
	<div id="wrap">
		<%@ include file="/WEB-INF/view/resources/include/header.jsp"%>
		<div class="container">
			<div class="content">
				<div class="inner">
					<div class="table_wrap">
						<h2 class="tit">회원 가입</h2>
						<form action="member/memJoin" method="post" name="frm" modelAttribute="memberCommand">
							<table>
								<caption>회원 가입해주세요.</caption>
								<colgroup>
									<col style="width: 50%;" />
									<col style="width: 50%;" />
								</colgroup>
								<tbody>
									<tr>
										<th>
											<label for="memId"> 아이디 </label>
										</th>
										<td>
											<input type = "text" id="memId" name="memId"/>
											<input type ="button" id="btnCheck" name= "btnCheck" value ="중복체크" />
										</td>
									</tr>
									<tr>
										<th>
											<label for="memPw"> 비밀번호 </label>
										</th>
										<td>
											<input type = "password"  id="memPw" name="memPw"/>
										</td>
									</tr>
									<tr>
									<tr>
										<th>
											<label for="memPw"> 비밀번호확인 </label>
										</th>
										<td>
											<input type = "password"  id="memPwCheck" name="memPwCheck"/>
										</td>
									</tr>
									<tr>
										<th>
											<label for="memName">이름</label>
										</th>
										<td>
											<input type = "text"  id="memName" name="memName"/>
										</td>
									</tr>
									<tr>
										<th>
											<label for="memIdCard">주민번호</label>
										</th>
										<td>
											<input type = "text"  id="memIdCard" name="memIdCard"/>
										</td>
									</tr>
									<tr>
										<th>
											<label for="memEmail">이메일</label>
										</th>
										<td>
											<input type = "email"  id="memEmail" name="memEmail"/>
										</td>
										
									</tr>
									<tr>
										<th>
											<label for="memPhone">핸드폰번호</label>
										</th>
										<td>
											<input type = "text"  id="memPhone" name="memPhone"  placeholder="-없이 입력해주세요"/>
											<input type="button" id="btnPhCheck" name="btnPhCheck" value="본인인증"/>
											<input type = "text"  id="numCheck" name="numCheck"  placeholder="인증번호 입력"/>
											<input type="button" id="btnNumCheck" name="btnNumCheck" value="확인"/>
										</td>										
									</tr>
									<tr>
										<th>
											<label for="memAddress">주소</label>
										</th>
										<td>
											<input type="text" id="sample4_postcode" placeholder="우편번호" hidden="hidden">	
											<input type = "text"  id="sample4_roadAddress" name="memAddress"/>
											<input type ="button" id="btnAdd" name= "btnAdd" onclick="location.href='javascript:sample4_execDaumPostcode()'"value ="주소검색" />
										</td>								
									</tr>
									<tr>
										<td colspan="2" class="last">
											<input type="button" name= "btnJoin" id= "btnJoin" value="가입하기" />
										</td>
									</tr>
									
								</tbody>
							</table>
							<input type="hidden" name="memBalance" id="memBalance" value=0>
						</form>
					</div>
				</div>
			</div>
		</div>
		<%@ include file="/WEB-INF/view/resources/include/footer.jsp"%>
	</div>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<% String ctx = request.getContextPath(); %>
<!DOCTYPE html >
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- css  -->
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/asset/css/common.css" />
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/asset/css/main.css" />
<script type="text/javascript"src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
<style>
#header {position: fixed;}
</style>
<script	src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/smarteditor2-2.8.2.3/js/HuskyEZCreator.js" data-cfasync="false" charset="utf-8"></script>
<script type="text/javascript">
$(document).ready(function(){
	var frm = document.frm;
	var oEditors = [];

	var sLang = "ko_KR";	// 언어 (ko_KR/ en_US/ ja_JP/ zh_CN/ zh_TW), default = ko_KR

	// 추가 글꼴 목록
	//var aAdditionalFontSet = [["MS UI Gothic", "MS UI Gothic"], ["Comic Sans MS", "Comic Sans MS"],["TEST","TEST"]];

	nhn.husky.EZCreator.createInIFrame({
		oAppRef: oEditors,
		elPlaceHolder: "boardContent",
		sSkinURI: "<%=request.getContextPath() %>/resources/smarteditor2-2.8.2.3/SmartEditor2Skin.html",	
		htParams : {
			bUseToolbar : true,				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseVerticalResizer : true,		// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseModeChanger : false,			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
			//bSkipXssFilter : true,		// client-side xss filter 무시 여부 (true:사용하지 않음 / 그외:사용)
			//aAdditionalFontList : aAdditionalFontSet,		// 추가 글꼴 목록
			fOnBeforeUnload : function(){
				//alert("완료!");
			},
			I18N_LOCALE : sLang
		}, //boolean
		fOnAppLoad : function(){
			//예제 코드
			oEditors.getById["boardContent"].exec("PASTE_HTML", [""]);
		},
		fCreator: "createSEditor2"
	});
		
	String.prototype.decodeEntity = function() { 
	    return this.replace(/&/gi, "&").replace(/</gi, "<").replace(/>/gi, ">"); 
	};
	
	
	$('#btnSave').click(function(){
		oEditors.getById["boardContent"].exec("UPDATE_CONTENTS_FIELD", []);

		frm.submit();
		alert("게시글 작성이 완료 되었습니다.");
		
	});
	
});
</script>
</head>
<body>
	<%@ include file="/WEB-INF/view/resources/include/skipNav.jsp"%>
	<div id="wrap">
		<%@ include file="/WEB-INF/view/resources/include/header.jsp"%>
		<div id="container">
			<!-- 검색창 -->
			<div class="joonmain">
				<div class="inner">
					<div class="search">
			
					</div>
				</div>
			</div>
			<div class="category">
				<div class="inner">
				
					<form name="frm" action="boardCreateMo" method="post" modelAttribute="BoardCommand">
					<table>
						<tr style="border-bottom:1pt solid; border-color:#EAEAEA; border-width:80%;">
							<td><h3 style="font-size:25pt;">글쓰기</h3></td>
							<td><input type="button" id="btnSave" name="btnSave" value="등록" style="float:right; width:50pt; height:100%;"/></td>
						</tr>
						<tr >
							<td colspan="2" style="height:20pt;">
								<input type="text" id="boardTitle" name="boardTitle" maxlength="50" style="width:100%; height:100%; font-size:13pt;" value="${bCon.boardTitle }"/>
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<b>판매 가격(필수)</b>
							</td>
						</tr>
						<tr>
							<td colspan="2" style="height:20pt;">
								<input type="text" id="goodsPrice" name="goodsPrice" style="width:100pt; height:100%; font-size:13pt;" value="${bCon.goodsPrice }"/>원<br/>
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<b>카테고리(필수)</b>
							</td>
						</tr>
						
						<tr>
							<td colspan="2"style="height:20pt;">
								<select style="height:100pt;" id="boardCategory" name ="boardCategory">
									<option value="computer">컴퓨터</option>
									<option value="clothes">의류</option>
									<option value="digital">디지털/가전</option>
									<option value="gift">상품권</option>
									<option value="camping">캠핑</option>
									<option value="furniture">가구</option>
									<option value="game">게임용품</option>
									<option value="jewelry">귀금속/주얼리/악세서리</option>
									<option value="car">자동차</option>
									<option value="camera">카메라</option>
									<option value="sports">스포츠/레저</option>
									<option value="except">그외</option>
								</select>
								<br/>
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<b>결제 방식(필수)</b>
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<label><input type="checkbox" id="boardPay" name="boardPay" value="self"/>직접결제</label>
								<label><input type="checkbox" id="boardPay" name="boardPay" value="online" checked/>온라인결제</label>
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<b>판매자 정보</b>
							</td>
						</tr>
						<tr>
							<td style="width:125pt;">
								${Mdto.memEmail }
							</td>
							<td>
								${Mdto.memPhone }
							</td>
						</tr>
            			<tr>
            				<td colspan="2"><textarea id="boardContent" name="boardContent" style="width:100%; height:350px; ">${bCon.boardContent}</textarea></td>
            			</tr>
					</table>
					<input type="hidden" id="boardNum" name="boardNum" value="${bCon.boardNum }"/>
					<input type="hidden" id="boardCount" name="boardCount" value="0"/>
					<input type="hidden" id="goodsImg" name="goodsImg" value="aaa"/>
					<input type="hidden" id="visible" name="visible" value="Y"/>
					</form>
				</div>
			</div>

		</div>
	</div>
</body>

</html>
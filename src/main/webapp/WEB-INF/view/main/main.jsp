<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- css  -->
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/asset/css/common.css" />
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/asset/css/main.css" />
<style>
#header {position: fixed;}
</style>
<script type="text/javascript"src="http://code.jquery.com/jquery-3.5.1.min.js"></script>

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
<body>
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
			<!-- 카테고리 -->
			<div class="category">
				<div class="inner">
					<div class="col col01">
						<a href="board/category?category=computer">
							<span>컴퓨터</span>
							<img src="<%=request.getContextPath() %>/resources/asset/image/main/category-02.jpeg"alt="컴퓨터" />
						</a>
					</div>
					<div class="col col02">
						<a href="board/category?category=clothes">
							<span>의류</span> 
							<img src="<%=request.getContextPath() %>/resources/asset/image/main/category-03.jpeg" alt="의류" />
						</a>
					</div>
				
					<div class="col col03">
						<a href="board/category?category=digital">
							<span>디지털/가전</span> 
							<img src="<%=request.getContextPath() %>/resources/asset/image/main/category-07.jpeg" alt="디지털/가전" />
						</a>
					</div>
					<div class="col col04">
						<a href="board/category?category=gift">
							<span>상품권</span> 
							<img src="<%=request.getContextPath() %>/resources/asset/image/main/category-04.jpeg" alt="상품권" />
						</a>
					</div>
				
					<div class="col col05">
						<a href="board/category?category=camping">
							<span>캠핑</span> 
							<img src="<%=request.getContextPath() %>/resources/asset/image/main/category-05.jpeg" alt="캠핑" />
						</a>
					</div>
					<div class="col col06">
						<a href="board/category?category=furniture">
							<span>가구</span> 
							<img src="<%=request.getContextPath() %>/resources/asset/image/main/category-06.jpeg"alt="가구" />
						</a>
					</div>
				
					<div class="col col07">
						<a href="board/category?category=game">
							<span>게임용품</span> 
							<img src="<%=request.getContextPath() %>/resources/asset/image/main/category-09.jpeg" alt="게임용품" />
						</a>
					</div>
					<div class="col col08">
						<a href="board/category?category=jewellery">	
							<span>귀금속/주얼리/악세서리</span>
							<img src="<%=request.getContextPath() %>/resources/asset/image/main/category-12.jpeg" alt="귀금속/주얼리/악세서리" />
						</a>
					</div>
					<div class="col col09">
						<a href="board/category?category=car">
							<span>자동차</span> 
							<img src="<%=request.getContextPath() %>/resources/asset/image/main/category-11.jpeg" alt="자동차" />
						</a>
					</div>
					<div class="col col10">
						<a href="board/category?category=camera">
							<span>카메라</span> 
							<img src="<%=request.getContextPath() %>/resources/asset/image/main/category-10.jpeg" alt="카메라" />
						</a>
					</div>
					<div class="col col11">
						<a href="board/category?category=sports">
							<span>스포츠/레저</span> 
							<img src="<%=request.getContextPath() %>/resources/asset/image/main/category-13.jpeg"alt="스포츠/레저" />	
						</a>
					</div>
					<div class="col col12">
						<a href="#">
							<span>그외</span> 
							<img src="<%=request.getContextPath() %>/resources/asset/image/main/category-01.png"alt="그외" />
						</a>
					</div>
				</div>
			</div>
			<!-- //카테고리  -->
		</div>
		<%@ include file="/WEB-INF/view/resources/include/footer.jsp"%>
	</div>
</body>
</html>
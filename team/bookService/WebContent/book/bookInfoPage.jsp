<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="controller.user.*" %>
<script type="text/javascript">
	function rental() {
		var form = document.rForm;
		var answer;
		answer = confirm("해당 도서를 대여하시겠습니까?");
		if(answer == true)
			form.submit();

	}
</script>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 책 개인 페이지 _ 상품 상세 등. -->
<title> ${book.getBookname()} _도서페이지</title>
<style>
	body, div, span, p, a, font, ul, li, fieldset, form, legend, table {
		margin : 0;
		padding : 0;
		line-height : 130%;
		border-radius: 10px 10px 10px 10px;
	}
	
	div { display : block; }
	
	ul {
		margin-block-start: 1em;
	    margin-block-end: 1em;
	    margin-inline-start: 0px;
	    margin-inline-end: 0px;
	    padding-inline-start: 40px;
	}
	
	.topBar_wrap {
		position : relative;
		width : 100%;
		border-bottom : 1px solid gray;
	}
	.topBar {
		height : 30px;
		z-index : 100;
		width : 1100px;
		margin : 0 auto;
	}
	.menu {
		float : right;
		margin-top : 8px;
		padding-right : 20px;
		font-size : 11px;
		display : inline-block;
	}
	
	.header_wrap {
		width : 1170px;
		margin : 0 auto;
		overflow : hidden;
		position : relative;
		border-radius: 10px 10px 10px 10px ;
		margin-bottom : 10px;
		margin-top : 10px;
		background-color : #d5e3d5;
	}
	.main_searchForm {
		float: left;
	    margin-top: 25px;
	    margin-left: -20px;
	    margin-right : 5px;
	    height: 50px;
	}
	.main_searchForm fieldset {
		border : 0;
	}
	#container {
		width : 1170px;
		margin: 0 auto 0;
		padding-top : 25px;
		padding-bottom: 50px;
		min-height : 600px;
		background-color:#bbd4b8
	}
	.main {
	    z-index: 5;
	    width: 100%;
	    padding-bottom: 0;
	}
	
	.clearfix{
		display : block;
	}
	
	section {
		margin-bottom: 9px;
	    zoom: 1;
	    z-index: 2;
	    display : block;
	    position: relative;
	    float : left;
	}
	
	.bookInfo {
		width : 1000px;
		margin: 0 auto;
		padding-top : 25px;
		padding-bottom: 25px;
		margin-left : 90px;
		min-height : 250px;
		background-color:#FFFFFF;
	}
	
	.bookInfo .bookCover {
		position: relative;
	    float : left;
	    margin-top : 5px;
	    margin-bottom : 5px;
	    margin-left : 10px;
	    background-color:#FFFFE0;
	    min-height : 240px;
	    min-width : 200px;
	}
	
	.bookInfo .bookInfoDesc {
	    float : left;
		padding-bottom : 2px;
		margin-left : 60px;
		padding-left : 30px;
		word-wrap: break-word;
		text-align : justify;
		word-break: break-all;
		overflow: auto;
		white-space:normal;
	}
	
	.rentalItem {
		width : 1020px;
		margin: 0 auto;
		margin-top : 15px;
		padding-top : 5px;
		padding-bottom: 5px;
		margin-left : 70px;
		min-height : 160px;
	}
	
	.rentalForm {
		margin : 0 auto;
		background-color:#FFFFFF;
		margin-left : 20px;
		
	}
	
	.rentalFor fieldset{
		 
	}
	.rentalItem .bookCover {
		position: relative;
	    float : left;
	    margin-top : 5px;
	    margin-bottom : 5px;
	    margin-left : 10px;
	    background-color:#FFFFE0;
	    min-height : 120px;
	    min-width : 100px;
	}
	
	.rentalItem .rentalInfoDesc {
	
		position: relative;
	    float : left;
		padding-top : 20px;
		padding-bottom : 2px;
		margin-left : 60px;
		padding-left : 30px;
		text-align : justify;
		word-break: break-all;
		display : block;
	}
	
	.rentalItem .rButton {
		min-height : 80px;
	    min-width : 60px;
	    float : right;
	    margin-top : 50px;
	    margin-right : 30px;
	    
	}

	.list ul {
		list-style:none;
	    margin:0;
	    padding:0;
	    text-align:center
	    
	}
	.list li {
		list-style:none;
		margin: 0 0 5px 5px;
	    padding: 0 0 5px 5px;
	    border : 0;
	    float: left;
	}
	.list {
	    position: relative;
	    margin: 0 auto;
	    display: inline-block;
	    height: 40px;
	    margin-bottom: 16px;
	    padding: 15px 0 15px 0;
	    overflow: hidden;
	}
	.footer_area {
		text-align: center; 
	}
	
	.myinfo {
		float : right;
		padding-top : 50px;
		margin : 0 auto;
		width : 250px;
	}
	
</style>
</head>
<body>
	<div id="wrapper">
		<header id="header">
			<!-- topBar : 로그인이랑 공지사항 같은데로 바로가기 등(?) 임의로 넣음.  -->
			<div class="topBar_wrap">
				<div class="topBar">
					<div class="menu">
						<a href=".1">공지사항</a>
						<span> | </span>
						<a href=".2">즐겨찾기</a>
					</div>
				</div>
			</div>
			<!--  로고랑 search 바 있는 곳. -->
			<div class="header_wrap">
				<div class="logo" style="margin-top : 25px; float : left; width : 300px">
					<h3><a href="<c:url value='/home'/>">로고자리</a></h3>
				</div>
				<form name="main_search" class="main_searchForm" method="Get" action = "<c:url value='/book/search'/>">
				<!-- form에 action이랑 method 나중에 넣기 -->
					<fieldset>
						<legend>통합검색</legend>
						구분 : 
						
						<select id="stype" name="stype" title="상세검색" style="width:76px">
							<option value="all" <c:if test = "${stype=='all'}"> selected </c:if> >전체</option>
							<option value="subject"  <c:if test = "${stype=='subject'}"> selected </c:if>>제목</option>
							<option  value="member" <c:if test = "${stype=='member'}"> selected </c:if>>작가</option>
						</select> &nbsp;
						장르 : 
						<select id="stype_g" name="stype_g" title="장르검색" style="width:76px">
							<option value="all" selected >전체</option>
							<option value="action"  > 액션</option>
							<option value="fantasy"  > 판타지 </option>
							<option value="romance"  > 로맨스 </option>
							<option  value="comic" > 코믹 </option>
							<option value="etc" > 기타 등등 </option>
						</select>
						<input type="text" id="search_text" name="search_kw" title = "검색어 입력"
						size="20" class="inputText" value=${text}>
<!-- 검색! -->
						<input type="submit" value="검색" >
					</fieldset>
				</form>
				<div class = "myinfo">
					<% if( UserSessionUtils.getLoginUserId(request.getSession()) == null) { %>
				    	<a href="<c:url value='/user/login/form'/>" style="padding-left : 80px;">로그인 </a>
				    <% } else { %>
				    	<!-- 나중에 myPage?memberID 형태로 넘어가게 만들기 -->	
					 	<a href="<c:url value='/user/myPage'/>" style="padding-left : 50px;"> ${userId} 님  정보</a>
				    	<span> | </span>
				    	<a href="<c:url value='/user/logout'/>"> 로그아웃</a>
					<% } %>
				</div>
			</div>
		</header>
		<div id="container" class="main clearfix">
			<div class="main_content">
				<section id = "section">
					<div style = "margin-left : 100px; margin-top : 5px; margin-bottom : 5px;">
					<!-- RentalBookController에서 예외가 발생되어 넘어왔다면, 이유 출력해줌. -->
					<c:if test="${RentalException || Exception}">
	      				<font color="red"><c:out value="${exception.getMessage()}" /></font>
	   				 </c:if>rentalOK
	   				 <!-- RentalBookController에서 대여 성공할 경우 메세지 출력. -->
					<c:if test="${rentalOL}">
	      				<<font color="blue"> [대여 성공! 반납일은  14일 후 입니다.]</font>
	   				 </c:if>
					</div>
					<div class="bookInfo">
						<div class="bookCover">
							<img src="./images/쏼라쏼라" alt="책 표지" class="coverImage">
						</div>
						<div class="bookInfoDesc">
							<div style="width:100%; word-break:break-all;word-wrap:break-word;">
								<p> 제목 : ${book.getBookname()}
								<p> 작가: ${book.getWriter()}
								<p> ${book.getPublisher()}
								<p> ${book.getReleaseDate() }
								<p> ${book.getCategory()}
								<p> ${book.getSummary() }
								<!-- 글이 문장에 길어질 경우 텍스트 박스 칸을 벗어남. 고정시킬 필요있음. -->
							</div>
						</div>
					</div>
					<div class ="rentalBookList">
						<!-- 아래 틀을 jstl의 반복문을 사용해서 반복해서 보여주기. ~ 리스트 목록 / 10개 이상 존재 시 다음 페이지. -->
						<div class="rentalItem">
							<form class = "rentalForm" name = "rForm" method="POST" action="<c:url value='/user/book/rental'/>">
								<c:forEach var="rentalBook" items="${rbList}">
								<fieldset>
									<div class="bookCover">
										<img src="./images/쏼라쏼라" alt="책 표지" class="coverImage">
									</div>
									
									<div class="rentalInfoDesc">
											<p> 아이디: ${rentalBook.getSellerID() }
											<p> 상태: 
												<c:if test="${rentalBook.state eq 1}">
													대여 중
												</c:if>
												<c:if test="${rentalBook.state eq 0}">
													대여 가능
												</c:if>
											<p> 포인트: ${rentalBook.getPoint() }
											<p> ${rentalBook.getExplain() }
									</div>
									<!-- 머지... 렌탈 북 아닌가여...
									<div class="rentalInfoDesc">
											<p> 아이디 : zai0630
											<p> 상태 : 상
											<p> 포인트 : 500
											<p> 어쩌구 저쩌구 저는 재밌게 봤습니다. (rentalbook explain)
									</div>
									-->
									<div class="rButton">
										<input type="hidden" name="bookinfoID" value="${rentalBook.bookInfoID}">
										<input type="hidden" name = "rBookid" value="${rentalBook.bookID}">
										<c:if test="${rentalBook.state eq 0}">
											<% if( UserSessionUtils.getLoginUserId(request.getSession()) != null) { %>
												<input type = "button" value="대여하기" onClick="rental()">
											<%} else { %>
												<input type = "button" value="대여하기" disabled>
											<% } %>
										</c:if>
										<c:if test="${rentalBook.state eq 1}">
											<input type = "button" value="대여 중" disabled>
										</c:if>
									</div>
								</fieldset>
								</c:forEach>
							</form>
						</div>
					</div>
				</section>
			</div>
		</div>
		<footer id="footer">
			<div class="footer_area">
				<div class="list" >
					<ul style="width:100%" >
						<li> DBP 팀 프로젝트 </li>
						<li> 도서 관련 웹사이트 </li>
						<li> 목표 : 끝나고 다같이 맛있는 점심 사먹기 </li>
					</ul>
				</div>
			</div>
		</footer>
		
	</div>
</body>
</html>
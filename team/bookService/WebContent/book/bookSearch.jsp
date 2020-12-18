<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="controller.user.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title> 검색 결과 : 리스트</title>
<style>

	body, div, span, p, a, font, ul, li, fieldset, form, legend, table {
		margin : 0;
		padding : 0;
		border : 0;
		line-height : 130%;
	}
	
	h5{
		margin-left : 5px;
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
		width : 1100px;
		margin : 0 auto;
		overflow : hidden;
		position : relative;
		border-radius: 10px 10px 10px 10px ;
		margin-bottom : 10px;
		margin-top : 10px;
		background-color : #d5e3d5;
		color : #FFFFFF;		
		font-weight : bolder;
	}
	.main_searchForm {
		float: left;
	    margin-top: 25px;
	    margin-left: -20px;
	    margin-right : 5px;
	    height: 50px;
	}
	#container {
		postion : relative;
		width : 1100px;
		margin: 0 auto 0;
		padding-top : 25px;
		padding-bottom: 50px;
		min-height : 600px;
		background-color:#ffffff;
	}
	.main {
		position: relative;
	    z-index: 5;
	    width: 100%;
	    padding-bottom: 0;
	}
	
	.clearfix{
		display : block;
	}
	
	.section {
		margin-bottom: 9px;
	    zoom: 1;
	    position: relative;
	    z-index: 2;
	    display : block;
	}
	.rentalBookList {
		width : 800px;
		float : left;
		margin: 0 auto;
		margin-top : 5px;
		padding-top : 5px;
		padding-bottom: 5px;
		margin-left : 20px;
		min-height : 160px;
		background-color: #bbd4b8;
	}
	
	.rentalForm {
		margin : 0 auto;
		background-color:#bbd4b8;
		margin-left : 20px;
		
	}
	
	.rentalFor fieldset{
		 border: 1px solid #d1d1d1;
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
	
	.rentalItem {
		width : 770px;
		margin: 0 auto;
		margin-top : 15px;
		padding: 5px;
		margin-left : 5px;
		min-height : 160px;
		background-color:#bbd4b8;
		position : relative;
		float : left;
		border-radius: 10px 10px 10px 10px ;
	}
	
	.rentalForm {
		border-radius: 10px 10px 10px 10px;
		margin : 0 auto;
		padding-top : 10px;
		background-color:#FFFFFF;
		margin-left : 20px;
		
	}
	
	.rentalFor fieldset{
		 border: 1px solid #d1d1d1;
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

	.go_category {
		position: relative;
	    z-index: 200;
	    float: right;
	    width: 20%;
	    height: 600px;
	    padding: 2px;
	    border-radius: 10px 10px 10px 10px ;
	    border: 1px solid #d1d1d1;
	    background: #bbd4b8;
	    margin-right : 10px;
	}
	
	.go_category li {
		margin : 15px 20px;
		padding : 10;
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
					<% if( UserSessionUtils.isLoginUser("admin", request.getSession())) { %>
				    	<a href="<c:url value='/user/memberlist'/>" >사용자 조회 </a>
						<span> | </span>
						<a href="<c:url value='/user/booklist'/>">책 리스트 관리</a>
					<% } %>
					<% if( UserSessionUtils.hasLogined(request.getSession())) { %>
						<span> | </span>
						<a href="<c:url value='/user/booklist'/>">출석 포인트</a>
					<% } %>
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
					 	<a href="<c:url value='/user/myPage'/>" > ${userId} 님  정보</a>
				    	<span> | </span>
				    	<a href="<c:url value='/user/logout'/>" style="padding-right : 10px;"> 로그아웃</a>
					<% } %>
				</div>
			</div>
		</header>
		<div id="container" class="main clearfix">
			<div class="main_content">
				<section class="section">
					<div class ="rentalBookList">
						<h5> 검색 결과 : ${text} </h5>
						<!-- 아래 틀을 jstl의 반복문을 사용해서 반복해서 보여주기. ~ 리스트 목록 / 10개 이상 존재 시 다음 페이지. -->
						<div class="rentalItem">
							<form class = "rentalForm" name = "rForm">							  			
							  	<c:forEach var="bookInfo" items="${biList}">
									<fieldset>
										<div class="bookCover">
											<img src="${bookInfo.image}" alt="책 표지" class="coverImage">
											<script src="https://code.jquery.com/jquery-3.4.1.js" integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU=" crossorigin="anonymous">
											</script>
											
											<script>
												$(document).ready(function () {
												    $("#search").click(function () {
													$.ajax({
													    method: "GET",
													    url: "https://dapi.kakao.com/v3/search/book?target=title",
													    data: { query: $("#bookInfo").val() },
													    headers: { Authorization: "KakaoAK 22cc2bbeb4cf08cc61305b7cbe2b3abf" }
													})
													    .done(function (msg) {
														console.log(msg.documents[0].thumbnail);
														$("p").append("<img src='" + msg.documents[0].thumbnail + "'/>");
													    });
												    });
												});
											   </script>
										</div>
										<div class="rentalInfoDesc">
										<!--<a href="<c:url value='/book/info'> <c:param name='bookID' value='${book.bookID}'/></c:url>"> 
												${book.bookname}</a> -->
												<a href="<c:url value='/book/info'>
													<c:param name="bookID" value='${bookInfo.getBookinfoID()}'/>
													<c:param name="text" value='${text}'/>
													<c:param name="stype" value='${stype}'/>
												</c:url>"> ${bookInfo.getBookname()}</a>
												<p> 작가 : ${bookInfo.getWriter()}
												<p> 출판사 : ${bookInfo.getPublisher()}
												<p> 카테고리 : ${bookInfo.getCategory()}
										</div>
									</fieldset>
								</c:forEach>
							</form>
						</div>
					</div>
					<div class="go_category">
						<h3><b>&nbsp; *장르별 모아보기</b></h3>
						<!-- 리스트 내 장르별로 링크 걸어둘 예정 -->
						<ul style="list-style: none;">
							<li><a href=".">로맨스</a> </li>
							<li><a href="."> 판타지</a> </li>
							<li><a href="."> 액션</a> </li>
							<li><a href="."> 코믹 </a></li>
							<li><a href="."> 드라마</a> </li>
							<li><a href="."> 문학 </a></li>
							<li><a href="."> 스포츠 </a> </li>
							<li><a href="."> 공포</a> </li>
							<li><a href="."> 추리</a> </li>
							<li><a href="."> 아동</a> </li>
							<li><a href="."> 게임 </a></li>
							<li><a href="."> 무협</a> </li>
							<li><a href="."> 역사 </a></li>
							<li><a href="."> 라이트노벨 </a> </li>
						</ul>
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

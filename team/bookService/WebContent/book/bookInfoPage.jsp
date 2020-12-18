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
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
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
	.rentalBookList {
		position: relative;
		float : left;
	}
	.rentalItem {
		width : 680px;
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
	
	#reviewArea{
		float : right;
		width : 336px;
		margin-top : 20px;
		margin-left : 10px;
		background-color:#FFFFFF;
	}
	#InsertReview{
		margin-top : 10px;
		margin-left : 5px;
		margin-right : 3px;
		background-color:#FFFFE0;
	}
	#bookReviewList{
		margin-top : 10px;
		margin-left : 5px;
		margin-right : 3px;
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
	 <script src="https://code.jquery.com/jquery-3.4.1.js"
        integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU=" crossorigin="anonymous">
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
					</fieldset>
				</form>
				<div class = "myinfo">
					<% if( UserSessionUtils.getLoginUserId(request.getSession()) == null) { %>
				    	<a href="<c:url value='/user/login/form'/>" style="padding-left : 80px;">로그인 </a>
				    <% } else { %>
				    	<!-- 나중에 myPage?memberID 형태로 넘어가게 만들기 -->	
					 	<a href="<c:url value='/user/myPage'/>"> ${userId} 님  정보</a>
				    	<span> | </span>
				    	<a href="<c:url value='/user/logout'/>" style="padding-right : 10px;"> 로그아웃</a>
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
	      				<script>alert('<c:out value="${exception.getMessage()}" />');</script>
	   				 </c:if>
	   				 <!-- RentalBookController에서 대여 성공할 경우 메세지 출력. -->
					<c:if test="${rentalOK}">
	      				<font color="blue"> [대여 성공! 반납일은  14일 후 입니다.]</font>
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
										<img src="/bookService/upload/${rentalBook.image}" alt="책 표지" width="100" height="120" class="coverImage">
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
					<!-- to. 민주님 / 여기서  reviewArea 부분 추가 되었습니다. 디자인 수정 바랍니다. 둥글게 둥글개... -->
					<div id="reviewArea">
						<div id="InsertReview">
							<!-- to. 다솔님 / reviewIForm에서는 리뷰를 추가(insert)하는 작업을 진행합니다. 
								form에 부분에 action 추가해주시고. 버튼 등의 요소에 onClick()등을 이용하여 기능 추가해 이용해주세요. . -->
							<form class = "reviewIForm" name = "reviewForm" method="POST" >
								<input type = "hidden" name = "bookinfoID" value="${book.bookinfoID}">
								<textarea name = "reviewContent" cols="30" rows="4" placeholder = "해당책을 재밌게 보셨나요??&#13;&#10;리뷰를 입력해주세요."></textarea>
								<input type="button" value = "입력" >
							</form>
						</div>
						<div id="bookReviewList">
							<table class = "reviewList">
								<!-- to.다솔님 / 해당 페이지 bookinfoid를 기준으로 검색한 리뷰를 item를 가져와   c:forEach 이용해서  tr-td 부분 반복해 보여주면 될 듯합니다.
									검색한 리뷰 리스트는 bookinfoController에서 미리 setAttribute해주세요. 
								-->
							
								<tr>
									<td> 
										<div style="border:1px solid gold; width : 137%;">  <!-- 리뷰 아이템 경계선 표시&확인할려고 테두리 줬어요. 디자인시 참고하여 삭제, 바꿔주세요. -->
											 <h5>어쩌구님 (memberid값) /  별점 : 몇점 </h5>
											 <h4> 리뷰 내용 출력 </h4>
										</div>
									</td>
								</tr>
								
								<!-- 여기까지를 반복문으로,,,, ( 임의로 table 형식으로 보여주게 하였는데. 이부분이나 그 외 변수명 등 편하신데로 표시해주시면 될 듯합니다. -->
							</table>
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

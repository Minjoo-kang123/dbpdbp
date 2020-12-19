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
		padding : 5px;
		background-color : #d5e3d5;
		font-weight : bolder;
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
		min-height : 1000px;
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
	    background-color:#FFFFFF;
	    min-height : 240px;
	    min-width : 200px;
	}
	
	.bookInfo .bookInfoDesc {
	    float : left;
	    width : 600px;
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
	    background-color:#FFFFFF;
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
		width : 350px;
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
		background-color:#d5e3d5;
	}
	#InsertReview{
		padding-top : 10px;
		padding-left : 10px;
		margin-left : 20px;
		margin-right : 3px;
		background-color:#FFFFFF;
		position: relative;
	    margin: 0 auto;
	}
	#bookReviewList{
		margin-top : 10px;
		margin-left : 5px;
		margin-right : 3px;
		padding : 5px;
		width : 230px;
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
					</div>
				</div>
			</div>
			<!--  로고랑 search 바 있는 곳. -->
			<div class="header_wrap">
				<div class="logo" style=" float : left; width : 300px">
					<a href="<c:url value='/home'/>"><img src = "https://pbs.twimg.com/media/EplKy2FUYAEDjYq?format=png&name=360x360" width = "75px"></a>
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
							<option value="all" <c:if test = "${stype_g=='all'}"> selected </c:if> >전체</option>
							<option value="00"  <c:if test = "${stype_g=='00'}"> selected </c:if> > 총류</option>
							<option value="10"  <c:if test = "${stype_g=='10'}"> selected </c:if> > 철학 </option>
							<option value="20"  <c:if test = "${stype_g=='20'}"> selected </c:if> > 종교 </option>
							<option value="30" <c:if test = "${stype_g=='30'}"> selected </c:if> > 사회과학 </option>
							<option value="40" <c:if test = "${stype_g=='40'}"> selected </c:if> > 순수과학 </option>
							<option value="50"  <c:if test = "${stype_g=='50'}"> selected </c:if> > 기술과학</option>
							<option value="60" <c:if test = "${stype_g=='60'}"> selected </c:if> > 예술 </option>
							<option value="70" <c:if test = "${stype_g=='70'}"> selected </c:if>  > 어학 </option>
							<option value="81" <c:if test = "${stype_g=='81'}"> selected </c:if> > 에세이 </option>
							<option value="82" <c:if test = "${stype_g=='82'}"> selected </c:if> > 로맨스 </option>
							<option value="83" <c:if test = "${stype_g=='83'}"> selected </c:if> > 판타지</option>
							<option value="84" <c:if test = "${stype_g=='84'}"> selected </c:if> > 무협/액션 </option>
							<option value="85"  <c:if test = "${stype_g=='85'}"> selected </c:if> > SF </option>
							<option value="86" <c:if test = "${stype_g=='86'}"> selected </c:if> > 추리 </option>
							<option value="87" <c:if test = "${stype_g=='87'}"> selected </c:if>> 공포 </option>
							<option value="88"  <c:if test = "${stype_g=='88'}"> selected </c:if>> 만화</option>
							<option value="90"  <c:if test = "${stype_g=='90'}"> selected </c:if>> 역사 </option>
							<option value="89"  <c:if test = "${stype_g=='89'}"> selected </c:if>> 기타 </option>
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
							<img src="${book.getBookimage()}" alt="책 표지" class="coverImage" height = "250px">
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
							<form class = "reviewIForm" name = "reviewForm" method="POST" action="<c:url value='/book/review'/>" >
								<input type = "hidden" name = "bookinfoID" value="${book.bookinfoID}">
								
								<% if( UserSessionUtils.getLoginUserId(request.getSession()) != null) { %>
							    	<input type = "hidden" name = "memberID" value="${userId}">
								<% } %>
								
								<textarea name = "reviewContent" cols="30" rows="4" placeholder = "해당책을 재밌게 보셨나요??&#13;&#10;리뷰를 입력해주세요."></textarea>
								<br>
								<label><input type="radio" name="preference" value=0 checked >1점</label>
								<label><input type="radio" name="preference" value=1 >2점</label>
								<label><input type="radio" name="preference" value=2 >3점</label>
								<label><input type="radio" name="preference" value=3 >4점</label>
								<label><input type="radio" name="preference" value=4 >5점</label>
								
								<% if( UserSessionUtils.getLoginUserId(request.getSession()) != null) { %>
							    	<input type="submit" value = "입력">
								<% }  else {%>
									<br>로그인 이후 리뷰 작성할 수 있습니다.
								<% } %>
							</form>
						</div>
						<div id="bookReviewList">
							<table class = "reviewList">
								<c:forEach var="review" items="${rwList}">							
								<tr>
									<td> 
										<div style="border:1px solid white; width : 137%;	margin-bottom : 5px;">  <!-- 리뷰 아이템 경계선 표시&확인할려고 테두리 줬어요. 디자인시 참고하여 삭제, 바꿔주세요. -->
											 <h5> ${review.getMemberID()}님 /  별점 : ${review.getPreference() + 1}점 </h5>
											 <h4> ${review.getReviewContent()}</h4>
										</div>
									</td>
								</tr>
								</c:forEach>
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

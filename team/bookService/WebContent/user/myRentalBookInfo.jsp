<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="controller.user.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 판매 도서 : {rBook.bookname}</title>
<script type="text/javascript">

	function update() {
		var form = document.form;
		if ( form.rpoint.value == "" ) {
			alert("대여 도서의 포인트를 입력하십시오.");
			form.rpoint.focus();
			return false;
		} 
		if ( form.rexplain.value == "" ) {
			alert("대여도서의 소개글을 입력하십시오.");
			form.rexplain.focus();
			return false;
		}	
		form.submit();
	}
	
	function remove(targetUri) {
		var form = document.form;
		var answer;
		answer = confirm("해당 대여 도서를 삭제하시겠습니까?");
		if(answer == true){
			form.action = targetUri;
			form.submit();
		}
	}
	
</script>
<style>
	body, div, span, p, a, font, ul, li, fieldset, form, legend, table {
		margin : 0;
		padding : 0;
		border : 0;
		line-height : 130%;
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
		background-color:#bbd4b8;
		border-radius: 10px 10px 10px 10px ;
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
		width : 700px;
		padding-top: 50px;
		margin : 0 auto;
		backgroud-color : #ffffff;
	    zoom: 1;
	    position: relative;
	    z-index: 2;
	    display : block;
	}
	

	.fInput {
		width: 300px;
		height : 25px;
		font-size : 15px;
	}
	.fradio {
		width: 80px;
		height : 25px;
		font-size : 15px;
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
					<% } %>ㄴ
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
					 	<a href="<c:url value='/user/myPage'/>"> ${userId} 님  정보</a>
				    	<span> | </span>
				    	<a href="<c:url value='/user/logout'/>" style="padding-right : 10px;"> 로그아웃</a>
					<% } %>
				</div>
			</div>
		</header>
		<div id="container" class="main clearfix">
			<div class="main_content">
				<section class="section">
					<div id ="myRBook">
						<%//필요한 정보, rentalBook(bookId) : rBook 얘랑 연계된 rentalInfo rInfo, rentalBook이랑 연계된 bookinfo : bInfo%>
						<p>* 해당 도서가 대여 중일 경우 포인트, 상태, 책 소개를 수정하실 수 없으며, 글을 내리실 수 없습니다.</p>
						<form name="form" method="POST" action="<c:url value='/user/rbook/update'/>" enctype="multipart/form-data">
							<input type="hidden" name = "bookid" value ="${rBook.bookID}" >
							<input type="hidden" name = "sellerid" value = "${rBook.sellerID}">
							<input type="hidden" name = "bookinfoid" value = "${rBook.bookInfoID}">
							<input type="hidden" name = "image" value = "${rBook.image}">
							<input type="hidden" name = "state" value = "${rBook.state}">
							 제목 : <input type="text" name="bookname" value = "${rBook.bookname}" class = "fInput" readonly> <br>
							 출판사 : <input type="text" value = "${bInfo.publisher}" class = "fInput" readonly> <br>
							 작가 : <input type="text" value = " ${bInfo.writer} 저" class = "fInput" readonly> <br>
							 장르 : <input type="text" value = "${bInfo.category}" class = "fInput" readonly> <br>
							<c:if test="${rBook.state ==  1}"> <!-- 대여 중일 경우 -->
								대여 상태 : <input type="text" name = "rstate" value = "O " class = "fInput" readonly><br>
								포인트 : <input type="text" name = "rpoint" value = "${rBook.point}" class = "fInput" readonly> <br>
								책 소개 : <input type="text" name = "rexplain" value = "${rBook.explain}"  class = "fInput" readonly> <br>
								책 상태 :
								 	<c:if test="${rBook.condition ==  0}">
										<label><input type="radio" name = "condition" value="0" class = "fradio" checked disabled"> 상  </label>
										<label><input type="radio" name = "condition" value="1" class = "fradio" onClick="return(false);"> 중  </label>
										<label><input type="radio" name = "condition" value="2" class = "fradio" onClick="return(false);"> 하  </label>
									</c:if>
									<c:if test="${rBook.condition ==  1}">
										<label><input type="radio" name = "condition" value="0" class = "fradio" onClick="return(false);"> 상 </label>
										<label><input type="radio" name = "condition" value="1" class = "fradio" checked disabled"> 중  </label>
										<label><input type="radio" name = "condition" value="2" class = "fradio" onClick="return(false);"> 하  </label>
									</c:if>
									<c:if test="${rBook.condition ==  2}">
										<label><input type="radio" name = "condition" value="0" class = "fradio" onClick="return(false);"> 상 </label>
										<label><input type="radio" name = "condition" value="1" class = "fradio" onClick="return(false);"> 중  </label>
										<label><input type="radio" name = "condition" value="2" class = "fradio" checked disabled"> 하  </label>
									</c:if> <br>
								*대여자 정보 : 
									대여자 아이디 : <input type="text" value="${rInfo.rentalerID }" class = "fInput" readonly><br>
									대여일 : <input type="text" value="${rInfo.rentalDate }" class = "fInput" readonly><br>
									반납일 :<input type="text" value="${rInfo.returnDate }" class = "fInput" readonly><br>
								<input type="button" value = "확인" onClick="update()"> 
							</c:if>
							<c:if test="${rBook.state ==  0}"> <!-- 대여 중일 아닐 경우 -->
								대여 상태 : <input type="text" name = "rstate" value = "X " class = "fInput" readonly> <br>
								책 이미지 : <img src="${rBook.getImage()}" alt="책 표지" width="100" height="120"> <input type="file" name="image"> <br>
								포인트 : <input type="text" name = "rpoint" value = "${rBook.point}" class = "fInput" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" > <br>
								책 소개 : <input type="text" name = "rexplain" value = "${rBook.explain}" class = "fInput"> <br>
								책 상태 :
								 	<c:if test="${rBook.condition ==  0}">
										<label><input type="radio" name = "condition" value="0" class = "fradio" checked> 상   </label>
										<label><input type="radio" name = "condition" value="1" class = "fradio" > 중  </label>
										<label><input type="radio" name = "condition" value="2" class = "fradio" > 하  </label>
									</c:if>
									<c:if test="${rBook.condition ==  1}">
										<label><input type="radio" name = "condition" value="0" class = "fradio" > 상  </label>
										<label><input type="radio" name = "condition" value="1" class = "fradio" checked > 중  </label>
										<label><input type="radio" name = "condition" value="2" class = "fradio" > 하  </label>
									</c:if>
									<c:if test="${rBook.condition ==  2}">
										<label><input type="radio" name = "condition" value="0" class = "fradio" > 상  </label>
										<label><input type="radio" name = "condition" value="1" class = "fradio"> 중  </label>
										<label><input type="radio" name = "condition" value="2" class = "fradio" checked> 하 </label>
									</c:if>
									<br>
								<input type="button" value = "수정/확인" onClick="update()">
								<input type="button" value = "도서 내리기" onClick="remove('<c:url value='/user/rbook/remove'/>')">  
							</c:if>
						</form>
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

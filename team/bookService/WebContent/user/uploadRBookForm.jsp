<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="controller.user.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>새 대여 도서 올리기</title>
<script type="text/javascript">
	function upload() {
		var form = document.form;
		form.submit();
	}
	function cancel(targetUri){
		var form = document.form;
		form.action = targetUri;
		form.submit();
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
		background-color:#FFFFE0;
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
		background-color:#FFB6C1
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
	
	***
	
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
					<div id ="rbookForm">
						<!-- 새 rentalBook 레코드 insert -->
						<c:if test="${uploadFailed eq true}">
							<script> alert('<c:out value="${exception.getMessage()}" /> \n다시 확인해주시거나 관리자에게 도서정보 추가를 문의해주세요.');</script>
							<form name="form" method="POST" action="<c:url value='/user/rbook/upload'/>" enctype="multipart/form-data">
							 게시자 아이디 : <input type="text" name="sellerID" value = "${rbook.sellerID }" readonly> <br>
							 *책 정보 : <br>
							 책 제목  : <input type="text" name="bookname" value = "${rbook.bookname}"> <br>
							 책 ISBN :  <input type="text" name="bookInfoID"  value = "${rbook.bookInfoID}" placeholder="abcd0000000XX"> <br>
							 책 이미지 : <!-- 현재는 링크를 그냥 적지만, 나중에는 파일 업로드 식으로 링크 올리고 싶다 -->
							 <input type="file" name="image"> <br>
							 책 상태  : <input type="radio" name="condition" value="0" checked> 상 | &nbsp;
							 <input type="radio" name="condition" value="1"> 중 | &nbsp;
							 <input type="radio" name="condition" value="2"> 하 | &nbsp;
							 <br>
							 등록 포인트 :  <input type="text" name="point"  value = "${rbook.point}" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');"> <br>
							 책 소개 :  <input type="text" name="explain"  value = "${rbook.explain}"> <br>
							 <input type="hidden" name="state" value = "0">
							 <input type="button" value = "등록" onClick="upload()">
							 <input type="button" value = "취소" onClick="cancel('<c:url value='/user/myPage'/>')">
							</form>
						</c:if>
						<c:if test="${uploadFailed != true}">
						<form name="form" method="POST" action="<c:url value='/user/rbook/upload'/>" enctype="multipart/form-data">
							 게시자 아이디 : <input type="text" name="sellerID" value = "<%= request.getParameter("memberid") %>" readonly> <br>
							 *책 정보 : <br>
							 책 제목  : <input type="text" name="bookname"> <br>
							 책 ISBN :  <input type="text" name="bookInfoID" placeholder="abcd0000000XX"> <br>
							 책 이미지 : <input type="file" name="image"> <br>
							 책 상태  : <input type="radio" name="condition" value="0" checked> 상 | &nbsp;
							 <input type="radio" name="condition" value="1"> 중 | &nbsp;
							 <input type="radio" name="condition" value="2"> 하 | &nbsp;
							 <br>
							 등록 포인트 :  <input type="text" name="point" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');"> <br>
							 책 소개 :  <input type="text" name="explain"> <br>
							 <input type="hidden" name="state" value = "0">
							 <input type="button" value = "등록" onClick="upload()">
							 <input type="button" value = "취소" onClick="cancel('<c:url value='/user/myPage'/>')">
						</form>
						</c:if>
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
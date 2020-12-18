<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="controller.user.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 정보 조회 / 수정</title>
<script type="text/javascript">
	
	function update() {
		var form = document.form;
		form.submit();
	}
	function cancel(targetUri) {
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
						<form name="form" method="POST" action="<c:url value='/user/update'/>">
							<table>
								<tr>
									<td> 아이디 : </td> <td> <input type = "text" value = "${member.memberID}" name = "memberid" readonly></td>
								</tr>
								<tr>
									<td> 비밀번호 : </td> <td> <input type = "text" value = "${member.password}" name = "passwd"></td>
								</tr>
								<tr>
									<td> 이름 : </td> <td> <input type = "text" value = "${member.name}" name = "name" readonly></td>
								</tr>
								<tr>
									<td> 성별 : <input type="hidden" value ="${member.gender}" name = "gender"> </td> 
									<c:if test="${member.gender eq 0}">
									 	<td> <input type = "text" value = "남자" readonly></td>
									</c:if>
									<c:if test="${member.gender eq 1}">
									 	<td> <input type = "text" value = "여자" readonly></td>
									</c:if>
									<c:if test="${member.gender eq 2}">
									 	<td> <input type = "text" value = "선택 안함." readonly></td>
									</c:if>
								</tr>
								<tr>
									<td> 이메일 : </td> <td> <input type = "text" value = "${member.email}" name = "email"></td>
								</tr>
								<tr>
									<td> 전화번호 : </td> <td> <input type = "text" value = "${member.phone}" name = "phone"></td>
								</tr>
								<tr>
									<td> 지역구 : </td> <td> <input type = "text" value = "${member.address}" placeholder="OO시  OO동/구" name = "address"></td>
								</tr>
								<tr>
									<td> 포인트 : </td> <td> <input type = "text" value = "${member.point}" name = "point" readonly></td>
								</tr>
								<tr>
									<td> 멤버 등급 : </td> <td> <input type = "text" value = "${member.memberGrade}" name = "memberGrade" readonly></td>
								</tr>
								<tr>
									<td> 판매자 등급 : </td> <td> <input type = "text" value = "${member.sellerGrade}" name = "sellerGrade" readonly></td>
								</tr>
								<tr>
									<td colspan = "2"> 
										<input type="button" value="수정하기" onClick="update()"> &nbsp; | &nbsp; 
										<input type="button" value="취소" onClick="cancel('<c:url value='/user/myPage'/>')">
									</td>
								</tr>
							</table>
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
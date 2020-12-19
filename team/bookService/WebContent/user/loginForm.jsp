<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="controller.user.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login?_bookService</title>
<script type="text/javascript">

	function login() {
		if ( loginForm.userId.value == "" ) {
			alert("사용자 아이디를 입력하십시요.");
			loginForm.userId.focus();
			return false;
		} 
		if ( loginForm.password.value == "" ) {
			alert("비밀번호를 입력하십시요.");
			loginForm.password.focus();
			return false;
		}	
		loginForm.submit();
	}
	
	function userCreate(targetUri) {
		loginForm.action = targetUri;
		loginForm.submit();
	}
</script>
<style>
body, div, span, p, a, font, ul, li, fieldset, form, legend, table {
		margin : 0;
		padding : 0;
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
		postion : relative;
		width : 1100px;
		margin: 0 auto 0;
		padding-top : 25px;
		padding-bottom: 50px;
		min-height : 600px;
		background-color: #bbd4b8
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
	
	.go_category {
		position: relative;
	    z-index: 200;
	    float: right;
	    width: 20%;
	    height: 700px;
	    padding: 2px;
	    border: 1px solid #d1d1d1;
	    background: #fff;
	    color : #bbd0b0;
		border-radius: 10px 10px 10px 10px ;
	    margin-right : 10px;
	}
	
	.go_category li {
		margin : 15px 20px;
		text-align : center;
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
	
	#login_wrapper {
	    position: relative;
		float : left;
		width : 860px;
		overflow: hidden;
	    min-height: 400px;
	}
	.login_area {
		margin: 0 auto;
		padding-top : 200px;
	    width: 500px;
	    position: relative;
	}
	.login_area fieldset {
		padding : 20px;
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
							<option value="all" selected >전체</option>
							<option value="00"  > 총류</option>
							<option value="10"  > 철학 </option>
							<option value="20"  > 종교 </option>
							<option  value="30" > 사회과학 </option>
							<option value="40" > 순수과학 </option>
							<option value="50"  > 기술과학</option>
							<option value="60"  > 예술 </option>
							<option value="70"  > 어학 </option>
							<option  value="81" > 에세이 </option>
							<option value="82" > 로맨스 </option>
							<option value="83"  > 판타지</option>
							<option value="84"  > 무협/액션 </option>
							<option value="85"  > SF </option>
							<option  value="86" > 추리 </option>
							<option value="87" > 공포 </option>
							<option value="88"  > 만화</option>
							<option value="90"  > 역사 </option>
							<option value="89"  > 기타 </option>
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
					<div id="login_wrapper" class="login_content clearfix">
						<!-- content -->
						<div class="login_area">
							<form name="loginForm" method="POST" action="<c:url value='/user/login' />">
								<fieldset>
									<legend>로그인 폼</legend> <p>
									아이디: <input type="text" style="width:240;" name="userId"> <p>
									패스워드: <input type="password" style="width:240; margin-top:10px" name="password">
									&nbsp;&nbsp; <input type="button" value="로그인" onClick="login()"><p>
								</fieldset>
								<div>
									<small>아직 아이디가 없으신가요?</small> <input type="button" value="회원가입" onClick="userCreate('<c:url value='/user/register/form' />')">
								</div>
							</form>
						</div>
					</div>
					<div class="go_category">
						<h3><b>&nbsp; *장르별 모아보기</b></h3>
						<!-- 리스트 내 장르별로 링크 걸어둘 예정 -->
						<ul style="list-style: none;">
							<li><a href="<c:url value='/book/search'> 
									<c:param name="search_kw" value=""/>
									<c:param name="stype" value="all"/>
									<c:param name="stype_g" value="00"/>
								</c:url>"> 총류</a> </li>	
							<li><a href="<c:url value='/book/search'> 
									<c:param name="search_kw" value=""/>
									<c:param name="stype" value="all"/>
									<c:param name="stype_g" value="10"/>
								</c:url>"> 철학</a> </li>
							<li><a href="<c:url value='/book/search'> 
									<c:param name="search_kw" value=""/>
									<c:param name="stype" value="all"/>
									<c:param name="stype_g" value="20"/>
								</c:url>"> 종교</a> </li>
							<li><a href="<c:url value='/book/search'> 
									<c:param name="search_kw" value=""/>
									<c:param name="stype" value="all"/>
									<c:param name="stype_g" value="30"/>
								</c:url>"> 사회과학 </a></li>
							<li><a href="<c:url value='/book/search'> 
									<c:param name="search_kw" value=""/>
									<c:param name="stype" value="all"/>
									<c:param name="stype_g" value="40"/>
								</c:url>"> 순수과학</a> </li>
							<li><a href="<c:url value='/book/search'> 
									<c:param name="search_kw" value=""/>
									<c:param name="stype" value="all"/>
									<c:param name="stype_g" value="50"/>
								</c:url>"> 기술과학</a></li>
							<li><a href="<c:url value='/book/search'> 
									<c:param name="search_kw" value=""/>
									<c:param name="stype" value="all"/>
									<c:param name="stype_g" value="60"/>
								</c:url>"> 예술</a> </li>
							<li><a href="<c:url value='/book/search'> 
									<c:param name="search_kw" value=""/>
									<c:param name="stype" value="all"/>
									<c:param name="stype_g" value="70"/>
								</c:url>"> 어학</a> </li>
							<li><a href="<c:url value='/book/search'> 
									<c:param name="search_kw" value=""/>
									<c:param name="stype" value="all"/>
									<c:param name="stype_g" value="81"/>
								</c:url>"> 에세이</a> </li>
							<li><a href="<c:url value='/book/search'> 
									<c:param name="search_kw" value=""/>
									<c:param name="stype" value="all"/>
									<c:param name="stype_g" value="82"/>
								</c:url>"> 로맨스</a> </li>
							<li><a href="<c:url value='/book/search'> 
									<c:param name="search_kw" value=""/>
									<c:param name="stype" value="all"/>
									<c:param name="stype_g" value="83"/>
								</c:url>"> 판타지</a></li>
							<li><a href="<c:url value='/book/search'> 
									<c:param name="search_kw" value=""/>
									<c:param name="stype" value="all"/>
									<c:param name="stype_g" value="84"/>
								</c:url>"> 무협/액션</a> </li>
							<li><a href="<c:url value='/book/search'> 
									<c:param name="search_kw" value=""/>
									<c:param name="stype" value="all"/>
									<c:param name="stype_g" value="85"/>
								</c:url>"> SF</a> </li>
							<li><a href="<c:url value='/book/search'> 
									<c:param name="search_kw" value=""/>
									<c:param name="stype" value="all"/>
									<c:param name="stype_g" value="86"/>
								</c:url>"> 추리</a> </li>
							<li><a href="<c:url value='/book/search'> 
									<c:param name="search_kw" value=""/>
									<c:param name="stype" value="all"/>
									<c:param name="stype_g" value="87"/>
								</c:url>"> 공포</a> </li>
							<li><a href="<c:url value='/book/search'> 
									<c:param name="search_kw" value=""/>
									<c:param name="stype" value="all"/>
									<c:param name="stype_g" value="88"/>
								</c:url>"> 만화</a> </li>
							<li><a href="<c:url value='/book/search'> 
									<c:param name="search_kw" value=""/>
									<c:param name="stype" value="all"/>
									<c:param name="stype_g" value="90"/>
								</c:url>"> 역사 </a></li>
							<li><a href="<c:url value='/book/search'> 
									<c:param name="search_kw" value=""/>
									<c:param name="stype" value="all"/>
									<c:param name="stype_g" value="89"/>
								</c:url>"> 기타</a> </li>
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
	<c:if test="${loginFailed eq true}"> <script> alert('로그인에 실패하셨습니다.\n 아이디와 비밀번호를 다시 확인해주세요.')</script></c:if>
	
</body>
</html>	

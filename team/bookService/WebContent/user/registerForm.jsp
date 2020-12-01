<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="controller.user.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>register</title>
<script type="text/javascript">
function userCreate() {
	if (form.memberID.value == "") {
		alert("사용자 ID를 입력하십시오.");
		form.userId.focus();
		return false;
	} 
	if (form.password.value == "") {
		alert("비밀번호를 입력하십시오.");
		form.password.focus();
		return false;
	}
	if (form.password.value != form.password2.value) {
		alert("비밀번호가 일치하지 않습니다.");
		form.name.focus();
		return false;
	}
	if (form.name.value == "") {
		alert("이름을 입력하십시오.");
		form.name.focus();
		return false;
	}
	if (form.email.value == "") {
		alert("이메일을 입력하십시오.");
		form.email.focus();
		return false;
	}
	var emailExp = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
	if(emailExp.test(form.email.value)==false) {
		alert("이메일 형식이 올바르지 않습니다.");
		form.email.focus();
		return false;
	}
	if (form.phone.value == "") {
		alert("전화번호를 입력하십시오.");
		form.phone.focus();
		return false;
	}
	var phoneExp = /^\d{10,11}$/;
	if(phoneExp.test(form.phone.value)==false) {
		alert("전화번호 형식이 올바르지 않습니다.");
		form.phone.focus();
		return false;
	}
	form.submit();
}

function cancel(targetUri) {
	form.action = targetUri;
	form.submit();
}

</script>
<style>
	body, div, span, p, a, font, ul, li, fieldset, form, legend, table {
		margin : 0;
		padding : 0;
		line-height : 130%;
	}
	h5 {
		margin-leff : 25px;
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
		border-bottom : 3px solid #bbd4b8;
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
		width : 1150px;
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
	.main_searchForm fieldset {
		border : 0;
	}
	#container {
		width : 1100px;
		margin: 0 auto 0;
		padding-top : 25px;
		padding-bottom: 50px;
		min-height : 600px;
		background-color : #bbd4b8;
	}
	.main {
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
	    z-index: 2;
	    display : block;
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
	#registerArea {
		border : 0;
		margin : 0 auto;
		margin-right : 300px;
		margin-top : 50px;
		margin-left : 300px;
		background-color : #FFFFFF;
		border-radius: 10px 10px 10px 10px ;
		color : #bbd4b8;
		font-weight : bolder;
	    overflow: hidden;
	}
	
	#registerForm fieldset, p, h5 {
		padding : 10px;
		margin : 10px;
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
				<section class="section">
					<div id = "registerArea">
						<form name="form" method="POST" action="<c:url value='/user/register' />">
							<fieldset> 
								<h5>회원가입</h5> <p>
								아이디* : <input type="text" style="width: 540; " name="memberID"> <p>
								비밀번호* : <input type="password" style="width: 540" name="password"> <p>
								비밀번호 확인* : <input type="password" style="width: 540" name="password2"> <p>
								이름* : <input type="text" style="width: 540" name="name" > <p>
								성별 : 
								<label><input type="radio" name="gender" value="0" checked >남자</label>
								<label><input type="radio" name="gender" value="1" >여자</label>
								<label><input type="radio" name="gender" value="2" >미선택</label>
								<p>
								이메일* : <input type="text" style="width: 540" name="email" > <p>
								전화번호* : <input type="text" style="width: 540" name="phone" > <p>
								지역구* : 
								<label><input type="radio" name="address" value="성북구" checked >성북구</label>
								<label><input type="radio" name="address" value="강남구" >강남구</label>
								<label><input type="radio" name="address" value="중랑구" >중랑구</label>
								<label><input type="radio" name="address" value="마포구" >마포구</label>
								<label><input type="radio" name="address" value="구로구" >구로구</label>
								<label><input type="radio" name="address" value="강동구" >강동구</label>
								<p>
								<!-- 지역 기입 부분 이후 시간이 남을 경우 좀 자세히 남기고 싶음.-->
								<p>
								<input type="button" value="회원 가입" onClick="userCreate()"> &nbsp;
								<input type="button" value="취소" onClick="cancel('<c:url value='/user/login/form' />')">							
							</fieldset>
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

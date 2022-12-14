<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="controller.user.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>homePage_book service</title>
<style>
	
	@import url('https://fonts.googleapis.com/css2?family=Gaegu&family=Noto+Sans+KR&family=Yeon+Sung&display=swap');
	@import url('https://fonts.googleapis.com/css2?family=Nanum+Brush+Script&display=swap');
	
	body, div, span, p, a, font, ul, li, fieldset, form, legend, table {
		margin : 0;
		padding : 0;
		border : 0;
		line-height : 130%;
		
		border-radius: 10px 10px 10px 10px ;
	}
	div { display : block; }
	
	ul {
		margin-block-start: 1em;
	    margin-block-end: 1em;
	    margin-inline-start: 0px;
	    margin-inline-end: 0px;
	    padding-inline-start: 40px;
	}
	
	.a{
		font-family: 'Gaegu', cursive;
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
		width : 1150px;
		margin: 0 auto 0;
		padding-top : 25px;
		padding-bottom: 40px;
		padding-left: 20px;
		min-height : 700px;
		border-radius: 10px 10px 10px 10px ;
		background-color:#bbd4b8;
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
	
	.recommand_book {
		position: relative;
		float : left;
		width : 860px;
		overflow: hidden;
	}
	
	.rec_bookCover {
		float : left;
		width : 48%;
		height : 600px;
		background-color : white;
		background-position: center;
		margin-left : 10px;
	}
	.rec_bookDesc {
		float : right;
		width : 47%;
		height : 575px;
		background-color : #FFFFFF;
		margin-left : 5px;
		padding-left : 25px;
		padding-top : 25px;
		font-family: 'Nanum Brush Script', cursive;
		font-size : 120%;
	}
	.go_category {
		position: relative;
	    z-index: 200;
	    float: right;
	    width: 20%;
	    height: 700px;
	    padding: 2px;
	    background: #fff;
	    margin-right : 30px;
	}
	
	.go_category li {
		margin : 15px 20px;
		padding-right : 40px;
		text-align : center;
		
	}
	
	.list ul {
		list-style:none;
	    margin:0;
	    padding:0;
	    text-align:center;
	    
	}
	.list li {
		list-style:none;
		margin: 0 0 5px 5px;
	    padding: 0 0 5px 5px;
	    border : 0;
	    float: left;
	    
		font-family: 'Nanum Gothic', sans-serif;
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
	.coverImage{
		height : 500px;
		margin : 16px;
		margin-top : 50px;
		}
</style>
</head>
<body>
	<div id="wrapper">
		<header id="header">
			<!-- topBar : ??????????????? ???????????? ???????????? ???????????? ???(?) ????????? ??????.  -->
			<div class="topBar_wrap">
				<div class="topBar">
					<div class="menu">
						<a href="<c:url value='/book/recommand/form'/>">?????? ??????</a>
					<% if( UserSessionUtils.isLoginUser("admin", request.getSession())) { %>
						<span> | </span>
				    	<a href="<c:url value='/user/memberlist'/>" >????????? ?????? </a>
						<span> | </span>
						<a href="<c:url value='/user/booklist'/>">??? ????????? ??????</a>
					<% } %>
					</div>
				</div>
			</div>
			<!--  ????????? search ??? ?????? ???. -->
			<div class="header_wrap">
				<div class="logo" style=" float : left; width : 300px">
					<a href="<c:url value='/home'/>"><img src = "https://pbs.twimg.com/media/EplKy2FUYAEDjYq?format=png&name=360x360" width = "75px"></a>
				</div>
				<form name="main_search" class="main_searchForm" method="Get" action = "<c:url value='/book/search'/>">
				<!-- form??? action?????? method ????????? ?????? -->
					<fieldset>
						<legend>????????????</legend>
						?????? : 
						
						<select id="stype" name="stype" title="????????????" style="width:76px">
							<option value="all" <c:if test = "${stype=='all'}"> selected </c:if> >??????</option>
							<option value="subject"  <c:if test = "${stype=='subject'}"> selected </c:if>>??????</option>
							<option  value="member" <c:if test = "${stype=='member'}"> selected </c:if>>??????</option>
						</select> &nbsp;
						?????? : 
						<select id="stype_g" name="stype_g" title="????????????" style="width:76px">
							<option value="all" selected >??????</option>
							<option value="00"  > ??????</option>
							<option value="10"  > ?????? </option>
							<option value="20"  > ?????? </option>
							<option  value="30" > ???????????? </option>
							<option value="40" > ???????????? </option>
							<option value="50"  > ????????????</option>
							<option value="60"  > ?????? </option>
							<option value="70"  > ?????? </option>
							<option  value="81" > ????????? </option>
							<option value="82" > ????????? </option>
							<option value="83"  > ?????????</option>
							<option value="84"  > ??????/?????? </option>
							<option value="85"  > SF </option>
							<option  value="86" > ?????? </option>
							<option value="87" > ?????? </option>
							<option value="88"  > ??????</option>
							<option value="90"  > ?????? </option>
							<option value="89"  > ?????? </option>
						</select>
						<input type="text" id="search_text" name="search_kw" title = "????????? ??????"
						size="20" class="inputText" value=${text}>
<!-- ??????! -->
						<input type="submit" value="??????" >
					</fieldset>
				</form>
				<div class = "myinfo">
					<% if( UserSessionUtils.getLoginUserId(request.getSession()) == null) { %>
				    	<a href="<c:url value='/user/login/form'/>" style="padding-left : 80px;">????????? </a>
				    <% } else { %>
				    	<!-- ????????? myPage?memberID ????????? ???????????? ????????? -->	
					 	<a href="<c:url value='/user/myPage'/>"> ${userId} ???  ??????</a>
				    	<span> | </span>
				    	<a href="<c:url value='/user/logout'/>" style="padding-right : 10px;"> ????????????</a>
					<%} %>
				</div>
			</div>
		</header>
		<div id="container" class="main clearfix">
			<div class="main_content">
				<section class="section">
					<div class="recommand_book">
						<div class="rec_bookCover">
							<img src="https://pbs.twimg.com/media/EnFHZalVgAAiuJC?format=jpg&name=large" alt="??? ??????" class="coverImage">
						</div>
						<div class="rec_bookDesc">
							<p>??? ?????? ??? ?????? 
								<h1> ????????? ???</h1>
								<p>?????? ?????? ?????? ?????? ??????<br>
								??????????????? ??????????????? ??? ??? ??????<br>
								?????? ?????? ?????? ?????? ??????<br>
								?????? ?????? ?????? ????????? ???????????? ??????<br>
								?????? ?????? ???????????? ?????? ????????? ??????<br>
								?????? ?????? ???????????? ?????? ????????? ??????<br>
								???????????? ???????????? ?????? ????????? ??????<br>
								???????????? ???????????? ??????<br>
								??????????????? ????????? ?????? ???<br>
								??? ????????? ?????? ??? ????????? ??????<br>
								?????? ???????????? ?????? ?????????<br>
								?????? ????????? ????????? ????????? ????????????<br>
								??? ????????? ?????? ??? ????????? ??????<br>
								????????? ?????? ?????? ?????? ??? ????????? ??? ?????????</p>
							</p>
						</div>
					</div>
					<div class="go_category">
						<h3><b>&nbsp; *????????? ????????????</b></h3>
						<!-- ????????? ??? ???????????? ?????? ????????? ?????? -->
						<ul style="list-style: none;">
							<li><a href="<c:url value='/book/search'> 
									<c:param name="search_kw" value=""/>
									<c:param name="stype" value="all"/>
									<c:param name="stype_g" value="00"/>
								</c:url>"> ??????</a> </li>	
							<li><a href="<c:url value='/book/search'> 
									<c:param name="search_kw" value=""/>
									<c:param name="stype" value="all"/>
									<c:param name="stype_g" value="10"/>
								</c:url>"> ??????</a> </li>
							<li><a href="<c:url value='/book/search'> 
									<c:param name="search_kw" value=""/>
									<c:param name="stype" value="all"/>
									<c:param name="stype_g" value="20"/>
								</c:url>"> ??????</a> </li>
							<li><a href="<c:url value='/book/search'> 
									<c:param name="search_kw" value=""/>
									<c:param name="stype" value="all"/>
									<c:param name="stype_g" value="30"/>
								</c:url>"> ???????????? </a></li>
							<li><a href="<c:url value='/book/search'> 
									<c:param name="search_kw" value=""/>
									<c:param name="stype" value="all"/>
									<c:param name="stype_g" value="40"/>
								</c:url>"> ????????????</a> </li>
							<li><a href="<c:url value='/book/search'> 
									<c:param name="search_kw" value=""/>
									<c:param name="stype" value="all"/>
									<c:param name="stype_g" value="50"/>
								</c:url>"> ????????????</a></li>
							<li><a href="<c:url value='/book/search'> 
									<c:param name="search_kw" value=""/>
									<c:param name="stype" value="all"/>
									<c:param name="stype_g" value="60"/>
								</c:url>"> ??????</a> </li>
							<li><a href="<c:url value='/book/search'> 
									<c:param name="search_kw" value=""/>
									<c:param name="stype" value="all"/>
									<c:param name="stype_g" value="70"/>
								</c:url>"> ??????</a> </li>
							<li><a href="<c:url value='/book/search'> 
									<c:param name="search_kw" value=""/>
									<c:param name="stype" value="all"/>
									<c:param name="stype_g" value="81"/>
								</c:url>"> ?????????</a> </li>
							<li><a href="<c:url value='/book/search'> 
									<c:param name="search_kw" value=""/>
									<c:param name="stype" value="all"/>
									<c:param name="stype_g" value="82"/>
								</c:url>"> ?????????</a> </li>
							<li><a href="<c:url value='/book/search'> 
									<c:param name="search_kw" value=""/>
									<c:param name="stype" value="all"/>
									<c:param name="stype_g" value="83"/>
								</c:url>"> ?????????</a></li>
							<li><a href="<c:url value='/book/search'> 
									<c:param name="search_kw" value=""/>
									<c:param name="stype" value="all"/>
									<c:param name="stype_g" value="84"/>
								</c:url>"> ??????/??????</a> </li>
							<li><a href="<c:url value='/book/search'> 
									<c:param name="search_kw" value=""/>
									<c:param name="stype" value="all"/>
									<c:param name="stype_g" value="85"/>
								</c:url>"> SF</a> </li>
							<li><a href="<c:url value='/book/search'> 
									<c:param name="search_kw" value=""/>
									<c:param name="stype" value="all"/>
									<c:param name="stype_g" value="86"/>
								</c:url>"> ??????</a> </li>
							<li><a href="<c:url value='/book/search'> 
									<c:param name="search_kw" value=""/>
									<c:param name="stype" value="all"/>
									<c:param name="stype_g" value="87"/>
								</c:url>"> ??????</a> </li>
							<li><a href="<c:url value='/book/search'> 
									<c:param name="search_kw" value=""/>
									<c:param name="stype" value="all"/>
									<c:param name="stype_g" value="88"/>
								</c:url>"> ??????</a> </li>
							<li><a href="<c:url value='/book/search'> 
									<c:param name="search_kw" value=""/>
									<c:param name="stype" value="all"/>
									<c:param name="stype_g" value="90"/>
								</c:url>"> ?????? </a></li>
							<li><a href="<c:url value='/book/search'> 
									<c:param name="search_kw" value=""/>
									<c:param name="stype" value="all"/>
									<c:param name="stype_g" value="89"/>
								</c:url>"> ??????</a> </li>
						</ul>
					</div>
				</section>
			</div>
		</div>
		<footer id="footer">
			<div class="footer_area">
				<div class="list" >
					<ul style="width:100%" >
						<li> DBP ??? ???????????? </li>
						<li> ?????? ?????? ???????????? </li>
						<li> 3??? </li>
					</ul>
				</div>
			</div>
		</footer>
		
	</div>
</body>
</html>	

<%@page contentType="text/html; charset=utf-8" %>
<%@page import="java.util.*, model.*" %>
<%@page import="controller.user.*" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
	@SuppressWarnings("unchecked") 
	List<User> userList = (List<User>)request.getAttribute("userList");
	String curUserId = (String)request.getAttribute("curUserId");
--%>
<html>
<head>
<title>책 리스트 조회</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<style>
	
	@import url('https://fonts.googleapis.com/css2?family=Gaegu&family=Noto+Sans+KR&family=Yeon+Sung&display=swap');
	@import url('https://fonts.googleapis.com/css2?family=Nanum+Brush+Script&display=swap');
	
	body, div, span, p, a, font, ul, li, fieldset, form, legend{
		margin : 0;
		padding : 0;
		border : 0;
		line-height : 130%;
		
		border-radius: 10px 10px 10px 10px ;
	}
	table{
		width : 1170px;
		margin : 0 auto;
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
		width : 1150px;
		margin: 0 auto 0;
		padding-top : 25px;
		padding-bottom: 40px;
		padding-left: 20px;
		min-height : 600px;
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
	    height: 600px;
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
<body bgcolor=#FFFFFF text=#000000 leftmargin=0 topmargin=0 marginwidth=0 marginheight=0>
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
					<%} %>
				</div>
			</div>
		</header>
		</div>
		
<br>
<table style="width:100%">
  <tr>
  	<td width="20"></td>
  </tr>
  <tr><td>&nbsp;</td><td>&nbsp;</td></tr>
  <tr>
	<td width="20"></td>
	<td>
	  <table>
		<tr>
		  <td bgcolor="f4f4f4" height="22">&nbsp;&nbsp;<b>책 목록 조회 - 리스트</b>&nbsp;&nbsp;</td>
		</tr>
	  </table>  
	  <br>		  
	  <table style="background-color: YellowGreen">
		<tr>
		  <td width="190" align="center" bgcolor="E6ECDE" height="22">책 이름</td>
		  <td width="200" align="center" bgcolor="E6ECDE">isbn</td>
		  <td width="200" align="center" bgcolor="E6ECDE">작가</td>
		  <td width="200" align="center" bgcolor="E6ECDE">출판사</td>
		  <td width="200" align="center" bgcolor="E6ECDE">장르</td>
		</tr>
<%-- 
	if (userList != null) {	
	  Iterator<User> userIter = userList.iterator();
	
	  //사용자 리스트를 클라이언트에게 보여주기 위하여 출력.
	  while ( userIter.hasNext() ) {
		User user = (User)userIter.next();
--%>	  	
	  <c:forEach var="book" items="${bookList}">  			  	
  		<tr>
  		<td width="200" bgcolor="ffffff" style="padding-left: 10">
			  ${book.bookname}
		  </td>
  		<td width="200" bgcolor="ffffff" style="padding-left: 10">
			  ${book.bookinfoID}
		  </td>
		 
			<td width="200" bgcolor="ffffff" style="padding-left: 10">
			  ${book.writer}
		  </td>
		  <td width="200" align="center" bgcolor="ffffff" height="20">
		    ${book.publisher} 
		  </td>
		  <td width="200" align="center" bgcolor="ffffff" height="20">
		    ${book.category} 
		  </td>
		</tr>
	  </c:forEach> 
<%--
	  }
	}
--%>	 
	  </table>	  	 
	  <br>   
	</td>
  </tr>
</table>  
</body>
</html>
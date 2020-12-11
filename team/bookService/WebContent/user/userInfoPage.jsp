<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="controller.user.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>user Info Page</title>
<script type="text/javascript">
	function uploadBook() {
		var form = document.form;
		form.submit();
	}
	function checkSeller(){
		alert("먼저 판매자 등록부터 해주세요.")
	}
	function regiSeller(targetUri){
		var con = confirm("판매자로 등록하시겠습니까? \n 대여도서를 올릴 수 있게 됩니다.")
		if(con == true){
			var form = document.form;
			form.action = targetUri;
			form.submit();
		}
	}
	function updateInfo(){
		var form2 = document.form2;
		form2.submit();
	}
	function remove(targetUri) {
		var con = confirm("정말 탈퇴하시겠습니까? \n 올리신 대여도서 글을 내려갑니다.")
		if(con == true){
			var form2 = document.form2;
			form2.action = targetUri;
			form2.submit();
		}
	}
	function warning() {
		alert("거래 중인 도서가 있어 탈퇴할 수 없습니다.\n 거래 중 혹은 대여 중인 도서가 반납처리된 후 다시 시도해주세요.")
		
	}
</script>
<style>
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
		border-radius: 10px 10px 10px 10px ;
		postion : relative;
		width : 1100px;
		margin: 0 auto 0;
		padding-top : 25px;
		padding-bottom: 50px;
		min-height : 600px;
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
		margin-left : 5px;
		margin-right : 5px;
		margin-bottom: 9px;
	    zoom: 1;
	    position: relative;
	    z-index: 2;
	    display : block;
	}
	
	#userImg {
		background-color:#d5e3d5;
		margin : 5px;
		position: relative;
		float : left;
		width : 250px;
		min-height : 400px;
		overflow: hidden;
		color : #FFFFFF;
		font-weight : bolder;
		padding : 5px;
		padding-left : 10px;
		padding-top : 10px;
	}
	#userBookList {
		background-color:#FFFFFF;
		margin : 5px;
		float : left;
		width : 800px;
		min-height : 350px;
		overflow: hidden;
	}
	.fButton {
		float : right;
		margin-right : 20px;
		margin-top : 2px;
	}
	#lendBookList {
		background-color: #d5e3d5;
		min-height : 175px;
		color : #FFFFFF;
		font-weight : bolder;
		margin : 15px;
		padding : 5px;
		padding-left : 10px;
		padding-top : 10px;
	}
	#borrowBookList {
		background-color:#d5e3d5;
		color : #FFFFFF;
		min-height : 175px;
		font-weight : bolder;
		margin : 15px;
		padding : 5px;
		padding-left : 10px;
		padding-top : 10px;
	}
	#userInfo {
		width : 1050px;
		min-height : 200px;
		background-color:#FFFFFF;
		margin-left : 20px;
		margin-right : 10px;
		color : #FFFFFF;
		font-weight : bolder;
		padding-left : 20px;
	}
	
	.frame1 {
		min-height : 440px;
		margin : 0 auto;
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
					<div class = "frame1">
						<div id="userImg">
							 유저 대표 이미지<p>
							 <img src="./images/쏼라쏼라" alt="기본 이미지"> 
						 </div>
						<div id="userBookList">	<%! Boolean myDeal = false;%>		
							<div id="lendBookList"> 
								내가 올린 대여 도서 
								  <form name="form" class ="fButton" method="POST" action="<c:url value='/user/rbook/upload/form'/>">
									<input type="hidden" name = "memberid" value="${curMember.memberID}">
									<c:if test="${seller eq 1 }"> 
										<input type="button" value="새 대여도서 올리기" onClick="uploadBook()"> &nbsp; | &nbsp;
										<input type="button" value="판매자 등록" onClick="regiSeller()" disabled>
									</c:if>
									<c:if test="${seller eq 0}">
							  			<input type="button" value="새 대여도서 올리기" onClick="checkSeller()"> &nbsp; | &nbsp;
							  			<input type="button" value="판매자 등록" onClick="regiSeller('<c:url value='/user/register/seller'/>')">
							  		</c:if>
							 	 </form>
								<table>
									<!--  도서 목록이 많을 경우 짤릴 것을 대비해 ... 생략 기호 포함, 목록 보여줄 때 까지 늘리는 법 생각. -->
									 <tr>
										<c:forEach var="rbook" items="${rBookList}">  
											<c:if test="${rbook.state == 0}">			  	
								  		 		<td align="center"> <a href ="<c:url value='/user/rbook/info'>
						  		 					<c:param name="rbookID" value="${rbook.bookID}" />
						  		 				</c:url>"> ${rbook.bookname} </a> &nbsp; | &nbsp; </td>
					  		 				</c:if>
							  			</c:forEach>
							  		</tr>
							  	</table> 
							  	</br>
							  	거래 중인 대여 도서 
							  	<table>
									 <tr>
										<c:forEach var="rbook" items="${rBookList}">  
											<c:if test="${rbook.state == 1}">			 
												<% myDeal = true; %>	 	
								  		 		<td align="center"> <a href ="<c:url value='/user/rbook/info'>
						  		 					<c:param name="rbookID" value="${rbook.bookID}" />
						  		 				</c:url>"> ${rbook.bookname} </a> &nbsp; | &nbsp; </td>
					  		 				</c:if>
							  			</c:forEach>
							  		</tr>
							  	</table> 
							</div>
							<div id="borrowBookList">
								대여 중인 책
								<!-- 리뷰 관리할 버튼 위치 : form에  action 추가. button에 onClick 추가해서 사용하세요.
									(버튼 클릭 시 review 관련 페이지로 이동하는 느낌으로... ) 
									여기서는 memberID를 이용하여 review를 검색하여 내 리뷰를 볼 수 있고, 수정. 삭제가 가능하게 하면 됩니다.
								 -->
								<form name="reviewForm" class = "fButton" method="POST" >
									<input type="hidden" name = "memberid" value="${curMember.memberID}">
							  		<input type="button" value="내 리뷰 관리">
							 	 </form>
								<table>
									 <tr>
										<c:forEach var="ibook" items="${rInfoList}">  	
											<c:if test="${ibook.state == 1}">	
												<% myDeal = true; %>	  	
								  		 		<td align="center"> <a href ="<c:url value='/user/ibook/info'>
						  		 					<c:param name="ibookID" value="${ibook.bookID}" />
						  		 					<c:param name="irentalID" value="${ibook.rentalID}" />
						  		 				</c:url>"> ${ibook.bookname} </a> , </td>
					  		 				</c:if>
							  			</c:forEach>
							  		</tr>
							  	</table> 
							  	</br>
							  	이전에 읽은 책 (대여 완료)
							  	<table>
									 <tr>
										<c:forEach var="ibook" items="${rInfoList}">  	
											<c:if test="${ibook.state == 0}">		  	
								  		 		<td align="center"> <a href ="<c:url value='/user/ibook/info'>
						  		 					<c:param name="ibookID" value="${ibook.bookID}" />
						  		 					<c:param name="irentalID" value="${ibook.rentalID}" />
						  		 				</c:url>"> ${ibook.bookname} </a> , </td>
					  		 				</c:if>
							  			</c:forEach>
							  		</tr>
							  	</table> 
							</div>
						</div>
					</div>
					<div id="userInfo"> 
						<p>개인 정보</p>
						<font color="black">
						이름 : ${curMember.name} </br>
						이메일 : ${curMember.email} </br>
						주소 : ${curMember.address} </br>
						포인트 : ${curMember.point} </br>
						등급 (멤버 / 판매자) : ${curMember.memberGrade} /  ${curMember.sellerGrade} <br>
						</font>
						&nbsp;&nbsp;
						<form name="form2" method="GET" action="<c:url value='/user/update'/>">
							<input type="button" value="수정하기" onClick="updateInfo()"> &nbsp; | &nbsp;
							<%if(myDeal == false){ %>
				  				<input type="button" value="탈퇴하기" onClick="remove('<c:url value='/user/remove'/>')">
				  			<%} else { %>
				  				<input type="button" value="탈퇴하기" onClick="warning()">
				  			<%} %>
				  			
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
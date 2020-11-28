<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내가 대여하는 책</title>
</head>
<body>
	<div>
		<form>
			 제목 : <input type="readonly" value = "${rBook.bookname }">
			 출판사 : <input type="readonly" value = " "> 
			 작가 : <input type="readonly" value = " "> 
			 장르 : <input type="readonly" value = " "> 
			<c:if test="${rBook.state ==  1}"> <!-- 대여 중일 경우 -->
				대여 상태 : <input type="readonly" value = "O ">
				포인트 : <input type="readonly" value = " "> 
				책 소개 : <input type="readonly" value = " "> 
				책 상태 : <input type="readonly" value = " ">
				<input type="button" value = "확인" onClick=""> 
			</c:if>
			<c:if test="${rBook.state ==  0}"> <!-- 대여 중일 아닐 경우 -->
				대여 상태 : <input type="readonly" value = "X ">
				포인트 : <input type="text" value = " "> 
				책 소개 : <input type="text" value = " "> 
				책 상태 : <input type="text" value = " ">
				<input type="button" value = "수정/확인" onClick="">
				<input type="button" value = "도서 내리기" onClick="">  
			</c:if>
		</form>
	</div>
</body>
</html>
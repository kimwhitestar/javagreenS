<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctxPath" value="${pageContext.request.contextPath}"/>
<c:set var="newLine" value="\n" scope="page" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>memberDetail.jsp</title>
    <jsp:include page="/include/bs4.jsp" />
    <style></style>
    <script>
    	'use strict';
    </script>
</head>
<body>
<!-- Nav Menu -->
<jsp:include page="/common/menu.jsp" />

<!-- Header -->
<jsp:include page="/common/header.jsp" />

<!-- Page content -->
<div class="w3-content w3-padding" style="max-width:100%">
<br>
    <h2>회원정보 상세조회</h2>
    <br/>
	<table class="table">
		<tr><td>아이디 : ${vo.mid}</td></tr>
		<tr><td>별명 : ${vo.nickName}</td></tr>
		<tr><td>성명 : ${vo.name}</td></tr>
		<tr><td>성별 : ${vo.gender}</td></tr>
		<tr><td>생일 : ${vo.birthday}</td></tr>
		<tr><td>전화번호 : ${vo.tel}</td></tr>
		<tr><td>주소 : ${vo.address}</td></tr>
		<tr><td>이메일 : ${vo.email}</td></tr>
		<tr><td>홈페이지 : ${vo.homepage}</td></tr>
		<tr><td>직업 : ${vo.job}</td></tr>
		<tr><td>취미 : ${vo.hobby}</td></tr>
		<tr><td>자기소개 : ${fn:replace(vo.content, newLine, '<br>')}</td></tr>
		<tr><td>회원등급 : ${vo.levelName}</td></tr>
		<tr><td>총방문횟수 : ${vo.visitCnt}</td></tr>
		<tr><td>가입일자 : ${vo.startDate}</td></tr>
		<tr><td>마지막방문일자 : ${vo.lastDate}</td></tr>
		<tr><td>오늘방문횟수 : ${vo.todayCnt}</td></tr>
		<tr><td>사진 : <img src="${ctxPath}/img_member/${vo.photo}" width="100px"/></td></tr>
	</table>
<!-- End page content -->
</div>

<!-- Footer -->
<jsp:include page="/common/footer.jsp" />
</body>
</html>
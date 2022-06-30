<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctxPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title></title>
    <%@ include file="/include/bs4.jsp" %>
    <style>
    	p { font-size: 16pt}
    </style>
    <script>
    	'use strict';
    	function logoutCheck() {
    		parent.location.href = "${ctxPath}/adminLogout.adm";
    	}
    </script>
</head>
<body class="bg-info text-white">
<p><br></p>
<div class="container" style="margin-top:30px">
  <div class="row">
    <div class="col">
	<h2>관리자 메뉴</h2>
	<hr/>
	<p><a href="${ctxPath}/" target="_top" class="text-light">홈으로</a></p>
	<p><a href="${ctxPath}/adminMemberList.adm" target="adminContent" class="text-light">회원관리</a></p>
	<p><a href="${ctxPath}/adminGuestList.adm" target="adminContent" class="text-light">방명록</a></p>
	<p><a href="${ctxPath}/adminBoardList.adm" target="adminContent" class="text-light">게시판</a></p>
	<p><a href="${ctxPath}/" target="adminContent" class="text-light">PDS</a></p>
	<p><a href="${ctxPath}/" target="adminContent" class="text-light">자료실</a></p>
	<p><a href="javascript:logoutCheck()"  class="text-light">로그아웃</a></p>
	</div>
  </div>
</div>
</body>
</html>
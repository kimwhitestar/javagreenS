<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctxPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title></title>
    <style></style>
    <script>
    	'use strict';
    	
    </script>
</head>
<body>
<p><br></p>
<div class="container">
	<h2>이용에 불편을 주어 죄송합니다</h2>
	<h3>빠른 시일내에 복수하겠습니다</h3>
	<hr/>
	<div class="text-center"><img src="${ctxPath}/images/m1.jpg" width="300px" /></div>
	<hr/>
	<p><a href="${ctxPath}/study/transaction/personInput" class="btn btn-secondary" />돌아가기</p>
</div>
</body>
</html>
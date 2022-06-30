<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctxPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>adminMain.jsp</title>
    <%@ include file="/include/bs4.jsp" %>
    <style></style>
    <script>
    	'use strict';
    </script>
    <frameset cols="13%, 87%">
    	<frame src="${ctxPath}/adminLeft.adm" name="adminLeft" frameborder="0"/>
    	<frame src="${ctxPath}/adminContent.adm" name="adminContent" frameborder="0"/>
    </frameset>
</head>
</html>
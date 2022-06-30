<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctxPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>message.jsp</title>
  <jsp:include page="/include/bs4.jsp"></jsp:include>
  <script>
  'use strict';
  let msg = '${msg}';
  let url = '${ctxPath}/${url}';
  
  alert(msg);
  if (url != '') location.href = url;
  </script>
</head>
<body>
  <p><br></p>
  
  <p><br></p>
</body>
</html>
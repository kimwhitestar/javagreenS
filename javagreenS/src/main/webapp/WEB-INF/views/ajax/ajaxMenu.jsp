<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctxPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>title</title>
  <jsp:include page="${ctxPath}/include/bs4.jsp" />
  <script>
  'use strict';
  
  </script>
</head>
<body>
<!-- Nav Menu -->
<jsp:include page="${ctxPath}/common/menu.jsp" />

<!-- Header -->
<jsp:include page="${ctxPath}/common/header.jsp" />

<!-- Page content -->
<div class="w3-content w3-padding" style="max-width:100%">
<br>
  <h2>AJax Study</h2>
  <hr/>
  <p>
  	배열 : <a href="${ctxPath}/study/ajaxTest1" class="btn btn-primary">시(도)/구(동) String배열</a>&nbsp;
  	리스트 : <a href="${ctxPath}/study/ajaxTest2" class="btn btn-primary">시(도)/구(동) List</a>&nbsp;
  	맵 : <a href="${ctxPath}/study/ajaxTest3" class="btn btn-primary">시(도)/구(동) HashMap</a>
  </p>
  <p>
  	응용(vo) : <a href="${ctxPath}/study/ajaxTest4" class="btn btn-primary">시(도)/구(동) VO</a>&nbsp;
  </p>
<!-- End page content -->
</div>
<!-- Footer -->
<jsp:include page="${ctxPath}/common/footer.jsp" />
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctxPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>pwdCheck1.jsp</title>
  <jsp:include page="/include/bs4.jsp" />
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
  <form name="encDecForm" method="post">
	  <h2>비밀번호 암호화 연습</h2>
	  <hr/>
	  <p>
	  	<input type="password" name="pwd" id="pwd" maxlength="10" autofocus />&nbsp;
	  	<input type="submit" name="암호화" class="btn btn-danger" />
	  </p>
	  <hr/>
	  <p>
	  	암호화 결과 <br>
	  	원본 : ${pwd}<br>
	  	암호화 : <font color="red"><b>${encPwd}</b></font><br>
	  	복호화 : <font color="blue"><b>${decPwd}</b></font>
	  </p>
  </form>
<!-- End page content -->
</div>
<!-- Footer -->
<jsp:include page="/common/footer.jsp" />
</body>
</html>
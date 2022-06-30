<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctxPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>title</title>
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
  <form method="post">
  	<h2>비밀번호 확인</h2>
  	<hr/>
  	<table class="table table-border">
  		<tr>
  			<th>비밀번호</th>
  			<td><input type="password" name="pwd" autofocus class="form-control" required /></td>
  		</tr>
  		<tr>
  			<td colspan="2">
				<input type="submit" value="비밀번호확인" class="btn btn-secondary" /> &nbsp;
				<input type="reset" value="다시입력" class="btn btn-secondary" /> &nbsp;
				<input type="button" value="돌아가기" class="btn btn-secondary" onclick="location.href='memberMain'"/> &nbsp;
  			</td>
		</tr>
  	</table>
  </form>
<!-- End page content -->
</div>
<!-- Footer -->
<jsp:include page="/common/footer.jsp" />
</body>
</html>
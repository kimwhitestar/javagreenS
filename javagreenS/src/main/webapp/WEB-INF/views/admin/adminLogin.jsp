<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctxPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>adminLogin.jsp</title>
  <%@ include file="/include/bs4.jsp" %>
    <style></style>
    <script>
    	'use strict';
    </script>
</head>
<body>
<%@ include file="/include/header_home.jsp" %>
<%@ include file="/include/nav.jsp" %>
<p><br></p>
<div class="container">
  <form name="myForm" method="post" action="${ctxPath}/adminLoginOk.adm">
  	<table class="table table-bordered text-center">
  	  <tr>
  	    <td colspan="2"><h3>관 리 자 로 그 인</h3></td>
  	  </tr>
  	  <tr>
  	  	<th class="bg-secondary text-white">아이디</th>
  	  	<td><input type="text" name="mid" value="${mid}" autofocus class="form-control"/></td>
  	  </tr>
  	  <tr>
  	  	<th class="bg-secondary text-white">비밀번호</th>
  	  	<td><input type="password" name="pwd" value="1234" class="form-control"/></td>
  	  </tr>
  	  <tr>
  	    <td colspan="2">
  	      <button type="submit" class="btn btn-success">관리자 로그인</button> &nbsp;&nbsp;
  	      <button type="reset" class="btn btn-success">다시입력</button> &nbsp;&nbsp;
  	      <button type="button" class="btn btn-success" onclick="javascript:history.back();">돌아가기</button> &nbsp;&nbsp;
  	    </td>
  	  </tr>
  	</table>
  </form>
</div>
<%@ include file="/include/footer.jsp" %>
</body>
</html>
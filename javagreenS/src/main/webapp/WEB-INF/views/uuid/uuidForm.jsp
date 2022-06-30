<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctxPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>uuidForm.jsp</title>
  <jsp:include page="${ctxPath}/include/bs4.jsp" />
  <script>
  'use strict';
  let str = "";
  let i = 0;
  
  function uuidCheck() {
	$.ajax({
		type : "post",
		url : "${ctxPath}/study/uuidCheck",
		success : function(res) {
			i++;
			str += i + " : " + res : "<br>";
			$("#demo").html(str);
		},
		error : function() {
			alert('전송오류~~');
		}
	});  
  }
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
  <h2>UUID에 대하여</h2>
  <p>
  UUID(Universally Unique Indentifier)란, 네트워크상에서 고유성이 보장되는 id를 만들기 위한 규칙
  32자리의 16진수(128bit)로 표현된다<br>
  표시형식 : 8-4-4-4-12 난수 자리로 표현한다<br>
  예 : 550e840-f124-31d4-a123-3242ek658339
  </p>
  <hr/>
  <p>
  	<input type="button" value="UUID생성" onclick="uuidCheck()" />
  </p>
  <hr/>
  <div>
  	출력결과<br>
  	<span id="demo"></span>
  </div>
<!-- End page content -->
</div>
<!-- Footer -->
<jsp:include page="${ctxPath}/common/footer.jsp" />
</body>
</html>
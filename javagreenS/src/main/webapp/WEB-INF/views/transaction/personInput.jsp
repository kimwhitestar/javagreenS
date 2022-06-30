<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctxPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title></title>
    <%-- <%@ include file="/include/bs4.jsp" %> --%>
    <style></style>
    <script>
    	'use strict';
    	
    </script>
</head>
<body>
    <%-- <%@ include file="/include/header_home.jsp" %>
    <%@ include file="/include/nav.jsp" %> --%>
<p><br></p>
<div class="container">
	<pre>
	<h2>인적 자원 정보 등록하기</h2>
	두개의 자료를 동시에 입력처리시키고자 할때,
	1개의 자료가 먼저 입력되고,
	2번째 자료처리에서 문제가 발생된다면,
	이때 기존에 입력된 1번째 자료도 다시 입력을 거둬줘야한다.  - 롤백
	따라서 두개 테이블이 모두 입력처리되지 않도록 처리하여,
	입력전과 같은 상태로 만들어주는 것이 주 목적이다. (원자성)
	</pre>
	<hr/>
	<form name="myForm" method="post">
		<h2>인적자원등록</h2>
		<table class="table table-bordered text-center">
			<tr>
				<th>아이디</th>
				<td><input type="text" name="mid" class="form-control"/></td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td><input type="text" name="pwd" class="form-control"/></td>
			</tr>
			<tr>
				<th>성명</th>
				<td><input type="text" name="name" class="form-control"/></td>
			</tr>
			<tr>
				<th>나이</th>
				<td><input type="text" name="age" value="20" class="form-control"/></td>
			</tr>
			<tr>
				<th>주소</th>
				<td><input type="text" name="address" class="form-control"/></td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="submit" value="등록" class="btn btn-secondary"/> &nbsp;
					<input type="reset" value="취소" class="btn btn-secondary"/> &nbsp;
					<input type="button" value="돌아가기" onclick="location.href='personList'" class="btn btn-secondary"/> &nbsp;
				</td>
			</tr>
		</table>
	</form>

</div>
   <%--  <%@ include file="/include/footer.jsp" %> --%>
</body>
</html>
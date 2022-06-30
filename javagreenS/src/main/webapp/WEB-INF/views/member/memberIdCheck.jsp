<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctxPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title></title>
    <jsp:include page="/include/bs4.jsp" />
    <style></style>
    <script>
    	'use strict';
    	function setIdToParent() {
    		//아이디중복체크flg =yn 후 close()필요
    		opener.window.document.joinForm.mid.value = '${mid}';
    		opener.window.document.joinForm.pass.focus();
    		window.close();
    	}
    	//중복 아이디 다시 체크
    	function checkId() {
    		let mid = childForm.mid.value;
    		if ('' == mid.trim()) {
    			alert('아이디를 입력하세요.')
    			childForm.mid.value = '';
    			childForm.mid.focus();
    		} else {
    			childForm.submit();
    		}
    	}
    </script>
</head>
<body>
<p><br></p>
<div class="container text-center">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="container p-3 border text-center bg-light">
			<h2 class="table-card text-dark">아이디 체크</h2>
			<c:if test="${'N' == existIdYN}">
				<h5><font color="blue">${mid}</font>아이디는 사용가능합니다</h5>
				<p><input type="button" value="창닫기" onclick="setIdToParent()"/></p>
			</c:if>
			<c:if test="${empty existIdYN || 'Y' == existIdYN}">
				<c:if test="${empty existIdYN}">
					<h5>아이디를 입력하세요</h5>
				</c:if>
				<c:if test="${'Y' == existIdYN}">
					<h5>입력한 아이디 <font color="red">${mid}</font>는 이미 사용중인 아이디입니다</h5>
				</c:if>
				<form name="childForm" method="post" action="${ctxPath}/memberIdCheck.mbr"/>
					<p>
						<input type="text" id="mid" name="mid" />
						<input type="button" value="아이디검색" onclick="checkId()"/>
					</p>
				</form>
			</c:if>
			</div>
		</div>
	</div>
</div>
</body>
</html>
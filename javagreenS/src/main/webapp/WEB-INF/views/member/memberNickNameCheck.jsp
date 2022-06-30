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
    	function setNickNameToParent() {
        	opener.window.document.joinForm.nickName.value = '${nickName}';
    		opener.window.document.joinForm.name.focus();
    		window.close();
    	}
    	//중복 닉네임 다시 체크
    	function checkNickName() {
    		let nickName = childForm.nickName.value;
    		if ('' == nickName.trim()) {
    			alert('닉네임을 입력하세요.')
    			childForm.nickName.focus();
    		} else {
    			childForm.submit();
    		}
    	}
    </script>
</head>
<body>
<p><br></p>
<div class="container form-text-center">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="container p-3 border text-center bg-light">
			<h2 class="table-card text-dark">닉네임 체크</h2><br>
			<c:if test="${'N' == existNickNameYN}">
				<h5><font color="blue" >${nickName}</font>닉네임은 사용가능합니다</h5>
				<p><input type="button" value="창닫기" onclick="setNickNameToParent()"/></p>
			</c:if>
			<c:if test="${empty existNickNameYN || 'Y' == existNickNameYN}">
				<c:if test="${empty existNickNameYN}">
					<h5>닉네임을 입력하세요</h5>
				</c:if>
				<c:if test="${'Y' == existNickNameYN}">
					<h5>입력한 닉네임 <font color="red">${nickName}</font>은 이미 사용중인 아이디입니다</h5>
				</c:if>
				<form name="childForm" method="post" action="${ctxPath}/memberNickNameCheck.mbr"/>
					<p>
						<input type="text" id="nickName" name="nickName"/>
						<input type="button" class="btn-info" value="닉네임검색" onclick="checkNickName()"/>
					</p>
				</form>
			</c:if>
			</div>
		</div>
	</div>
</div>
</body>
</html>
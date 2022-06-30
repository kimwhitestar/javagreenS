<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctxPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>memberIdPwdFindout.jsp</title>
    <jsp:include page="/include/bs4.jsp" />
    <style></style>
    <script>
    	'use strict';
    	function sendId() {
    		opener.window.document.loginForm.mid.value = '${mid}';
    		window.close();
    	}
    	function sendPwd() {
    		opener.window.document.loginForm.pwd.value = '${pwd}';
    		window.close();
    	}
    	function findoutId() {
    		findIdForm.submit();
    	}
	</script>
</head>
<body>
111111<c:out value="${existIdYN}"/>
<div class="container">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="container p-3 border">
				<c:if test="${'Y' == existIdYN}">
					<h4><font color="blue">회원님의 아이디는 ${mid}입니다</font></h4>
					<p><input type="button" value="창닫기" onclick="sendId()"/></p>
				</c:if>
				<c:if test="${empty existIdYN || 'N' == existIdYN}">
					<h4><font color="blue">아이디 찾기 </font></h4>
					<form name="findIdForm" method="post" action="${ctxPath}/memberIdFindoutOk" class="was-validated">
						<h2>아 이 디  찾 기</h2>
						<p>가입한 이메일과 비밀번호를 입력해 주세요</p>
						<div class="form-group">
							<label for="email">이메일 : </label>
							<input type="text" class="form-control" name="email" placeholder="이메일을 입력하세요." required autofocus/>
							<div class="valid-feedback"></div>
							<div class="invalid-feedback">이메일은 필수 입력사항입니다.</div>
						</div>
						<div class="form-group">
							<label for="pwd">비밀번호 : </label>
							<input type="password" class="form-control" name="pwd" placeholder="비밀번호를 입력하세요." required />
							<div class="valid-feedback"></div>
							<div class="invalid-feedback">비밀번호는 필수 입력사항입니다.</div>
						</div>
						<div class="form-group">
							<button type="button" class="btn btn-secondary btn-sm" onclick="findoutId()">아이디 찾기</button> &nbsp;
							<button type="reset" class="btn btn-secondary btn-sm">다시작성</button> &nbsp;
							<button type="button" class="btn btn-secondary btn-sm" onclick="location.href='${ctxPath}/member/memberLogin';">돌아가기</button> &nbsp;
						</div>
					</form>
				</c:if>
			</div>
		</div>
	</div>
</div>
</body>
</html>
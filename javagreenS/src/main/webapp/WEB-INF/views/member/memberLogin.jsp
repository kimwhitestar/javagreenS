<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctxPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>memberLogin.jsp</title>
  	<jsp:include page="/include/bs4.jsp" />
    <style></style>
    <script>
    	'use strict';
    	function fCheck() {
    		loginForm.submit();
    	}
    	//아이디 찾기
    	function findoutId() {
    		let url = '${ctxPath}/memberIdFindout.mbr';
    		window.open(url,"idFindout","width=580px,height=380px");
    	}
    	//비밀번호 찾기
    	function changePwd() {
    		let url = '${ctxPath}/memberPwdChange.mbr';
    		window.open(url,"pwdFindout","width=580px,height=600px");
    	}
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
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="container p-3 border">
				<form name="loginForm" method="post" action="${ctxPath}/memberLoginOk.mbr" class="was-validated">
					<h2 class="text-center">Member Login</h2>
					<p class="text-center">회원 아이디와 비밀번호를 입력해 주세요</p>
					<div class="form-group">
						<label for="mid">아이디 : </label>
						<input type="text" class="form-control" name="mid" id="mid" value="${mid}" placeholder="아이디를 입력하세요." required autofocus/>
						<div class="valid-feedback"></div>
						<div class="invalid-feedback">아이디는 필수 입력사항입니다.</div>
					</div>
					<div class="form-group">
						<label for="pwd">비밀번호 : </label>
						<input type="text" class="form-control" name="pwd" id="pwd" value="1234" placeholder="비밀번호를 입력하세요." required />
						<div class="valid-feedback"></div>
						<div class="invalid-feedback">비밀번호는 필수 입력사항입니다.</div>
					</div>
					<div class="form-group text-center">
						<button type="button" class="btn btn-secondary btn-sm" onclick="fCheck()">로그인</button> &nbsp;
						<button type="reset" class="btn btn-secondary btn-sm">다시작성</button> &nbsp;
						<button type="button" class="btn btn-secondary btn-sm" onclick="location.href='${ctxPath}/';">돌아가기</button> &nbsp;
						<button type="button" class="btn btn-secondary btn-sm" onclick="location.href='${ctxPath}/memberJoin.mbr';">회원가입</button>
					</div>
					<div class="row" style="font-size:12px">
						<span class="col text-left"><input type="checkbox" name="idSave" checked />아이디 저장</span>
						<span class="col text-right"><a href="javascript:findoutId();">아이디 찾기</a> / <a href="javascript:changePwd();">비밀번호 찾기</a></span>
					</div>
				</form>
			</div>
		</div>
	</div>
<!-- End page content -->
</div>

<!-- Footer -->
<jsp:include page="/common/footer.jsp" />
</body>
</html>
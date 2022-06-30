<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctxPath" value="${pageContext.request.contextPath}"/>
<script>
	function memberDeleteCheck() {
		if ( confirm('탈퇴하겠습니까?') ) {
			location.href = '${ctxPath}/member/memberDelete';
		}
	}
</script>

<!-- Navbar (sit on top) -->
<div class="w3-top">
  <div class="w3-bar w3-white w3-wide w3-padding w3-card">
	<a class="w3-bar-item w3-button w3-padding-large w3-hide-medium w3-hide-large w3-right" href="javascript:void(0)" onclick="myFunction()" title="Toggle Navigation Menu"><i class="fa fa-bars"></i></a>
    <a href="${ctxPath}/" class="w3-bar-item w3-button w3-padding-large"><b>홈으로</b></a>
	<div class="w3-dropdown-hover w3-hide-small">
		<button class="w3-padding-large w3-button" title="More">연습<i class="fa fa-caret-down"></i></button>
		<div class="w3-dropdown-content w3-bar-block w3-card-4">
      	  <a href="${ctxPath}/study/ajaxMenu" class="w3-bar-item w3-button">Ajax 연습 (Spring)</a>
	      <a href="${ctxPath}/study/pds/fileUpload" class="w3-bar-item w3-button">파일업로드 연습</a>
	      <a href="${ctxPath}/study/uuid/uuidForm" class="w3-bar-item w3-button">UUID 연습</a>
		</div>
	</div>
<c:if test="${sLevel <= 4}">
    <a href="${ctxPath}/board/boardList" class="w3-bar-item w3-button">게시판</a>
    <a href="${ctxPath}/pds/pdsList" class="w3-bar-item w3-button">자료실</a>
	
	<div class="w3-dropdown-hover w3-hide-small">
		<button class="w3-padding-large w3-button" title="More">${sNickName}<i class="fa fa-caret-down"></i></button>
		<div class="w3-dropdown-content w3-bar-block w3-card-4">
	      <a href="${ctxPath}/member/memberMain" class="w3-bar-item w3-button">회원메인</a>
	      <a href="${ctxPath}/member/memberList" class="w3-bar-item w3-button">회원목록</a>
	      <a href="${ctxPath}/member/memberUpdate" class="w3-bar-item w3-button">회원정보수정</a>
	      <a href="jvaascript:memberDeleteCheck()" class="w3-bar-item w3-button">회원탈퇴</a>
	      <c:if test="${0 == sLevel}">
	      	<a href="${ctxPath}/admin/adminMain" class="w3-bar-item w3-button">관리자메뉴</a>
	      </c:if>
		</div>
	</div>
</c:if>
    <c:if test="${empty sLevel}"><a href="${ctxPath}/member/memberLogin" class="w3-bar-item w3-button">로그인</a></c:if>
    <c:if test="${!empty sLevel}"><a href="${ctxPath}/member/memberLogout" class="w3-bar-item w3-button">로그아웃</a></c:if>
	<a href="javascript:void(0)" class="w3-padding-large w3-hover-red w3-hide-small w3-right"><i class="fa fa-search"></i></a>
  </div>
</div>
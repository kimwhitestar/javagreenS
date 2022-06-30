<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctxPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>adminContent.jsp</title>
	<%@ include file="/include/bs4.jsp" %>
	<style>
	.dashimg {
	    height: 550px;
	    background: #ddd;
	}
	</style>
    <script>
    	'use strict';
    </script>
</head>
<body>
<p><br></p>
<div class="container" style="margin-top:30px">
  <div class="row">
    <div class="col-sm-4">
      <h3 class="p-2 text-left">전체 회원 목록</h3>
      <h6 class="text-left">회원 명단</h6>
      <div class="dashimg">
        <table class="table table-bordered text-center m-0">
          <tr class="text-white bg-info">
            <th>아이디</th>
            <th>닉네임</th>
          </tr>
	        <c:forEach var="i" begin="0" end="${adminMemberVos.size() > 9 ? 9 : adminMemberVos.size()}">
	          <tr>
	             <td>${adminMemberVos[i].mid}</td>
	             <td>${adminMemberVos[i].nickName}</td>
	           </tr>
	        </c:forEach>
	      </table>
      </div>
      <h3 class="text-left">접속 회원 목록</h3>
      <h6 class="text-left">최근에 접속한 회원 명단</h6>
      <div class="dashimg">
        <table class="table table-bordered text-center m-0">
          <tr class="text-white bg-info">
            <th>아이디</th>
            <th>닉네임</th>
          </tr>
	        <c:forEach var="i" begin="0" end="${recentlyLoginMemberVos.size() > 9 ? 9 : recentlyLoginMemberVos.size()}">
	          <tr>
	             <td>${recentlyLoginMemberVos[i].mid}</td>
	             <td>${recentlyLoginMemberVos[i].nickName}</td>
	           </tr>
	        </c:forEach>
	      </table>
		</div>
    </div>
    <div class="col-sm-4">
      <h3 class="p-2 text-left">신규 가입 회원</h3>
      <h6 class="text-left">최근에 가입한 회원 명단</h6>
      <div class="dashimg">
        <table class="table table-bordered text-center m-0">
          <tr class="text-white bg-info">
            <th>아이디</th>
            <th>닉네임</th>
          </tr>
	        <c:forEach var="i" begin="0" end="${recetylyEntryMemberVos.size() > 9 ? 9 : recetylyEntryMemberVos.size()}">
	          <tr>
	             <td>${recetylyEntryMemberVos[i].mid}</td>
	             <td>${recetylyEntryMemberVos[i].nickName}</td>
	           </tr>
	        </c:forEach>
	      </table>
      </div>
      <h3 class="text-left">탈퇴 회원</h3>
      <h6 class="text-left">최근에 탈퇴한 회원 명단</h6>
      <div class="dashimg">
        <table class="table table-bordered text-center m-0">
          <tr class="text-white bg-info">
            <th>아이디</th>
            <th>닉네임</th>
          </tr>
	        <c:forEach var="i" begin="0" end="${pracLeaveMemberVos.size() > 9 ? 9 : pracLeaveMemberVos.size()}">
	          <tr>
	             <td>${pracLeaveMemberVos[i].mid}</td>
	             <td>${pracLeaveMemberVos[i].nickName}</td>
	           </tr>
	        </c:forEach>
	      </table>
		</div>
    </div>
    <div class="col-sm-8">
      <h3 class="text-left p-2">게시판 신규자료</h3>
      <h6 class="text-left">최근에 게시된 글</h6>
      <div class="dashimg">
        <table class="table table-bordered text-center m-0">
          <tr class="text-white bg-info" >
            <th width="38%">올린이</th>
            <th width="62%">글제목</th>
          </tr>
	        <c:forEach var="i" begin="0" end="${adminBoardVos.size() > 9 ? 9 : adminBoardVos.size()}">
	          <tr>
	             <td>${adminBoardVos[i].nickName}</td>
	             <td>${adminBoardVos[i].title}</td>
	           </tr>
	        </c:forEach>
	      </table>
      </div>
      <p></p>
      <p></p>
      <br>
      <h3 class="text-left p-2">방명록 신규자료</h3>
      <h6 class="text-left">최근에 게시된 방명록</h6>
      <div class="dashimg">
        <table class="table table-bordered text-center m-0">
          <tr class="text-white bg-info" >
            <th width="68%">내용</th>
            <th width="32%">방문자</th>
          </tr>
	        <c:forEach var="i" begin="0" end="${adminGuestVos.size() > 9 ? 9 : adminGuestVos.size()}">
	          <tr >
	             <td>${adminGuestVos[i].content}</td>
	             <td>${adminGuestVos[i].name}</td>
	           </tr>
	        </c:forEach>
	      </table>
      </div>
    </div>
  </div>
</div>
</body>
</html>
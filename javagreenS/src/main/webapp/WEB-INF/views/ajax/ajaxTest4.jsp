<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctxPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>ajaxTest4.jsp</title>
  <jsp:include page="/include/bs4.jsp" />
  <script>
  'use strict';
  //Jquery
  function fCheck() {
	  let oid = $("#oid").val();
	  if ('' == oid) {
		  alert('아이디를 입력하세요');
		  $("#oid").focus();
		  return false;
	  }
	  
	  $.ajax({
		  type : "post",
		  url : "${ctxPath}/study/ajaxTest4",
		  data : {oid : oid},
		  success : function(resVO) {
			  //if (null == resVO)
			  if ('' == resVO) { //이거 에러안나나? jsp에서 ajax가 null을 공백으로 바꿔서 받나? 원래 ajax는 null응답 못받는데?
				  $("#demo").html('<font color="red">아이디 조회 결과 없음</font>');
			  }
			  $("#demo").html(resVO.mid);
		  },
		  error : function() {
			  alert('전송오류!');
		  }
	  });
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
  <h2>Ajax를 활용한 응답값 받기(VO)</h2>
  <hr/>
  <h3>회원id 조회</h3>
  <form name="ajaxForm">
	<input type="text" name="oid" autofocus />&nbsp;
  	<input type="button" value="조회" class="btn btn-primary" onclick="fCheck()"/>&nbsp;
  	<input type="reset" value="취소" class="btn btn-primary"/>&nbsp;
  	<input type="button" value="돌아가기" class="btn btn-primary" onclick="location.href='${ctxPath}/study/ajaxMenu'"/>
	<div id="demo"></div>
  </form>
<!-- End page content -->
</div>
<!-- Footer -->
<jsp:include page="/common/footer.jsp" />
</body>
</html>
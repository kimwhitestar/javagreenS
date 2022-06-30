<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctxPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>ajaxTest1.jsp</title>
  <jsp:include page="/include/bs4.jsp" />
  <script>
  'use strict';
  //Jquery
  $(function() {
	  $("#unitDo").change(function() {
		  let unitDo = $(this).val();
		  
		  $.ajax({
			  type : "post",
			  url : "${ctxPath}/study/ajaxTest1",
			  data : {unitDo : unitDo},
			  success : function(res) {
				  //console.log(res);
				  let str = '';
				  str += '<option value="">도시선택</option>';
				  for (let i=0; i<res.length; i++) {
					  if (null == res[i]) break;
					  str += '<option>'+ res[i] +'</option>';
				  }
				  $("#city").html(str);
			  },
			  error : function() {
				  alert('전송오류!');
			  }
		  });
	  });
  });
  
  function fCheck() {
	  let unitDo = $("#unitDo").val();
	  let unitKu = $("#unitKu").val();
	  
	  if (''==unitDo || ''==unitKu) {
		  alert('구를 선택하세요');
		  return false;
	  }
	  alert('선택한 지역은? ' + unitDo + ' / ' + unitKu);
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
  <h2>Ajax를 활용한 응답값 받기(String배열)</h2>
  <hr/>
  <h3>도시를 선택하세요</h3>
  <form name="ajaxForm">
  	<select id="unitDo">
	  	<option value="경성">경성</option>
	  	<option value="경상">경상</option>
	  	<option value="충북">충북</option>
	  	<option value="인천">인천</option>
	  	<option value="전라">전라</option>
	  	<option value="삼합도">삼합도</option>
  	</select>
  	<select id="unitKu"></select>
  	<input type="button" value="선택" class="btn btn-primary" onclick="fCheck()"/>&nbsp;&nbsp;
  	<input type="button" value="돌아가기" class="btn btn-primary" onclick="location.href='${ctxPath}/study/ajaxMenu'"/>&nbsp;&nbsp;
  </form>
<!-- End page content -->
</div>
<!-- Footer -->
<jsp:include page="/common/footer.jsp" />
</body>
</html>
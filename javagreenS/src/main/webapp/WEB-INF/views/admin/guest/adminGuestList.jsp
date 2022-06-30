<%@ page import="java.util.List"%>
<%@ page import="guest.database.GuestVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctxPath" value="${pageContext.request.contextPath}"/>
<c:set var="LF" value="\n" scope="page" />
<c:set var="BR" value="<br>" scope="page" />
<c:set var="First" value="<<" scope="page" />
<c:set var="Last" value=">>" scope="page" />
<c:set var="Prev" value="◁" scope="page" />
<c:set var="Next" value="▷" scope="page" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>adminGuestList.jsp</title>
    <%@ include file="/include/bs4.jsp" %>
    <style>
    	th {background-color: orange;}
    </style>
    <script>
    	'use strict';
    	function delCheck(idx) {
    		if (confirm('게시글을 삭제하겠습니까?')) {
    			$("#idx").val(idx);
    			guestForm.action = "${ctxPath}/guestDelete.gu";//Post요청
    			guestForm.submit();
    		}
    	}
    	//검색기 처리
    	function checkSearching() {
    		if ("" == $("#searchString").val()) {
    			$("#searchString").focus();
    		}
			$("#pageNo").val(1);
			guestForm.action = "${ctxPath}/adminGuestList.adm";//Post요청
    		guestForm.submit();
    	}
		function changePaging() {
			$("#pageNo").val(1);
			guestForm.action = "${ctxPath}/adminGuestList.adm";//Post요청
			guestForm.submit();
		}
    	function changePage(pageNo) {
    		$("#pageNo").val(pageNo);
    		guestForm.action = "${ctxPath}/adminGuestList.adm";//Post요청
    		guestForm.submit();
    	}
    </script>
</head>
<body>
<p><br></p>
<div class="container">
	<h2 class="text-center">관 리 자 방 명 록</h2>
	<form name="guestForm" method="post" action="${ctxPath}/adminGuestList.adm">
		<input type="hidden" id="pageNo" name="pageNo"/>
		<div class="m-2 row">
			<div class="col text-left">
			<c:if test="${!empty sAdmin && sAdmin == 'adminOk'}">
				<a href="${ctxPath}/adminLogout.adm" class="btn btn-secondary">관리자 로그아웃</a>
			</c:if>
			<!-- EL표기 empty - null, ""(공백) 모두 비교 -->
			<c:if test="${empty sAdmin || sAdmin != 'adminOk'}">
				<a href="${ctxPath}/adminLogin.adm" class="btn btn-secondary">관리자</a>
			</c:if>
				<a href="${ctxPath}/guestInput.gu" class="btn btn-secondary">글쓰기</a>
			</div>
			
			<div class="col text-center">
				<c:if test="${!empty searchString}">
					(<font color="blue">
					<c:choose>
						<c:when test="${'title'==searchCondition}"><c:out value="글제목" /></c:when>
						<c:when test="${'nickName'==searchCondition}"><c:out value="글쓴이" /></c:when>
						<c:when test="${'content'==searchCondition}"><c:out value="글내용" /></c:when>
						<c:otherwise><c:out value="" /></c:otherwise>
					</c:choose> 
					</font>)(으)로 
					<font color="blue">${searchString}(을)를 검색한 결과</font>
					<font color="blue">${searchCount}건이 검색됬습니다</font>
				</c:if>
			</div>
	
			<!-- 페이징 처리 시작 -->
			<div class="col text-right">
			<c:if test="${pageNo > 1}">
				<a href="javascript:changePage(1)" title='first'>${First}</a>
					<a href="javascript:changePage('${pageNo - 1}')" title='prev'>${Prev}</a>
			</c:if>
						${pageNo}Page / ${totPage}Pages
			<c:if test="${pageNo != totPage}">
					<a href="javascript:changePage('${pageNo + 1}')" title='next'>${Next}</a>
			</c:if>
				<a href="javascript:changePage('${totPage}')" title='last'>${Last}</a>
			</div>
			<!-- 페이징 처리 끝 -->

			<div class="text-right p-0">
				<select name="pageSize" id="pageSize" onchange="changePaging()">
					<option value="3"  ${3==pageSize  ? 'selected' : ''} >3건</option>
					<option value="5" ${5==pageSize ? 'selected' : ''} >5건</option>
					<option value="10" ${10==pageSize ? 'selected' : ''} >10건</option>
					<option value="20" ${20==pageSize ? 'selected' : ''} >20건</option>
					<option value="30" ${30==pageSize ? 'selected' : ''} >30건</option>
				</select>
			</div>	
		</div>
	
		<input type="hidden" id="idx" name="idx" />
		<c:forEach items="${vos}" var="vo">
			<table class="table table-borderless m-0 p-0">
				<tr>
					<td class="text-left pl-0">방문번호 : ${curScrStartNo}
					<!-- EL표기 empty - null, ""(공백) 모두 비교 -->
					<c:if test="${!empty sAdmin && sAdmin == 'adminOk'}">
						<%-- [<a href="${ctxPath}/guestDelete.gu?idx=<%=vo.getIdx()%>">삭제</a>] --%>
						[<a href="javascript:delCheck('${vo.idx}');">삭제</a>]
					</c:if>
					</td>
					<td class="text-right pr-0">방문IP : ${vo.hostIp}</td>
				</tr>
	    	</table>
		  	<table class="table table-bordered">
				<tr>
					<th width="16%" class="text-center">성명</th>
					<td width="34%">${vo.name}</td>
					<th width="16%" class="text-center">방문일자</th>
					<td width="34%">${vo.vDate}</td>
				</tr>
				<tr>
					<th class="text-center">전자우편</th>
					<!-- EL표기 empty - null, ""(공백) 모두 비교 -->
					<c:if test="${empty vo.email}">
						<td colspan="3">- 없음 -</td>
					</c:if>
					<c:if test="${!empty vo.email}">
						<td colspan="3">${vo.email}</td>
					</c:if>
				</tr>
				<tr>
					<th class="text-center">홈페이지</th>
					<c:if test="${empty vo.homepage}">
						<td colspan="3">- 없음 -</td>
					</c:if>				
					<c:if test="${!empty vo.homepage}">
						<td colspan="3"><a href='http://${vo.homepage}' target='_blank'>http://${vo.homepage}</a></td>
					</c:if>
				</tr>
				<tr>
					<th class="text-center">글내용</th>
					<td colspan='3' style='height:150px'>${vo.content.replace(LF,BR)}</td>
				</tr>
			</table>
			<c:set var="curScrStartNo" value="${curScrStartNo-1}"/>
		</c:forEach>	

		<!-- 블럭페이징 처리 시작 -->
		<div class="text-center">
			<div class="pagination justify-content-center">
			<c:if test="${pageNo > 1}">
				<li class="page-item"><a href='javascript:changePage(1)' title='first' class="page-link text-secondary" >첫페이지</a></li>
			</c:if>
			<c:if test="${curBlock > 0}">
				<li class="page-item"><a href="javascript:changePage('${(curBlock-1)*blockSize+1}')" title='prevBlock' class="page-link text-secondary" >이전블록</a>
			</c:if>
				<c:forEach var="i" begin="${(curBlock*blockSize)+1}" end="${(curBlock*blockSize)+blockSize}">
			      <c:if test="${i <= totPage && i == pageNo}">
			        <li class="page-item active"><a href="javascript:changePage('${i}')" class="page-link text-light bg-secondary border-secondary" >${i}</a>
			      </c:if>
			      <c:if test="${i <= totPage && i != pageNo}">
			        <li class="page-item"><a href="javascript:changePage('${i}')" class="page-link text-secondary" >${i}</a>
			      </c:if>
			    </c:forEach>
			<c:if test="${curBlock < lastBlock}">
				<li class="page-item"><a href="javascript:changePage('${(curBlock+1)*blockSize+1}')" title='nextBlock' class="page-link text-secondary" >다음블록</a>
			</c:if>
			<c:if test="${pageNo != totPage}">
			<li class="page-item"><a href="javascript:changePage('${totPage}')" title='last' class="page-link text-secondary" >마지막페이지</a>
			</c:if>
			</div>
		</div>
		<!-- 블럭페이징 처리 끝 -->
		<br>
		<!-- 검색키 처리 시작 -->
		<div class="container text-center">
			<select name="searchCondition" id="searchCondition" >
				<option value="title">글제목</option>
				<option value="nickName">글쓴이</option>
				<option value="content">글내용</option>
			</select>
			<input type="text" name="searchString" id="searchString"/>
			<input type="button" value="검색" onclick="checkSearching()"/>
		</div>
		<!-- 검색키 처리 끝 -->
	</form>
</div>
<br><br>
</body>
</html>
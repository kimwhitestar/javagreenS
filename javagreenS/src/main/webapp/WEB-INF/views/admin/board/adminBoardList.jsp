<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctxPath" value="${pageContext.request.contextPath}"/>
<c:set var="sAdmin" value="${sAdmin}" scope="session" />
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
    <title>adminBoardList.jsp</title>
    <%@ include file="/include/bs4.jsp" %>
    <style></style>
    <script>
    	'use strict';
    	function changeRecetlyYmd(ymd) {
    		if ('Y' == ymd) {
    		} else if ('M' == ymd) {
    		} else if ('D' == ymd) {
    		}
    	}
    	function changeRecetlyTerm(term) {
			boardForm.action = "${ctxPath}/adminBoardList.adm";//Post요청
			boardForm.submit();
    	}
    	//검색기 처리
    	function checkSearching() {
    		if ("" == $("#searchString").val()) {
    			$("#searchString").focus();
    		}
			$("#pageNo").val(1);
    		boardForm.action = "${ctxPath}/adminBoardList.adm";//Post요청
    		boardForm.submit();
    	}
    	//게시글 상세조회
    	function goBoardDetail(idx) {
    		$("#idx").val(idx);//요청 파라미터 설정(게시판 목록에서 게시글 상세조회시 글번호로 조회 요청)
    		boardForm.action = "${ctxPath}/boardDetail.bd";//Post요청
    		boardForm.submit();
    	}
    	function changePaging() {
			$("#pageNo").val(1);
    		boardForm.action = "${ctxPath}/adminBoardList.adm";//Post요청
    		boardForm.submit();
    	}
    	function changePage(pageNo) {
    		$("#pageNo").val(pageNo);
    		boardForm.action = "${ctxPath}/adminBoardList.adm";//Post요청
    		boardForm.submit();
    	}
    </script>
</head>
<body>
<p><br></p>
<div class="container">
	<h2 class="text-center">게 시 판 리 스 트</h2>
	<br>
	<form name="boardForm" method="post" action="${ctxPath}/adminBoardList.adm">
		<input type="hidden" id="pageNo" name="pageNo"/>
		<div class="row m-2">
			<div class="col text-left">
				<select name="recetlyYmd" onchange="changeRecetlyYmd(this)">
					<option value="" selected>최신자료순</option>
					<option value="D" >일</option>
					<option value="M" >월</option>
					<option value="Y" >년</option>
				</select>
				<select name="recetlyTerm" onchange="changeRecetlyTerm(this)">
					<option value="" selected>전체</option>
				</select>
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
				<a href="javascript:changePage('1')" title='first'>${First}</a>
					<a href="javascript:changePage('${pageNo - 1}')" title='prev'>${Prev}</a>
			</c:if>
					${pageNo}Page / ${totPage}Pages
			<c:if test="${pageNo != totPage}">
					<a href="javascript:changePage('${pageNo + 1}')" title='next'>${Next}</a>
			</c:if>
			<c:if test="${pageNo != totPage}">
				<a href="javascript:changePage('${totPage}')" title='last'>${Last}</a>
			</c:if>
			</div>
			<!-- 페이징 처리 끝 -->
	
			<div class="text-right p-0">
				<select name="pageSize" id="pageSize" onchange="changePaging()">
					<option value="5"  ${5==pageSize  ? 'selected' : ''} >5건</option>
					<option value="10" ${10==pageSize ? 'selected' : ''} >10건</option>
					<option value="15" ${15==pageSize ? 'selected' : ''} >15건</option>
					<option value="20" ${20==pageSize ? 'selected' : ''} >20건</option>
				</select>
			</div>	
		</div>
	
		<table class="table table-hover text-center">
			<tr class="table-dark">
				<th>글번호</th>
				<th class="text-left">글제목</th>
				<th>글쓴이</th>
				<th>글쓴날짜</th>
				<th>조회수</th>
				<th>추천수</th>
			</tr>
			<input type="hidden" id="idx" name="idx" />
			<c:forEach var="vo" items="${vos}" >
			<tr>
				<td><c:out value="${curScrStartNo}"/></td>
				<td><a href="javascript:goBoardDetail('${vo.idx}')"><c:out value="${vo.title}"/></a>
					<c:if test="${vo.replyNum > 0}"><font color="blue">[<c:out value="${vo.replyNum}"/>]</font></c:if>
					<c:if test="${vo.intWDate <= 24}"><font color="red"> new </font></c:if>
				</td>
				<td><c:out value="${vo.nickName}"/></td>
				<td>
					<c:if test="${vo.intWDate <= 24}"><c:out value="${fn:substring(vo.wDate, 11, 19)}"/></c:if>
					<c:if test="${vo.intWDate > 24}"><c:out value="${fn:substring(vo.wDate, 0, 10)}"/></c:if>
				</td>
				<td><c:out value="${vo.readNum}"/></td>
				<td><c:out value="${vo.recommendNum}"/></td>
			</tr>
			<c:set var="curScrStartNo" value="${curScrStartNo-1}"/>
			</c:forEach>
		</table>
		
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
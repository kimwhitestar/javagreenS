<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctxPath" value="${pageContext.request.contextPath}"/>
<c:set var="LF" value="\n" scope="page" />
<c:set var="BR" value="<br>" scope="page" />
<c:set var="First" value="<<" scope="page" />
<c:set var="Last" value=">>" scope="page" />
<c:set var="Prev" value="◁" scope="page" />
<c:set var="Next" value="▷" scope="page" />
<c:set var="mid" scope="request" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>memberList.jsp</title>
    <jsp:include page="/include/bs4.jsp" />
    <style></style>
    <script>
    	'use strict';
    	function openWindowMemberDetail(idx, mid) {
    		let url = '${ctxPath}/memberDetail';
    		let param = {	idx : idx, 
							mid : mid 	};
    		$.ajax({
    			type:		"post",
    			url:		"${ctxPath}/memberDetail",
    			data:		param,
    			success:	function(res) {
    				window.open(url, 'memberDetailWin', 'width=800px,height=600px,toolbar=0,status=0,menubar=0,scrollbars=yes');
/*     				if("1"==res) location.reload();
    				else alert('회원상세정보를 찾을 수 없습니다');
 */    			},
    			error:		function() {
    				alert('요청 오류~~');
    			}
    		});
    		//ajaxSubmit();
    	}
    	function changePaging() {
			$("#pageNo").val(1);
    		memberForm.action = "${ctxPath}/member/memberList";
    		memberForm.submit();
    	}
    	function changePage(pageNo) {
    		$("#pageNo").val(pageNo);
    		memberForm.action = "${ctxPath}/member/memberList";
    		memberForm.submit();
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
	<h2 class="text-center">전체 회원 리스트</h2>
	<br>
	<form name="memberForm" method="post" action="${ctxPath}/member/memberList">
		<div class="row m-2">
			<!-- 페이징 처리 시작 -->
			<div class="col text-right">
				<input type="hidden" id="pageNo" name="pageNo"/>
				<c:if test="${pagingVo.pageNo > 1}">
					<a href="javascript:changePage('1')" title='first'>${First}</a>
						<a href="javascript:changePage('${pagingVo.pageNo - 1}')" title='prev'>${Prev}</a>
				</c:if>
						${pagingVo.pageNo}Page / ${pagingVo.totPage}Pages
				<c:if test="${pagingVo.pageNo != pagingVo.totPage}">
						<a href="javascript:changePage('${pagingVo.pageNo + 1}')" title='next'>${Next}</a>
				</c:if>
				<c:if test="${pagingVo.pageNo != pagingVo.totPage}">
					<a href="javascript:changePage('${pagingVo.totPage}')" title='last'>${Last}</a>
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
			<tr class="table-dark text-dark">
				<th>번호</th>
				<th>아이디</th>
				<th>별명</th>
				<th>성명</th>
				<th>성별</th>
			</tr>
			<c:set var="curScrStartNo" value="${pagingVo.curScrStartNo}"/>
			<c:forEach var="vo" items="${vos}" >
				<tr>
					<td><c:out value="${pagingVo.curScrStartNo}"></c:out></td>
					<td><a href="javascript:openWindowMemberDetail(${vo.idx},'${vo.mid}')"><c:out value="${vo.mid}"></c:out></a></td>
					<td><c:out value="${vo.nickName}"></c:out></td>
					<td><c:out value="${vo.name}"></c:out></td>
					<td><c:out value="${vo.gender}"></c:out></td>
				</tr>
			<c:set var="curScrStartNo" value="${pagingVo.curScrStartNo-1}"/>
			</c:forEach>
			<tr><td colspan="5"></td></tr>
		</table>
		
		<!-- 블럭페이징 처리 시작 -->
		<div class="text-center">
			<c:if test="${pagingVo.pageNo > 1}">
				[<a href='memberList?pageNo=1' title='first'>첫페이지</a>]
			</c:if>
				<c:if test="${pagingVo.curBlock > 0}">
					[<a href='memberList?pageNo=${(pagingVo.curBlock-1)*pagingVo.blockSize+1}' title='prevBlock'>이전블록</a>]
				</c:if>
				<c:set var="isBreak" value="false"/>
					<c:forEach var="i" begin="${(pagingVo.curBlock*pagingVo.blockSize)+1}" end="${(pagingVo.curBlock*pagingVo.blockSize)+pagingVo.blockSize}">
				      	<c:if test="${i <= pagingVo.totPage && i == pagingVo.pageNo}">
				        	[<a href="memberList?pageNo=${i}"><font color='red'><b>${i}</b></font></a>]
						</c:if>
						<c:if test="${i <= pagingVo.totPage && i != pagingVo.pageNo}">
						  	[<a href="memberList?pageNo=${i}">${i}</a>]
						</c:if>
				    </c:forEach>
				<c:if test="${pagingVo.curBlock < pagingVo.lastBlock}">
					[<a href='memberList?pageNo=${(pagingVo.curBlock+1)*pagingVo.blockSize+1}' title='nextBlock'>다음블록</a>]
				</c:if>
			<c:if test="${pagingVo.pageNo != pagingVo.totPage}">
				[<a href='memberList?pageNo=${pagingVo.totPage}' title='last'>마지막페이지</a>]
			</c:if>
		</div>
		<!-- 블럭페이징 처리 끝 -->
	
	</form>
<!-- End page content -->
</div>

<!-- Footer -->
<jsp:include page="/common/footer.jsp" />
</body>
</html>
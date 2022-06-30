<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctxPath" value="${pageContext.request.contextPath}"/>
<c:set var="newLine" value="\n" scope="page"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>boardDetail.jsp</title>
 	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <jsp:include page="${ctxPath}/include/bs4.jsp" />
    <script>
   	'use strict';
    // 전체 댓글 보이기/가리기
    $(document).ready(function() {
    	$("#reply").show();
    	$("#replyViewBtn").hide();
    	
    	$("#replyViewBtn").click(function() {
    		$("#reply").slideDown(500);
    		$("#replyViewBtn").hide();
    		$("#replyHiddenBtn").show();
    	});
    	
    	$("#replyHiddenBtn").click(function() {
    		$("#reply").slideUp(500);
    		$("#replyViewBtn").show();
    		$("#replyHiddenBtn").hide();
    	});
    	
    });
    
   	function goBoardList() {
   		boardForm.action = '${ctxPath}/board/boardList';
   		boardForm.submit();
   	}
   	function goPrevBoardDetail() {
   		prevForm.submit();
   	}
   	function goNextBoardDetail() {
   		nextForm.submit();
   	}
   	function checkBoardUpdate() {
   		boardForm.action = '${ctxPath}/board/boardUpdate';
   		boardForm.submit();
   	}
   	function checkBoardDelete(){
   		boardForm.action = '${ctxPath}/board/boardDelete';
   		boardForm.submit();
   	}
   	//게시물에 '좋아요' 버튼 클릭 - '좋아요' 횟수 증가
   	function checkRecommend() {
		$.ajax({
			type: 		"post",
			url: 		"${ctxPath}/board/boardRecommend",//간단히 URL패턴으로 했음
			data: 		{idx : '${vo.idx}'}, 
			success:	function(recmmdNum) {
				if ("-1" == recmmdNum) {
					alert('좋아요가 처리되지 않았습니다');
				} else {
					$("#recmmdNum").val(recmmdNum);
					location.reload();//'좋아요' 1회 증가 DB저장 성공시 화면 reload
				} 
			},
			error:		function() {
				alert('요청 오류~~');
			}
		});
	}
   	//게시물에 '싫어요' 버튼 클릭 - '싫어요' 횟수 증가
   	function checkNoRecommend() {
   		$.ajax({
   			type: 		"post",
   			url: 		"${ctxPath}/board/boardNoRecommend",//간단히 URL패턴으로 했음
   			data: 		{ idx : '${vo.idx}' }, 
   			success:	function(recmmdNum) {
   				if ("-1" == recmmdNum) {
   					alert('싫어요가 처리되지 않았습니다');
   				} else {
   					$("#recmmdNum").val(recmmdNum);
   					location.reload();////'싫어요' 1회 증가 DB저장 성공시 화면 reload
   				} 
   			},
   			error:		function() {
   				alert('요청 오류~~');
   			}
   		});
   	}    
   	
   	function viewReply(replyContent) {
   		$("#replyContent").val(replyContent);
   	}
   	
   	//댓글 수정
   	function checkReplyUpdate(replyIdx) {
   		if (!confirm('댓글을 수정하겠습니까?')) return;

   		let replyContent = $("#replyContent").val();
   		if("" == replyContent.trim()) {
   			alert("댓글을 입력하세요");
   			$("#replyContent").focus();
   			return false;
   		}
   		
   		let param = {	idx : replyIdx, 
						content : replyContent,
						hostIp : '${pageContext.request.remoteAddr}'	};
   		
   		$.ajax({
   			type:		"post",
   			url:		"${ctxPath}/boardReply/boardReplyUpdate",//간단히 URL패턴으로 했음
   			data:		param,
   			success:	function(res) {
   				if("1"==res) location.reload();//수정성공시 화면reload
   				else alert('댓글이 수정되지 않았습니다');
   			},
   			error:		function() {
   				alert('요청 오류~~');
   			}
   		});
   	}
   	
   	//댓글 입력
   	function checkReplyInput() {
   		let replyContent = $("#replyContent").val();
   		if("" == replyContent.trim()) {
   			alert("댓글을 입력하세요");
   			$("#replyContent").focus();
   			return false;
   		}
   		let param = {	boardIdx : '${vo.idx}', 
   						content : replyContent,
						hostIp : '${pageContext.request.remoteAddr}'	};
   		
   		$.ajax({
   			type:		"post",
   			url:		"${ctxPath}/boardReply/boardReplyInput",//간단히 URL패턴으로 했음
   			data:		param,
   			success:	function(res) {
   				if('1'==res) location.reload();//등록성공시 화면reload
   				else  alert('댓글이 등록되지 않았습니다');
   			},
   			error:		function() {
   				alert('요청 오류~~');
   			}
   		});
   	}
   	
   	//댓글 삭제
   	function checkReplyDelete(replyIdx) {
   		if (!confirm('댓글을 삭제하겠습니까?')) return;
   		
   		$.ajax({
   			type:		"post",
   			url:		"${ctxPath}/boardReply/boardReplyDelete",//간단히 URL패턴으로 했음
   			data:		{idx : replyIdx},
   			success:	function(res) {
   				if("1"==res) location.reload();//삭제성공시 화면reload//전체화면 reload 많이 쓰면 화면깜박 생김
   				else alert('댓글이 삭제되지 않았습니다');
   			},
   			error:		function() {
   				alert('요청 오류~~');
   			}
   		});
   	}    

   	//답글 입력
   	function insertReply(idx, level, levelOrder, nickName) {
   		let insReply = '';
    	insReply += '<div class="container">';
    	insReply += '<table class="m-2 p-0" style="width:90%">';
    	insReply += '<tr>';
    	insReply += '<td class="p-0 text-left">';
    	insReply += '<div class="form-group">';
    	insReply += '답변 댓글 달기: &nbsp;';
    	insReply += '<input type="text" name="nickName" size="6" value="${sNickName}" readonly class="p-0"/>';
    	insReply += '</div>';
    	insReply += '</td>';
    	insReply += '<td class="p-0 text-right">';
   		insReply += '<input type="button" value="댓글계속" class="btn btn-secondary" onclick="boardReplyInput2('+idx+','+level+','+levelOrder+')"/>';
    	insReply += '</td>';
    	insReply += '</tr>';
    	insReply += '<tr>';
    	insReply += '<td colspan="2" class="text-center p-0">';
   	   	insReply += '<textarea rows="3" class="form-control p-0" name="content" id="content'+idx+'">';
    	insReply += '@'+nickName+'\n';
    	insReply += '</textarea>';
       	insReply += '</td>';
    	insReply += '</tr>';
    	insReply += '</table>';
    	insReply += '</div>';
   		
    	$("#replyBoxOpenBtn"+idx).hide();
    	$("#replyBoxCloseBtn"+idx).show();
    	$("#replyBox"+idx).slideDown(500);
    	$("#replyBox"+idx).html(insReply);
    }
   	
   	//답글 닫기
    function closeReply(idx) {
    	$("#replyBoxOpenBtn"+idx).show();
    	$("#replyBoxCloseBtn"+idx).hide();
    	$("#replyBox"+idx).slideUp(500);
    }

   	//댓글계속 추가
   	function boardReplyInput2(idx, level, levelOrder) {
    	let boardIdx = "${vo.idx}";
    	let mid = "${sMid}";
    	let nickName = "${sNickName}";
    	let content = "content" + idx;
    	let contentVal = $("#" +content).val();
    	let hostIp = "${pageContext.request.remoteAddr}";
   		
    	if(contentVal == "") {
    		alert("대댓글(답변글)을 입력하세요?");
    		$("#" +content).focus();
    		return false;
    	}
    	
    	let query = {
    			boardIdx  : boardIdx,
    			mid       : mid,
    			nickName  : nickName,
    			content   : contentVal,
    			hostIp    : hostIp,
    			level     : level,
    			levelOrder: levelOrder
    	}
   		
   		$.ajax({
   			type : "post",
   			url : "${ctxPath}/boardReply/boardReplyInput2";
   			data : query,
   			success:function() {
    			location.reload();
    		},
    		error : function() {
    			alert("전송오류!");
    		}
   		});
   	}
   	
    </script>
    <style>
    	th {
    		background-color: #ddd;
    		text-align: center;
    	}
    </style>
</head>
<body>
<!-- Nav Menu -->
<jsp:include page="${ctxPath}/common/menu.jsp" />

<!-- Header -->
<jsp:include page="${ctxPath}/common/header.jsp" />

<!-- Page content -->
<div class="w3-content w3-padding" style="max-width:100%">
<br>
	<h2 class="text-center">글 내 용 보 기</h2>
	<br>
	<form name="boardForm" method="post">
		<table class="table table-bordered">
			<tr>
				<td colspan="4" class="text-right bt-0">IP : ${vo.hostIp}</td>
			</tr>
			<tr>
				<th>글쓴이</th>
				<td><c:out value="${vo.nickName}"/></td>
				<th>작성일</th>
				<td><c:out value="${fn:substring(vo.WDate, 0, 20)}"/> / <c:out value="${vo.intWDate}"/></td><!-- 2022.05.10 10:13:25 -->
			</tr>
			<tr>
				<th>이메일</th>
				<td><c:out value="${vo.email}"/></td>
				<th>조회수</th>
				<td><c:out value="${vo.readNum}"/></td>
			</tr>
			<tr>
				<th>홈페이지</th>
				<td><c:out value="${vo.homepage}"/></td>
				<th>좋아요</th>
				<td>
					❤ ( <c:set var="recmmdNum" value="${vo.recommendNum}" scope="page"/><c:out value="${recmmdNum}"/> )
					/ <a href="javascript:checkRecommend()"> 👍 </a>
					/ <a href="javascript:checkNoRecommend()"> 👎 </a>
				</td>
			</tr>
			<tr>
				<th>내용</th>
				<td colspan="3" height="200px"><c:out value="${fn:replace(vo.content, 'newLine', '<br>')}"/></td>
			</tr>
			<tr>
				<td colspan="4" class="text-center">
					<input type="button" value="목록" onclick="goBoardList()" class="btn btn-secondary"/>
					<c:if test="${sMid==vo.mid}">
						<input type="button" value="수정" onclick="checkBoardUpdate()" class="btn btn-secondary"/>
						<input type="button" value="삭제" onclick="checkBoardDelete()" class="btn btn-secondary"/>
					</c:if>
				</td>
			</tr>
		</table>
	    <input type="hidden" name="idx" value="${vo.idx}" />
	    <input type="hidden" name="searchCondition" value="${searchCondition}" />
	    <input type="hidden" name="searchString" value="${searchString}" />
		<input type="hidden" id="pageNo" name="pageNo" value="${pageNo}"/>
		<input type="hidden" id="pageSize" name="pageSize" value="${pageSize}"/>
	</form>
	
	<!-- 이전글/다음글 소개 시작 -->
	<form name="prevForm" method="post" action="${ctxPath}/board/boardDetail">
		<table>
			<tr>
				<td>
					<c:if test="${!empty preVO}">
						이전글 : <a href="javascript:goPrevBoardDetail()">${preVO.title}</a>
					</c:if>
				</td>
			</tr>
		</table>
	    <input type="hidden" name="idx" value="${preVO.idx}" />
	    <input type="hidden" name="searchCondition" value="${searchCondition}" />
	    <input type="hidden" name="searchString" value="${searchString}" />
		<input type="hidden" id="pageNo" name="pageNo" value="${pageNo}"/>
		<input type="hidden" id="pageSize" name="pageSize" value="${pageSize}"/>
    </form>
    <br>
	<form name="nextForm" method="post" action="${ctxPath}/board/boardDetail">
		<table>
			<tr>
				<td>
					<c:if test="${!empty nextVO}">
						다음글 : <a href="javascript:goNextBoardDetail()">${nextVO.title}</a>
					</c:if>
				</td>
			</tr>
		</table>
	    <input type="hidden" name="idx" value="${nextVO.idx}" />
	    <input type="hidden" name="searchCondition" value="${searchCondition}" />
	    <input type="hidden" name="searchString" value="${searchString}" />
		<input type="hidden" id="pageNo" name="pageNo" value="${pageNo}"/>
		<input type="hidden" id="pageSize" name="pageSize" value="${pageSize}"/>
    </form>
	<!-- 이전글/다음글 소개 끝 -->
	
	<!-- 댓글 처리(출력/입력) -->
	<div class="container text-center mb-3">
	  <input type="button" value="댓글보이기" id="replyViewBtn" class="btn btn-secondary"/>
	  <input type="button" value="댓글가리기" id="replyHiddenBtn" class="btn btn-info"/>
	</div>
	<!-- 댓글 출력 처리 -->
	<div id="reply">
		<table class="table table-hover text-center">
			<tr>
				<th>작성자</th>
				<th>내용</th>
				<th>작성일</th>
				<th>접속IP</th>
			</tr>
			<c:forEach var="replyVo" items="${replyVoS}" varStatus="st">
			<c:if test="${!empty replyVo.hostIp}">
			<tr>
				<td class="text-left">
					<c:if test="${0 >= replyVo.level}"><!-- 댓글은 들여쓰기 없음 -->
						${replyVo.nickName}
					</c:if>
					<c:if test="${0 < replyVo.level}"><!-- 댓글계속 들여쓰기 -->
						<c:forEach var="i" begin="1" end="${replyVo.level}">&nbsp;&nbsp;</c:forEach>
						${replyVo.nickName}
					</c:if>
					<c:if test="${sMid == replyVo.mid}">
						<a href="javascript:checkReplyUpdate('${replyVo.idx}')" class="btn btn-info btn-sm" ><font color="blue">✂</font></a>
					</c:if>
					<c:if test="${sMid == replyVo.mid || 0 == sLevel}">
						<a href="javascript:checkReplyDelete('${replyVo.idx}')" class="btn btn-info btn-sm" ><font color="red">❌</font></a>
					</c:if>
				</td>
				<td class="text-left">${fn:replace(replyVo.content, newLine, "<br/>")}</td>
				<td>${replyVo.WDate}</td>
				<td>${replyVo.hostIp}</td>
			</tr>
		    <td>
		        <input type="button" value="답글" onclick="insertReply('${replyVo.idx}','${replyVo.level}','${replyVo.levelOrder}','${replyVo.nickName}')" id="replyBoxOpenBtn${replyVo.idx}" class="btn btn-secondary btn-sm"/>
		        <input type="button" value="닫기" onclick="closeReply('${replyVo.idx}')" id="replyBoxCloseBtn${replyVo.idx}" class="btn btn-info btn-sm" style="display:none;"/>
			</td>
			<tr>
				<td colspan="5" class="m-0 p-0" style="border-top:none;">
					<div id="replyBox${replyVo.idx}"></div>
				</td>
			</tr>
			</c:if>
			<c:if test="${empty replyVo.hostIp and (!empty replyVos[st.count].level and (replyVos[st.index].level<replyVos[st.count].level))}">
		      <td class="text-left"><span style='font-size:9px'>글이 삭제처리됨...</span></td>
		      <td colspan="4"></td>
		    </c:if>
			</c:forEach>		
		</table>
	</div>
	<!-- 댓글 입력(전체화면을 이동하지않고 비동기식 Ajax로 댓글form만 reload처리함-->
	<form name="replyForm" method="post" action="${ctxPath}/boardReply/boardReplyInput">
		<table class="table table-center">
			<tr>
				<td style="width:85%">
					글 내용 : <textarea rows="3" id="content" name="content" class="form-control"></textarea>
				</td>
				<td style="width:15%">
					<p>작성자 : ${sNickName}</p>
					<c:if test="${empty  replyContent}">
						<p><input type="button" value="댓글등록" onclick="checkReplyInput()" class="btn btn-info btn-sm"/></p>
					</c:if>
					<c:if test="${!empty  replyContent}">
						<p><input type="button" value="댓글수정" onclick="checkReplyUpdate()'${replyVo.idx}')" class="btn btn-info btn-sm"/></p>
					</c:if>
					<br>
				</td>
			</tr>
		</table>
	</form>
	<!-- 댓글(출력/입력) 끝 -->
<!-- End page content -->
</div>

<!-- Footer -->
<jsp:include page="${ctxPath}/common/footer.jsp" />
</body>
</html>
<%@ page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctxPath" value="${pageContext.request.contextPath}"/>
<c:set var="LF" value="\n" scope="page" />
<c:set var="BR" value="<br>" scope="page" />
<c:set var="First" value="<<" scope="page" />
<c:set var="Last" value=">>" scope="page" />
<c:set var="Prev" value="◁" scope="page" />
<c:set var="Next" value="▷" scope="page" />

<c:set var="attrMapTgt" scope="request" />
<c:set var="attrMid" scope="request" />
<c:set var="attrLevel" scope="request" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>adminMemberList.jsp</title>
    <%@ include file="/include/bs4.jsp" %>
    <style></style>
    <script>
    	'use strict';
		let mapTarget = new HashMap();
//Json처럼 front화면에서 직접 비동기db연동할 경우 연습용ㅜㅜ(해본적없음)
/* 		function arrangeTargetMap() {
    		let elmtArrChk = memberForm.arrChk;
    		let elmtArrIdx = memberForm.arrIdx;
    		let elmtArrMid = memberForm.arrMid;
    		let elmtSelArrLevel = memberForm.arrLevel;
    		
    		//once 1개만 체크됬으면 cnt가 1이므로 new Array[1]로, 여러개 체크됬으면 new Array[cnt]로 배열생성
    		let cnt = 0, index = 0;
    		for (let i=0; i<elmtArrChk.length; i++) {
        		if (elmtArrChk[i].checked) ++cnt;
    		}
    		if (0 == cnt) {
    			alert('선택한 회원이 없습니다.');
    			return;
    		}
    		let targetArrIdx = new Array[cnt];
    		let targetArrMid = new Array[cnt];
    		let targetArrLevel = new Array[cnt];
    		for (let i=0; i<elmtArrChk.length; i++) {
        		if (elmtArrChk[i].checked) {
        			targetArrIdx[index] = elmtArrIdx[i].value;
        			targetArrMid[index] = elmtArrMid[i].value;
        			for (let j=0; j<elmtSelArrLevel[i].options.length; j++) {
        				if (elmtSelArrLevel[i].options[j].selected)
        					targetArrLevel[index] = elmtSelArrLevel[i].options[j].value;
        			}
        			++index;
        		}
    		}
    		//1개든 여러개든 체크된 항목을 mapTarget에 배열값으로 설정
    		mapTarget.put("targetArrIdx", targetArrIdx);
    		mapTarget.put("targetArrMid", targetArrMid);
    		mapTarget.put("targetArrLevel", targetArrLevel);
    		//jstl로 선언한 REQUEST attribute변수 'mapTgt'에 mapTarget설정
    		${attrMapTgt} = mapTarget;
    	}
		function arrangeTargetMap(flg, mid, level) {
    		let targetArrIdx, targetArrMid, targetArrLevel;
    		if ('update' == flg) {
    			if ('' == level) {
    				alert('회원등급을 변경해야 수정할 수 있습니다');
    				return;
    			}
    			targetArrIdx = new Array[1];
    			targetArrMid = new Array[1];
    			targetArrLevel = new Array[1];
    			targetArrIdx = null;
        		targetArrMid[1] = mid;
        		targetArrLevel[1] = level;
    		} else if ('delete' == flg) {
    			targetArrIdx = null;
    			targetArrMid = new Array[1];
   				targetArrLevel = null;
        		targetArrMid[1] = mid;
   			} else {
   				return;
   			}
    		//1개든 여러개든 체크된 항목을 mapTarget에 배열값으로 설정
    		mapTarget.put("targetArrIdx", targetArrIdx);
    		mapTarget.put("targetArrMid", targetArrMid);
    		mapTarget.put("targetArrLevel", targetArrLevel);
    		//jstl로 선언한 REQUEST attribute변수 'mapTgt'에 mapTarget설정
    		${attrMapTgt} = mapTarget;
		}
    	function changeLevel(targetLevel) {
    		let arrOption = targetLevel.options;
    		let levelValue = '';
    		for (let i=0; i<arrOption.length; i++) {
    			if (arrOption[i].selected) levelValue = arrOption[i].value;
    		}
    		alert('선택한 등급의 value = ' + levelValue);
    		alert('등급변경 버튼을 클릭하면 선택된 등급으로 수정됩니다');
    		${attrLevel} = levelValue;
    	}
    	function updateMemberLevel(flg, chk) {
    		if ('once' == chk) arrangeTargetMap(flg, ${attrMid}, ${attrLevel});
    		else if ('checked' == chk) arrangeTargetMap();
    		location.href = '${ctxPath}/adminMemberLevelUpdate.adm';
    	}
    	function deleteMember(flg, chk) {
    		if ('once' == chk) arrangeTargetMap(flg, ${attrMid}, null);
    		else if ('checked' == chk) arrangeTargetMap();
    		if (confirm('정말 회원에서 삭제처리하겠습니까?')) {
    			location.href = '${ctxPath}/adminMemberDelete.adm';
    		}
    	}
*/    	
    	function locationControl(flg, chk, mid) {
    		${attrMid} = mid;
    		if ('update' == flg) updateMemberLevel(flg, chk);
           	else if ('delete' == flg) deleteMember(flg, chk);
    	}
    	
     	function openWindowMemberDetail(idx, mid) {
    		$("#idx") = idx;
    		$("#mid") = mid;
    		let url = '${ctxPath}/memberDetail.mbr';
    		window.open(url,"memberDetailWin","width=800px,height=600px");
    	}
 
/*  		function openWindowMemberDetail(idx, mid) {
			let url = '${ctxPath}/memberDetail.mbr';
			let param = {	idx : idx, 
							mid : mid 	};
			$.ajax({
				type:		"post",
				url:		"${ctxPath}/memberDetail.mbr",
				data:		param,
				success:	function(res) {
//					window.open(url, 'memberDetailWin', 'width=800px,height=600px,toolbar=0,status=0,menubar=0,scrollbars=yes');
					window.open(url, 'memberDetailWin', 'width=800px,height=600px,scrollbars=yes');
//     				if("1"==res) location.reload();
//					else alert('회원상세정보를 찾을 수 없습니다');
    			},
				error:		function() {
					alert('요청 오류~~');
				}
			});
		}
 */
 		function changePaging() {
			$("#pageNo").val(1);
			memberForm.action = "${ctxPath}/adminMemberList.adm";//Post요청
			memberForm.submit();
		}
		function changePage(pageNo) {
			$("#pageNo").val(pageNo);
			memberForm.action = "${ctxPath}/adminMemberList.adm";//Post요청
			memberForm.submit();
		}
    </script>
</head>
<body>
<p>
<br></p>
<div class="container">
	<h2 class="text-center">관리자 전체 회원 목록</h2>
	<form name="memberForm" method="post" action="${ctxPath}/adminMemberList.adm">
		<input type="hidden" id="pageNo" name="pageNo"/>
		<div class="m-2 row">
			<div class="col text-left">
				<select name="level" onchange="changeLevel(this)">
					<option value="0" <c:if test="${0 == vo.level}">selected</c:if> >관리자</option>
					<option value="1" <c:if test="${1 == vo.level}">selected</c:if> >정회원</option>
					<option value="2" <c:if test="${2 == vo.level}">selected</c:if> >준회원</option>
					<option value="3" <c:if test="${3 == vo.level}">selected</c:if> >우수회원</option>
					<option value="4" <c:if test="${4 == vo.level}">selected</c:if> >운영자</option>
				</select>
				<input type="submit" value="조회" class="btn btn-secondary"/>
				<input type="button" value="등급변경" class="btn btn-secondary" onclick="locationControl('update', 'checked', null)"/>&nbsp;
				<input type="button" value="회원삭제" class="btn btn-secondary" onclick="locationControl('delete', 'checked', null)"/>
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
				<a href="javascript:changePage('${totPage}')" title='last'>${Last}</a>
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
				<th><input type="checkbox" name="allChk" width="15px" height="15px"></th>
				<th>번호</th>
				<th>아이디</th>
				<th>별명</th>
				<th>성명</th>
				<th>성별</th>
				<th>공개유무</th>
				<th>회원등급</th>
				<th>회원활동상태</th>
			</tr>
			<c:forEach var="vo" items="${vos}" >
			<tr>
				<td>
					<input type="checkbox" name="chk" width="15px" height="15px"/>
					<input type="hidden" name="mid" value="${vo.mid}"/>
					<input type="hidden" name="idx" value="${vo.idx}" />
				</td>
				<td><c:out value="${curScrStartNo}"/></td>
				<td><a href="javascript:openWindowMemberDetail('${vo.idx}', '${vo.mid}')"><c:out value="${vo.mid}"></c:out></a></td>
				<td><c:out value="${vo.nickName}"></c:out></td>
				<td><c:out value="${vo.name}"></c:out></td>
				<td><c:out value="${vo.gender}"></c:out></td>
				<td><c:out value="${vo.userInfo}"></c:out></td>
				<td>
					<select name="level" onchange="changeLevel(this)">
						<option value="0" <c:if test="${0 == vo.level}">selected</c:if> >관리자</option>
						<option value="1" <c:if test="${1 == vo.level}">selected</c:if> >정회원</option>
						<option value="2" <c:if test="${2 == vo.level}">selected</c:if> >준회원</option>
						<option value="3" <c:if test="${3 == vo.level}">selected</c:if> >우수회원</option>
						<option value="4" <c:if test="${4 == vo.level}">selected</c:if> >운영자</option>
					</select>
					<input type="button" value="등급변경" class="btn btn-secondary btn-sm" onclick="locationControl('update', 'once', ${vo.mid})"/>
				</td>
				<td>
					<c:if test="${'OK' == vo.userDel}"><font color="red">탈퇴신청</font></c:if>
					<c:if test="${'NO' == vo.userDel}"><font color="red">활동중</font></c:if>
					<c:if test="${30 <= vo.overDaysUserDel}"><font color="blue">*</font></c:if>
					<input type="button" value="회원삭제" class="btn btn-secondary btn-sm" onclick="locationControl('delete', 'once', ${vo.mid})"/>
				</td>
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
	</form>
</div>
</body>
</html>
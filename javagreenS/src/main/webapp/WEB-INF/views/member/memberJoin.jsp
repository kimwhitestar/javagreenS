<%@ page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctxPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>memberJoin.jsp</title>
	<jsp:include page="/include/bs4.jsp" />
	<!-- daum웹사이트에서 제공하는 script open 예제소스 -->
	<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="${ctxPath}/js/post.js"></script>
	<style>
	</style>
	<script>
	'use strict';
	
	//아이디 중복 체크
	function idCheck() {
		let url = '${ctxPath}/member/memberIdCheck';
		window.open(url,"idCheckWin","width=580px,height=200px");
	}
	
	//닉네임 중복 체크
	function nickNameCheck() {
		let url = '${ctxPath}/member/memberNickNameCheck';
		window.open(url,"nickNameCheckWin","width=580px,height=200px");
	}
	
	//DB에 저장될 각각의 필드길이 체크
 	function regexCheck() {
		const regexMid = /^[a-zA-Z]+[0-9_+-.]*[a-zA-Z_+-.]*[0-9]([a-zA-Z0-9_+-.]*){20}$/g; //아이디체크(영문자1자리이상, 숫자나 특수기호 조합 2~20자리)
        const regexPass = /([a-zA-Z][0-9][@#$%&!?^~*+-_.]|[0-9][a-zA-Z][@#$%&!?^~*+-_.]|[@#$%&!?^~*+-_.][a-zA-Z][0-9]|[@#$%&!?^~*+-_.][0-9][a-zA-Z])/g;//비밀번호체크(영문자,숫자,특수기호 @#$%&!?^~*+-_. 조합 3~20자리)
        const regexNickName = /[가-힣a-zA-Z]{3,10}([0-9]*|[0-9])/g; //닉네임체크(한글or영문에 필요하면 숫자포함 조합 3~20자리)
    	const regexName = /[가-힣a-zA-Z]{3,10}([0-9]*|[0-9])/g; //이름체크(한글or영문에 필요하면 숫자포함 조합 3~20자리)
		const regexEmail = /^[a-zA-Z]{2}[0-9_+-.]*[a-zA-Z]([a-zA-Z0-9_+-.]*){25}$/g;//이메일체크(영문자으로 시작하여 특수기호 _+-. 또는 숫자 또는 문자 조합 3~25자리)
        const regexTel2 = /\d{3,4}$/g; //전화번호2체크(숫자 3~4자리)
		const regexTel3 = /\d{4}$/g; //전화번호3체크(숫자 4자리)
        const regexDetailAddress = /[a-zA-Z0-9가-힣#-. ]{1,15}/g; //상세주소체크(문자or숫자or특수문자( .-#) 1~15자리)
		const regexHomepage = /^(http(s)?:\/\/)[a-zA-Z0-9_+-.\/]/g; //홈페이지체크(영문자,숫자,특수문자(/_-.) 조합 50자리)
		const regexContent = /^[a-zA-Z0-9가-힣]([ ]*|[@#$%^&!?]|[~()<>_*+-=]|[,.:;\/]){1,200}$/gm; //자기소개 체크(숫자,문자,특수문자체크(~!?@#$%^&*()<>_+=-,.:;/ ) 조합 200자리)
		const regexFName = /[a-zA-Z0-9가-힣_-~()+][.](JPG|JPEG|GIF|jpg|jpeg|gif)$/g; //화일명 체크(문자,숫자,특수문자(~()<>_*+-) 50자리의 화일명과 .JPG 또는 .JPEG 또는 .GIF확장자만 가능합니다)
		let regexFlag = true;
		
 		//회원아이디 정규식 체크
  		if ( ! $("#mid").val().match(regexMid) ) {
 			$("#mid").addClass("is-invalid");
 			$("#midInValid").addClass("is-invalid");
 			$("#midInValid").text("영문자로 시작하여 숫자1자리 이상 포함하는 영문,숫자,특수기호(_+-.)의 조합 2~20자리로 입력하세요");
 			$("#mid").focus();
 			regexFlag = false;
 		} else {
 			$("#mid").addClass("is-valid");
 			$("#midInValid").addClass("is-valid");
 			$("#midInValid").text("");
 			$("#pass").focus();
 		}
  		//비밀번호 정규식 체크
		if ( ! $("#pass").val().match(regexPass) ) {
			$("#pass").addClass("is-invalid");
			$("#passInvalid").addClass("is-invalid");
			$("#passInvalid").text("영문자, 숫자, 특수기호(~!?@#$%^&*_+-.) 조합 3~20자리로 입력하세요");
 			$("#pass").focus();
 			regexFlag = false;
		} else {
			$("#pass").addClass("is-valid");
			$("#passInvalid").addClass("is-valid");
 			$("#passInvalid").text("");
			$("#nickName").focus();
		}
		//닉네임 정규식 체크
		if ( ! $("#nickName").val().match(regexNickName) ) {
			$("#nickName").addClass("is-invalid");
			$("#nickNameInvalid").addClass("is-invalid");
			$("#nickNameInvalid").text("한글 또는 영문 3자리 이상으로 필요하면 숫자 조합 3~20자리로 입력하세요");
			$("#nickName").focus();
 			regexFlag = false;
		} else {
			$("#nickName").addClass("is-valid");
			$("#nickNameInvalid").addClass("is-valid");
			$("#nickNameInvalid").text("");
			$("#name").focus();
		}
		 //이름 정규식 체크
		if ( ! $("#name").val().match(regexName) ) {
			$("#name").addClass("is-invalid");
			$("#nameInvalid").addClass("is-invalid");
			$("#nameInvalid").text("한글 또는 영문 3자리 이상으로 필요하면 숫자 조합 3~20자리로 입력하세요");
			$("#name").focus();
 			regexFlag = false;
		} else {
			$("#name").addClass("is-valid");
			$("#nameInvalid").addClass("is-valid");
			$("#nameInvalid").text("");
			$("#email1").focus();
		}
		//이메일 정규식 체크
		if ( ! $("#email1").val().match(regexEmail) ) {
			$("#email1").addClass("is-invalid");
			$("#email1Invalid").addClass("is-invalid");
			$("#email1Invalid").text("영문자 3자리 이상으로 필요하면 특수기호(_+-.), 숫자, 영문 조합 3~25자리로 입력하세요");
			$("#email1").focus();
 			regexFlag = false;
		} else {
			$("#email1").addClass("is-valid");
			$("#email1Invalid").addClass("is-valid");
			$("#email1Invalid").text("");
			$("#tel2").focus();
		}
 		if ('' != $("#tel3").val()) {
			//전화번호 정규식 체크
			if ( ! $("#tel3").val().match(regexTel3) ) {
				$("#tel3").addClass("is-invalid");
				$("#tel3InValid").addClass("is-invalid");
				$("#tel3InValid").text("숫자 4자리로 입력하세요");
				$("#tel3").focus();
	 			regexFlag = false;
			} else {
 				$("#tel3").addClass("is-valid");
				$("#tel3InValid").addClass("is-valid");
				$("#tel3InValid").text('');
			}
		} 
		if ('' != $("#tel2").val()) {
			//전화번호 정규식 체크
			if ( ! $("#tel2").val().match(regexTel2) ) {
				$("#tel2").addClass("is-invalid");
				$("#tel2InValid").addClass("is-invalid");
				$("#tel2InValid").text("숫자 3자리~4자리로 입력하세요");
				$("#tel2").focus();
	 			regexFlag = false;
			} else {
				$("#tel2").addClass("is-valid");
				$("#tel2InValid").addClass("is-valid");
				$("#tel2InValid").text('');
			}
		}
		//우편번호 공란 체크
		if ( '' == $('#addressGroup input[name="postcode"]').val()
			&& '' != $('#addressGroup input[name="detailAddress"]').val() ) {
			$('#addressGroup input[name="detailAddress"]').addClass("is-invalid");
			$("#detailAddressInValid").addClass("is-invalid");
			$("#detailAddressInValid").text("주소는 우편번호찾기로 검색 후 입력하세요");
			$('#addressGroup input[name="detailAddress"]').focus();
 			regexFlag = false;
		} else {
			$('#addressGroup input[name="detailAddress"]').addClass("is-valid");
			$("#detailAddressInValid").addClass("is-valid");
			$("#detailAddressInValid").text("");
			$("#btnPostCode").focus();
		}
 		if ( '' != $('#addressGroup input[name="postcode"]').val() 
 			&& '' != $('#addressGroup input[name="detailAddress"]').val() ) {
			//상세주소 정규식 체크
			if ( ! $('#addressGroup input[name="detailAddress"]').val().match(regexDetailAddress) ) {
				$('#addressGroup input[name="detailAddress"]').addClass("is-invalid");
				$("#detailAddressInValid").addClass("is-invalid");
				$("#detailAddressInValid").text("문자, 숫자, 특수문자( .-#) 1~15자리로 입력하세요");
				$('#addressGroup input[name="detailAddress"]').focus();
	 			regexFlag = false;
			} else {
				$('#addressGroup input[name="detailAddress"]').addClass("is-valid");
				$("#detailAddressInValid").addClass("is-valid");
				$("#detailAddressInValid").text("");
				$("#homepage").focus();
			}
		}
		if ('' != $("#homepage").val() ) {
			//홈페이지주소 정규식 체크
			if ( ! $("#homepage").val().match(regexHomepage) ) {
				$("#homepage").addClass("is-invalid");
				$("#homepageInValid").addClass("is-invalid");
				$("#homepageInValid").text("문자나 숫자나 특수문자(/_-.) 11~50자리로 입력하세요");
				$("#homepage").focus();
	 			regexFlag = false;
			} else {
				$("#homepage").addClass("is-valid");
				$("#homepageInValid").addClass("is-valid");
				$("#homepageInValid").text("");
				$("#content").focus();
			}
		}
 		if ('' != $("#content").val()) {
			//자기소개 정규식 체크
			if ( ! $("#content").val().match(regexContent) ) {
				$("#content").addClass("is-invalid");
				$("#contentInValid").addClass("is-invalid");
				$("#contentInValid").text("문자 1자리 이상으로 필요하면 숫자, 특수문자(~!?@#$%^&*()<>_+=-,.:;/ )의 조합 200자리로 입력하세요");
				$("#content").focus();
	 			regexFlag = false;
			} else {
				$("#content").addClass("is-valid");
				$("#contentInValid").addClass("is-valid");
				$("#contentInValid").text("");
				$("#fName").focus();
			}
		}
		if ('' != $("#fName").val().trim() ) {
	 		//화일명 정규식 체크
			if ( ! $("#fName").val().match(regexFName) ) {
				$("#fName").addClass("is-invalid");
				$("#fNameInValid").addClass("is-invalid");
				$("#fNameInValid").text("문자,숫자,특수문자(_-~()+) 50자리의 화일명과 .jpg 또는 .jpeg 또는 .gif확장자만 가능합니다");
				$("#fName").focus();
	 			regexFlag = false;
			} else {
				$("#fName").addClass("is-valid");
				$("#fNameInValid").addClass("is-valid");
				$("#fNameInValid").text("");
				$("#entry").focus();
			}
		}
 		if ( regexFlag ) return true;
		else return false;
	}
	
	//회원가입폼 파라미터 편집후 서버로 요청하기
 	function editForm(flag) {
		if (! flag) return;
		
		//생일 체크(18년 이전 출생일 부터 가능)
		let birthday = joinForm.birthday.value;

		//이메일 편집
		$("#email").val($("#email1").val() + '@' + $('#emailGroup select[name="email2"] option:selected').val());

		//전화번호 편집
		let tel2 = $('#telGroup input[name="tel2"]').val();
		let tel3 = $('#telGroup input[name="tel3"]').val();
		if (''!=tel2 && ''!=tel3) {
			$("#telNo").val(
				$('#telGroup select[name="tel1"] option:selected').val() 
				+ '-' + tel2 
				+ '-' + tel3);
		}
		
		//주소 편집
 		$("#address").val($('#addressGroup input[name="postcode"]').val() 
			+ '/' + $('#addressGroup input[name="roadAddress"]').val() 
			+ '/' + $('#addressGroup input[name="extraAddress"]').val()
			+ '/' + $('#addressGroup input[name="detailAddress"]').val());
		
		//취미 
        let arrHobby = [];
		$('#hobbyGroup input[name="hobby"]:checked').each(function(idx, item){
			arrHobby.push($(item).val());
        });
		$("#checkedHobbies").val(arrHobby.join('/'));

		//사진upload 체크
		if ('' == $("#fName").val().trim()) {
			$("#photo").val('noimage');
		} else {
			let fName = $("#fName").val();
			$("#photo").val(fName);
			if (-1 < fName.indexOf(" ")) {
				alert('화일명에는 공백을 사용할 수 없습니다');
				$("#fName").focus();
				return;
			}
			let maxSize = 1024 * 1024 * 2;//업로드 회원사진 최대용량 = 2MB
			let fileSize = $("#fName")[0].files[0].size;
			if (maxSize < fileSize) {
				alert('업로드 파일의 크기는 2MByte를 초과할 수 없습니다.');
				$("#fName").focus();
				return;
			}
		}
	}
</script>
</head>
<body>
<!-- Nav Menu -->
<jsp:include page="/common/menu.jsp" />

<!-- Header -->
<jsp:include page="/common/header.jsp" />

<!-- Page content -->
<div class="w3-content w3-padding" style="max-width:100%;padding:30px">
<br>
  <form name="joinForm" method="post" action="${ctxPath}/member/memberJoin" class="was-validated" enctype="multipart/form-data">
	<h2 class="text-center">회 원 가 입</h2>
    <br/>
    <div class="form-group">
		<label for="mid">아이디 : &nbsp; &nbsp;<input type="button" value="아이디 중복체크" class="btn btn-info" onclick="idCheck()"/></label>
		<input type="text" class="form-control" id="mid" name="mid" placeholder="아이디를 입력하세요." maxlength=20 required autofocus/>
		<div id="midInValid" class="invalid-feedback">아이디는 필수 입력사항입니다.</div>
    </div>
    <div class="form-group">
		<label for="pass">비밀번호 :</label>
		<input type="password" class="form-control" id="pass" name="pass" placeholder="비밀번호를 입력하세요." maxlength=20 required />
		<div id="passInvalid" class="invalid-feedback">비밀번호는 필수 입력사항입니다.</div>
    </div>
    <div class="form-group">
		<label for="nickName">닉네임 : &nbsp; &nbsp;<input type="button" value="닉네임 중복체크" class="btn btn-info" onclick="nickNameCheck()"/></label>
		<input type="text" class="form-control" id="nickName" name="nickName" placeholder="별명을 입력하세요." maxlength=20 required />
		<div id="nickNameInvalid" class="invalid-feedback">닉네임은 필수 입력사항입니다.</div>
    </div>
    <div class="form-group">
		<label for="name">성명 :</label>
		<input type="text" class="form-control" id="name" name="name" placeholder="성명을 입력하세요." maxlength=20 required />
		<div id="nameInvalid" class="invalid-feedback">성명은 필수 입력사항입니다.</div>
    </div>
    <div class="form-group" id="emailGroup">
		<label for="email1">Email address :</label>
		<div class="input-group mb-3">
			<input type="text" class="form-control" id="email1" name="email1" placeholder="Email을 입력하세요." maxlength=25 required />
			<font size="5pt" class="text-center text-success"><b>@</b></font>
			<div class="input-group-append" >
				<select name="email2" class="custom-select">
					<option value="naver.com" selected>naver.com</option>
					<option value="hanmail.net">hanmail.net</option>
					<option value="hotmail.com">hotmail.com</option>
					<option value="gmail.com">gmail.com</option>
					<option value="nate.com">nate.com</option>
					<option value="yahoo.com">yahoo.com</option>
				</select>
			</div>
			<div id="email1Invalid" class="invalid-feedback">이메일은 필수 입력사항입니다.</div>
			<input type="hidden" class="form-control" id="email" name="email" />
		</div>
	</div>
    <div class="form-group" id="genderGroup">
		<div class="form-check-inline">
			<label class="form-check-label"> 성별 :&nbsp; &nbsp;
				<input type="radio" class="form-check-input" id="gender1" name="gender" value="남자" checked>남자
			</label>
		</div>
		<div class="form-check-inline">
			<label class="form-check-label">
				<input type="radio" class="form-check-input" id="gender2" name="gender" value="여자">여자
			</label>
		</div>
    </div>
    <div class="form-group">
    	<label for="birthday">생일 :</label>
		<fmt:formatDate var="now" value="<%= new java.util.Date() %>" pattern="yyyy-MM-dd"/>
		<input type="date" id="birthday" name="birthday" value="${now}" class="form-control"/>
    </div>
    <div class="form-group" id="telGroup">
		<label >전화번호 :</label> &nbsp;&nbsp;
		<div class="input-group">
			<div class="input-group-prepend">
				<select id="tel1" name="tel1" class="custom-select">
					<option value="010" selected>010</option>
					<option value="02">서울</option>
					<option value="031">경기</option>
					<option value="032">인천</option>
					<option value="041">충남</option>
					<option value="042">대전</option>
					<option value="043">충북</option>
					<option value="051">부산</option>
					<option value="052">울산</option>
					<option value="061">전북</option>
					<option value="062">광주</option>
				</select>
			</div>
			_<div><input type="text" id="tel2" name="tel2" size=4 maxlength=4 class="form-control" /></div>
			_<div><input type="text" id="tel3" name="tel3" size=4 maxlength=4 class="form-control" /></div>
 			<div id="blank" class="is-invalid"></div>
  			<div id="tel2InValid" class="invalid-feedback"></div>
 	 		<div id="tel3InValid" class="invalid-feedback"></div> 
 			<input type="hidden" id="telNo" name="telNo" maxlength=13 class="form-control">
		</div> 
    </div>
    <div class="form-group" id="addressGroup">
		<label for="address">주소 : </label>
		<div class="input-group">
			<div class="input-group">
				<input type="text" class="input-group-prepend" id="sample6_postcode" name="postcode" size="10" placeholder="우편번호"  disabled>&nbsp;
				<input type="button" class="btn btn-info" id="btnPostCode" onclick="sample6_execDaumPostcode()" value="우편번호 찾기">&nbsp;
				<input type="text" class="form-control" id="sample6_address" name="roadAddress" size="52" placeholder="주소">&nbsp;
				<input type="text" class="form-control" id="sample6_extraAddress" name="extraAddress" size="20" placeholder="참고항목">	
			</div>
			<div class="input-group">
				<input type="text" class="form-control mt-2" id="sample6_detailAddress" name="detailAddress" placeholder="상세주소" >
				<div id="detailAddressInValid" class="invalid-feedback"></div>
				<input type="hidden" id="address" name="address">
			</div>
		</div>
    </div>
    <div class="form-group">
	    <label for="homepage">홈페이지 주소 :</label>
	    <input type="text" class="form-control" name="homepage" id="homepage" placeholder="'http://'없이 홈페이지를 입력하세요." maxlength=20 />
		<div id="homepageInValid" class="invalid-feedback"></div>
	</div>
    <div class="form-group" id="jobGroup">
		<label for="name">직업 : </label>
		<select class="form-control" id="job" name="job">
			<option value="학생">학생</option>
			<option value="회사원">회사원</option>
			<option value="공무원">공무원</option>
			<option value="군인">군인</option>
			<option value="의사">의사</option>
			<option value="법조인">법조인</option>
			<option value="세무인">세무인</option>
			<option value="자영업">자영업</option>
			<option value="기타">기타</option>
		</select>
    </div>
    <div class="form-group" id="hobbyGroup">
        <label >취미 : </label> &nbsp; &nbsp;
		<div class="form-check-inline">
		  <label class="form-check-label">
		    <input type="checkbox" class="form-check-input" value="수영" name="hobby"/>수영
		  </label>
		</div>
		<div class="form-check-inline">
		  <label class="form-check-label">
		    <input type="checkbox" class="form-check-input" value="독서" name="hobby"/>독서
		  </label>
		</div>
		<div class="form-check-inline">
		  <label class="form-check-label">
		    <input type="checkbox" class="form-check-input" value="영화감상" name="hobby"/>영화감상
		  </label>
		</div>
		<div class="form-check-inline">
		  <label class="form-check-label">
		    <input type="checkbox" class="form-check-input" value="축구" name="hobby"/>축구
		  </label>
		</div>
		<div class="form-check-inline">
		  <label class="form-check-label">
		    <input type="checkbox" class="form-check-input" value="기타" name="hobby" checked/>기타
		  </label>
		</div>
		<input type="hidden" id="checkedHobbies" name="checkedHobbies" />
    </div>
    <div class="form-group">
		<label for="content">자기소개 : </label>
		<textarea rows="5" class="form-control" id="content" name="content" placeholder="자기소개를 입력하세요" maxlength=200 ></textarea>
		<div id="contentInValid" class="invalid-feedback"></div>
    </div>
    <div class="form-group" id="userInfoGroup">
		<div class="form-check-inline">
		  <label class="form-check-label">정보공개 : &nbsp;&nbsp;
		    <input type="radio" class="form-check-input" name="userInfo" value="공개" checked/>공개
		  </label>
		</div>
		<div class="form-check-inline">
		  <label class="form-check-label">
		    <input type="radio" class="form-check-input" name="userInfo" value="비공개"/>비공개
		  </label>
		</div>
    </div>
    <div  class="form-group">
      회원 사진(파일용량:2MByte이내) :
		<input type="file" id="fName" name="fName" class="form-control-file border btn-lg p-0 mt-2"/>
		<div id="fNameInValid" class="invalid-feedback"></div>
		<input type="hidden" id="photo" name="photo" />
    </div>
    <div class="form-group text-center">
	    <input type="submit" class="btn btn-info" id="entry" value="회원가입" onclick="editForm(regexCheck())" />
	    <input type="reset" class="btn btn-info"  value="다시작성"/>&nbsp;
	    <input type="button" class="btn btn-info" value="돌아가기" onclick="location.href='${ctxPath}/member/memberLogin';"/><br>
	</div>
  </form>
<!-- End page content -->
</div>

<!-- Footer -->
<jsp:include page="/common/footer.jsp" />
</body>
</html>
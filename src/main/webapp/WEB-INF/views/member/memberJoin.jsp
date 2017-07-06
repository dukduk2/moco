<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/resources/part/bootStrap.jspf" %>
<link rel="styleSheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/header.css">
<link rel="styleSheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/section.css">
<link rel="styleSheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/member.css">
<title>Insert title here</title>

<%-- <script type="text/javascript" src="${pageContext.request.contextPath}/resources/script/join.js"></script> --%>
<script type="text/javascript">
$(function() {
	var idCheck = false;
	var pwCheck = false;
	var answerCheck = false;
	var nameCheck = false;
	var emailCheck = false;

	$("#id").keyup(function(){
		var pattern = /^[A-Za-z0-9]{4,12}$/;
		var id = document.frm.id.value;
		
		$.post("memberIdCheck", {
			id: $("#id").val()
		}, function(data) {
			$("#id_result").html(data);
			
			if(pattern.test(id) == false){
				$("#id_result").html("<font color='red'>아이디는 4~12자리 영문(대소문자 구별), 숫자</font>");
				idCheck = false;
			} else if(id == "") {
				$("#id_result").html("아이디를 입력해주세요");
				idCheck = false;
			} else {
				idCheck = true;
			}
		})
	});
	
	$("#pw1").keyup(function(){
		var pattern = /^[A-Za-z0-9]{8,14}$/;
		var pw1 = document.frm.pw1.value;
		var pw2 = document.frm.pw2.value;
		
		if(pattern.test(pw1) == false){
			$("#pw_result1").html("비밀번호는 8~14자리 영문(대소문자 구별), 숫자");
		} else {
			$("#pw_result1").html("<font color='blue'>Check!!</font>");
		}
		
		if(pw1 != pw2) {
			$("#pw_result2").html("<font color='red'>비밀번호가 다릅니다.</font>");
			pwCheck = false;
		} else {
			$("#pw_result2").html("<font color='blue'>Check!!</font>");
			pwCheck = true;
		}
	});
	
	$("#pw2").keyup(function(){
		var pattern = /^[A-Za-z0-9]{8,14}$/;
		var pw1 = document.frm.pw1.value;
		var pw2 = document.frm.pw2.value;
		
		if(pw1 != pw2) {
			$("#pw_result2").html("<font color='red'>비밀번호가 다릅니다.</font>");
			pwCheck = false;
		} else {
			$("#pw_result2").html("<font color='blue'>Check!!</font>");
			pwCheck = true;
		}
	});
	
	$("#answer").keyup(function(){
		var answer = document.frm.answer.value;
		
		if(answer == "") {
			answerCheck = false;
		} else {
			answerCheck = true;
		}
	});
	
	
	$("#name").keyup(function(){
		var name = document.frm.name.value;
		
		if(name == "") {
			nameCheck = false;
		} else {
			nameCheck = true;
		}
	});
	
	$("#email").keyup(function(){
		var pattern = /^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,3}$/;
		var email = document.frm.email.value;
		
		if(email == "") {
			emailCheck = false;
		} else {
			emailCheck = true;
		}
	});

	$("#kind").click(function(){
		var kind = document.frm.kind.value;
		
		if(kind == "일반") {
			$("#joinState").val("승인");
		} else if(kind == "배우" || kind == "감독" || kind == "평론가") {
			$("#joinState").val("대기");
		}
	});
	
	$("#frm").on("click", "#btn", function() {
		if(idCheck == false){
			alert("아이디를 다시 확인해주세요");
		} else if(pwCheck == false){
			alert("비밀번호를 다시 확인해주세요");
		} else if(answerCheck == false){
			alert("대답을 다시 확인해주세요");
		} else if(nameCheck == false){
			alert("이름을 다시 확인해주세요");
		} else if(emailCheck == false){
			alert("이메일을 다시 확인해주세요");
		} else {
			document.frm.submit("memberJoin");
		}
	});
});
</script>

</head>
<body>
		<div class="container">
			<h2 class="title">Member Join</h2>

			<form action="memberJoin" name="frm" id="frm" method="POST" enctype="multipart/form-data">
				<table class="member_Table">
					<tr>
						<td class="name">*ID:</td>
						<td class="push"><input type="text" class="form-control" name="id" id="id" required="required"></td>
						<td class="result"><p id="id_result"></p></td>
					</tr>
					
					<tr>
						<td class="name">*PW:</td>
						<td class="push"><input type="password" class="form-control" name="password" id="pw1"></td>
						<td class="result"><p id="pw_result1"></p></td>
					</tr>
					
					<tr>
						<td class="name">*PW Check:</td>
						<td class="push"><input type="password" class="form-control" id="pw2"></td>
						<td class="result"><p id="pw_result2"></p></td>
					</tr>
					
					<tr>
						<td class="name">*Password Find Question</td>
						<td class="push">
							<select class="form-control" name="question">
							<option value="초등학교">초등학교는?</option>
							<option value="배우자">배우자는?</option>
							<option value="별명">별명은?</option>
						</select></td>
					</tr>
					
					<tr>
						<td class="name">*ANSWER:</td>
						<td class="push"><input type="text" class="form-control" name="answer" id="answer"></td>
					</tr>
					
					<tr>
						<td class="name">*NAME:</td>
						<td class="push"><input type="text" class="form-control" name="name" id="name"></td>
					</tr>
					
					<tr>
						<td class="name">DATE</td>
						<td class="push"><input type="date" class="form-control" name="birth"></td>
					</tr>
					
					<tr>
						<td class="name">ADDRESS</td>
						<td class="push"><input type="text" class="form-control" name="address"></td>
					</tr>
					
					<tr>
						<td class="name">PHONE</td>
						<td class="push"><input type="text" class="form-control" name="phone"></td>
					</tr>
					
					<tr>
						<td class="name">*EMAIL</td>
						<td class="push"><input type="email" class="form-control" name="email" id="email"></td>
					</tr>
					
					<tr>
						<td class="name">*KIND</td>
						<td class="push"><select class="form-control" name="kind" id="kind">
							<option value="일반" selected="selected">일반</option>
							<option value="배우">배우</option>
							<option value="감독">감독</option>
							<option value="평론가">평론가</option>
						</select></td>
					</tr>
					
					<tr>
						<td class="name">IMG</td>
						<td class="push"><input type="file" class="form-control" name="f1"></td>
					</tr>
					
					<tr>
						<td class="name" colspan="2"><input type="button" id="btn" class="btn btn-success" style="width: 100%;" value="가입"></td>
					</tr>
				</table>
		
				<input type="number" name="likes" readonly="readonly" hidden="hidden" value=0>
				<input type="number" name="point" readonly="readonly" hidden="hidden" value=0>
				<input type="number" name="avaliableLikes" readonly="readonly" hidden="hidden" value=0>
				<input type="text" name="grade" readonly="readonly" hidden="hidden" value="일반">
				<input type="text" name="joinState" id="joinState" hidden="hidden" value="승인">
				
			</form>
		</div>
</body>
</html>
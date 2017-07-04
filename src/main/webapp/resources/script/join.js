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
				$("#id_result").html("아이디는 4~12자리 영문(대소문자 구별), 숫자");
				idCheck = false;
			} else if(id == "") {
				$("#id_result").html("아이디를 입력해주세요");
				idCheck = false;
			} else {
				idCheck = true;
			}
		})
	})
	
	$("#pw1").keyup(function(){
		var pattern = /^[A-Za-z0-9]{8,14}$/;
		var pw1 = document.frm.pw1.value;
		var pw2 = document.frm.pw2.value;
		
		if(pattern.test(pw1) == false){
			$("#pw_result1").html("비밀번호는 8~14자리 영문(대소문자 구별), 숫자");
		} else {
			$("#pw_result1").html("Check!!");
		}
		
		if(pw1 != pw2) {
			$("#pw_result2").html("비밀번호가 다릅니다.");
			pwCheck = false;
		} else {
			$("#pw_result2").html("Check!!");
			pwCheck = true;
		}
	})
	
	$("#pw2").keyup(function(){
		var pattern = /^[A-Za-z0-9]{8,14}$/;
		var pw1 = document.frm.pw1.value;
		var pw2 = document.frm.pw2.value;
		
		if(pw1 != pw2) {
			$("#pw_result2").html("비밀번호가 다릅니다.");
			pwCheck = false;
		} else {
			$("#pw_result2").html("Check!!");
			pwCheck = true;
		}
	})
	
	$("#answer").keyup(function(){
		var answer = document.frm.answer.value;
		
		if(answer == "") {
			answerCheck = false;
		} else {
			answerCheck = true;
		}
	})
	
	
	$("#name").keyup(function(){
		var name = document.frm.name.value;
		
		if(name == "") {
			nameCheck = false;
		} else {
			nameCheck = true;
		}
	})
	
	$("#email").keyup(function(){
		var pattern = /^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,3}$/;
		var email = document.frm.email.value;
		
		if(email == "") {
			emailCheck = false;
		} else {
			emailCheck = true;
		}
	})
	
	$("#kind").click(function(){
		var kind = document.frm.kind.value;
		
		if(kind == "일반") {
			$("#joinState").val("승인");
		} else if(kind == "배우" || kind == "감독" || kind == "평론가") {
			$("#joinState").val("대기");
		}
	})
	
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
	})
});
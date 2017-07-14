<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/resources/part/bootStrap.jspf"%>
<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.js"></script>
<link rel="styleSheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/header.css">
<link rel="styleSheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/section.css">
<title>Insert title here</title>
<script src="../resources/SE2/js/HuskyEZCreator.js"></script>
<script type="text/javascript">
	$(function(){
		var editor_object = [];
	     
	    nhn.husky.EZCreator.createInIFrame({
	        oAppRef: editor_object,
	        //textarea ID
	        elPlaceHolder: "contents",
	        sSkinURI: "../resources/SE2/SmartEditor2Skin.html", 
	        htParams : {
	            // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
	            bUseToolbar : true,             
	            // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
	            bUseVerticalResizer : true,     
	            // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
	            bUseModeChanger : true, 
	        }
	    });
		
		$("#update").click(function() {
			editor_object.getById["contents"].exec("UPDATE_CONTENTS_FIELD", []);
			$("#frm").submit();
		});
	});
</script>
<style type="text/css">
.contents-wrap {
	width: 1000px;
	margin: 0 auto;
}
#update{
	float: right;
}
</style>
</head>
<body>
		<div class="contents-wrap">
			<h2>ActorPR UPDATE</h2>
			<form action="./noticeUpdate" method="post" id="frm">
				<input type="hidden" name="num" value="${dto.num }">

				<div class="form-group">
					<label>TITLE :</label> <input type="text" name="title"
						class="form-control" value="${dto.title }">
				</div>
				<div class="form-group">
					<label>WRITER :</label> <input type="text" name="director"
						class="form-control" value="${dto.writer }" readonly="readonly">
				</div>

				<div class="form-group">
					<textarea id="contents" name="contents" class="form-control" style="height: 300px; width: 995px;" placeholder="Enter Contents">
						${dto.contents }
					</textarea>
				</div>

				<input type="button" value="UPDATE" id="update" class="btn btn-default">
			</form>
		</div>
</body>
</html>
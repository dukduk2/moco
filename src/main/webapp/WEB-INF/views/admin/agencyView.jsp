<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/resources/part/bootStrap.jspf" %>
<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.js"></script>
<link rel="styleSheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/header.css">
<link rel="styleSheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/section.css">
<link rel="styleSheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/list.css">
<title>MOVIE COMMUNICATION</title>
<script type="text/javascript">
	$(function(){
		$("#commit").click(function(){
			$("#frm").attr("action","./agencyCommit");
			$("#frm").submit();
			alert("승인 완료");
		});
		
		$("#cancel").click(function(){
			$("#frm").attr("action","./agencyCommitCancel");
			$("#frm").submit();
			alert("승인 취소");
		});
		
		$("#refuse").click(function(){
			$("#frm").attr("action","./agencyDelete");
			$("#frm").submit();
			alert("승인 거절");
		});
	});
</script>
<style type="text/css">
.contents-wrap{
	width:700px;
	margin:0 auto;
}
.titleSpan{
	font-size: 1.2em;
	font-weight: bold;
	font-family: Montserrat, sans-serif;
}
</style>
</head>
<body>
	<%@ include file="/resources/part/header3.jspf" %>
	<section>
		<div class="container">
			<h2 style="text-align: center;">AGENCY VIEW</h2>
			
			<form action="" id="frm" method="post">
				<input type="hidden" name="num" value="${dto.num }">
				<table>
					<tr>
						<td class="write-tdName"><span class="titleSpan">TITLE</span></td>
						<td class="write-tdWrite">${dto.title}</td>
					</tr>
					<tr>
						<td class="write-tdName"><span class="titleSpan">DIRECTOR</span></td>
						<td class="write-tdWrite">${dto.director }</td>
					</tr>
					<tr>
						<td class="write-tdName"><span class="titleSpan">PUBDATE</span></td>
						<td class="write-tdWrite">${dto.pubdate }</td>
					</tr>
					<tr>
						<td class="write-tdName"><span class="titleSpan">AGENCY CERTIFICATE</span></td>
						<td class="write-tdWrite"><img alt="" src="../resources/upload/agency/${dto.fname }"></td>
					</tr>
					<tr><td colspan="2">
							<c:if test="${dto.commit eq 0 }">
								<input type="button" class="btn btn-default" id="commit" value="승인">
								<input type="button" class="btn btn-default" id="refuse" value="승인거절">
							</c:if>
							<c:if test="${dto.commit eq 1 }">
								<input type="button" class="btn btn-default" id="cancel" value="승인취소">
							</c:if>
					</td></tr>
				</table>
			</form>
	
		</div>
	
	</section>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/resources/part/bootStrap.jspf" %>
<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.js"></script>
<link rel="styleSheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/header.css">
<link rel="styleSheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/section.css">
<title>Insert title here</title>
<script type="text/javascript">
	$(function() {
		var insertMessage = '${insertMessage}';
		var processMessage = '${processMessage}';
		if(insertMessage != null && insertMessage != ''){
			alert(insertMessage);
		}
		if(processMessage != null && processMessage != ''){
			if(confirm(processMessage)){
				location.href="./movieInfoWriteForm";
			}
		}
	});
</script>
<style type="text/css">
	.titleCSS{
		font-family: Montserrat, sans-serif;
		text-align: center;
		font-weight: bold;
		font-size: 2em;
	}
	.menuTable{
		margin : 0 auto;
		width: 1000px;
		border: 2px ridge black;
	}
	tr{
		border: 2px ridge black;	
	}
	.iconIMG{
		width: 150px;
		height: 150px;
	}
	.titleSpan{
		font-size: 1.4em;
		font-weight: bold;
	}
	.badge{
		font-size: 1.4em;
	}
	.tableTR{
		height: 180px;
	}
	.imgTD{
		text-align: center;
	}
	.titleTD{
		text-align: left;
	}
	.contentsTD{
		vertical-align: middle;
		border-right: 2px ridge black;	
	}
</style>
</head>
<body>
	<%@ include file="/resources/part/header3.jspf" %>
	<section>
		<table class="menuTable">
			<tr class="tableTR">
				<td colspan="4" class="imgTD">
					<div>
						<img class="iconIMG" alt="" src="../resources/adminIndexIcon/menu_icon.png">
						&nbsp;&nbsp;&nbsp;&nbsp;<span class="titleCSS">Admin Menu</span>
					</div>
				</td>
			</tr>
			<tr class="tableTR">
				<!-- Member 관리 -->
				<td class="imgTD">
					<a href="./memberList" class="imgATag"><img alt="" src="../resources/adminIndexIcon/member_icon.png" class="iconIMG"></a>
				</td>
				<td class="titleTD contentsTD">
					<span class="titleSpan"><a href="./memberList">회원 관리</a></span>
					<span class="badge">${memberStateCount}</span>
				</td>
				<!-- movieInfo -->
				<td class="imgTD">
					<a href="./movieInfoWriteForm"><img class="iconIMG" alt="" src="../resources/adminIndexIcon/movieInfo_icon.png"></a>
				</td>
				<td class="contentsTD">
					<span class="titleSpan"><a href="./movieInfoWriteForm">영화 정보 업로드</a></span>
				</td>
			</tr>
			<tr class="tableTR">
				<!-- screen 관리 -->
				<td class="imgTD">
					<a href="./screenCommit" class="imgATag"><img alt="" src="../resources/adminIndexIcon/screen_icon.png" class="iconIMG"></a>
				</td>
				<td class="contentsTD">
					<span class="titleSpan"><a href="./screenCommit">상영 관리</a></span>
					<span class="badge">${screenUnCommitCount}</span>			
				</td>
				<!-- theater 승인 -->
				<td class="imgTD">
					<a href="./theaterCommit" class="imgATag"><img alt="" src="../resources/adminIndexIcon/theater_icon.png" class="iconIMG"></a>
				</td>
				<td class="contentsTD">
					<span class="titleSpan"><a href="./theaterInsert">극장 추가</a></span>
					<span class="badge">${theaterUnCommitCount}</span>
				</td>
			</tr>
			<tr class="tableTR">
				<!-- movieRequest -->
				<td class="imgTD">
					<a href="./movieRequestList" class="imgATag"><img alt="" src="../resources/adminIndexIcon/movieRequest_icon.png" class="iconIMG"></a>
				</td>
				<td class="contentsTD">
					<span class="titleSpan"><a href="./movieRequestList">영화 요청</a></span>
					<span class="badge">${movieRequest}</span>
				</td>
				<!-- movieUpload -->
				<td class="imgTD">
					<a href="./movieUpload" class="imgATag"><img alt="" src="../resources/adminIndexIcon/upload_icon.png" class="iconIMG"></a>
				</td>
				<td class="contentsTD">
					<span class="titleSpan"><a href="./movieUpload">영화 업로드</a></span>
				</td>
			</tr>
			<tr class="tableTR">
				<!-- userboardCommit -->
				<td class="imgTD">
					<a href="./userBoardCommit" class="imgATag"><img alt="" src="../resources/adminIndexIcon/userBoardCommit_icon.png" class="iconIMG"></a>
				</td>
				<td class="contentsTD">
					<span class="titleSpan"><a href="./userBoardCommit">게시글 승인 관리</a></span>
					<span class="badge">${userBoardCommitCount}</span>
				</td>
				<!-- agency -->
				<td class="imgTD">
					<a href="./agencyList" class="imgATag"><img alt="" src="../resources/adminIndexIcon/agency_icon.png" class="iconIMG"></a>
				</td>
				<td class="contentsTD">
					<span class="titleSpan"><a href="./agencyList">배급사 승인 관리</a></span>
					<span class="badge">${agencyCommitCount}</span>			
				</td>
			</tr>
			<tr class="tableTR">
				<!-- season -->
				<td class="imgTD">
					<a href="./adminSeason" class="imgATag"><img alt="" src="../resources/adminIndexIcon/season_icon.png" class="iconIMG"></a>
				</td>
				<td class="contentsTD">
					<span class="titleSpan"><a href="./adminSeason">시즌 관리</a></span>
				</td>
				<!-- schedule  -->
				<td class="imgTD">
					<a href="./movieScheduleList" class="imgATag"><img alt="" src="../resources/adminIndexIcon/schedule_icon.png" class="iconIMG"></a>
				</td>
				<td class="contentsTD">
					<span class="titleSpan"><a href="./movieScheduleList">영화 편성표 관리</a></span>
				</td>
			</tr>
		</table>
	</section>
	
</body>
</html>
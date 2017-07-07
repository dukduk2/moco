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
	.titleTR{
		text-align: center;
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
	<%@ include file="/resources/part/header2.jspf" %>
	<section>
		<table class="menuTable">
			<tr class="titleTR tableTR">
				<!-- Member 관리 -->
				<td>
					<a href="./memberList" class="imgATag"><img alt="" src="../resources/adminIndexIcon/member_icon.png" class="iconIMG"></a>
				</td>
				<td class="titleTD contentsTD">
					<span class="titleSpan"><a href="./memberList">memberList</a></span>
					<span class="badge">${memberStateCount}</span>
				</td>
				<!-- movieInfo -->
				<td>
					<a href="./movieInfoWriteForm"><img class="iconIMG" alt="" src="../resources/adminIndexIcon/movieInfo_icon.png"></a>
				</td>
				<td>
					<a href="./movieInfoWriteForm"><span class="titleSpan">MovieInfoUpload</span></a>
				</td>
			</tr>
			<tr class="tableTR">
				<!-- movieRequest -->
				<td class="imgTD">
					<a href="./movieRequestList" class="imgATag"><img alt="" src="../resources/adminIndexIcon/movieRequest_icon.png" class="iconIMG"></a>
				</td>
				<td class="contentsTD">
					<span class="titleSpan"><a href="./movieRequestList">MovieRequest</a></span>
					<span class="badge">${movieRequest}</span>
				</td>
				<!-- movieUpload -->
				<td class="imgTD">
					<a href="./movieUpload" class="imgATag"><img alt="" src="../resources/adminIndexIcon/upload_icon.png" class="iconIMG"></a>
				</td>
				<td class="contentsTD">
					<span class="titleSpan"><a href="./movieUpload">Movie Upload</a></span>
				</td>
			</tr>
			<tr class="tableTR">
				<!-- season -->
				<td class="imgTD">
					<a href="./adminSeason" class="imgATag"><img alt="" src="../resources/adminIndexIcon/season_icon.png" class="iconIMG"></a>
				</td>
				<td class="contentsTD">
					<span class="titleSpan"><a href="./adminSeason">SEASON</a></span>
				</td>
				<!-- schedule  -->
				<td class="imgTD">
					<a href="./movieScheduleList" class="imgATag"><img alt="" src="../resources/adminIndexIcon/schedule_icon.png" class="iconIMG"></a>
				</td>
				<td class="contentsTD">
					<span class="titleSpan"><a href="./movieScheduleList">movieScheduleList</a></span>
				</td>
			</tr>
			<tr class="tableTR">
				<!-- userboardCommit -->
				<td class="imgTD">
					<a href="./userBoardCommit" class="imgATag"><img alt="" src="../resources/adminIndexIcon/userBoardCommit_icon.png" class="iconIMG"></a>
				</td>
				<td class="contentsTD">
					<span class="titleSpan"><a href="./userBoardCommit">userBoard Commit</a></span>
					<span class="badge">${userBoardCommitCount}</span>
				</td>
				<!-- agency -->
				<td class="imgTD">
					<a href="./agencyList" class="imgATag"><img alt="" src="../resources/adminIndexIcon/agency_icon.png" class="iconIMG"></a>
				</td>
				<td class="contentsTD">
					<span class="titleSpan"><a href="./agencyList">Agency</a></span>
					<span class="badge">${agencyCommitCount}</span>			
				</td>
			</tr>
		</table>
	</section>
	
</body>
</html>
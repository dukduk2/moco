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
<link rel="styleSheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/list.css">
<title>MOVIE COMMUNICATION</title>
<script type="text/javascript">
	$(function() {
		
		// Season insert
		$("#insert").click(function() {
			$("#adminSeasonInsert").submit();			
		});
		
		// user Page
		$(".ugo").click(function(){
			var curPage=$(this).attr("id");
			$.get("./userSeasonList?curPage="+curPage,
				function(data){
					$("#userBoardSeason").html(data);
				});
		});
		
		// actor Page
		$(".ago").click(function(){
			var curPage=$(this).attr("id");
			$.get("./actorSeasonList?curPage="+curPage,
				function(data){
					$("#actorPRBoardSeason").html(data)
				});
		});
		
		
		// delete
		$(".SeasonDelete").click(function() {
			var num = $(this).attr("id");
			alert(num);
			$.post("adminSeasonDelete",
				{
					num : num
				},
				function(data){
					location.reload();
				});
		});
		
	});
</script>

</head>
<body>
	<%@ include file="/resources/part/header3.jspf"%>
	<section>
		<div class="container">
			<!-- Trigger the modal with a button -->
			<button type="button" class="btn btn-default btn-lg"
				data-toggle="modal" data-target="#myModal">ADD</button>
			<!-- Modal -->
			<div class="modal fade" id="myModal" role="dialog">
				<div class="modal-dialog">

					<!-- Modal content-->
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal">&times;</button>
							<h4 class="modal-title">시즌을 추가하세요.</h4>
						</div>
						<!-- Form -->
						<form action="adminSeasonInsert" method="post"
							id="adminSeasonInsert">
							<div class="modal-body">
								<table>
									<tr class="TR">
										<td class="titleTD">시즌</td>
										<td><input type="text" name="season"
											placeholder="season을 입력하세요" class="form-control"></td>
									</tr>
									<tr class="TR">
										<td class="titleTD">시작 날짜</td>
										<td><input type="date" name="startDate"
											class="form-control"></td>
									</tr>
									<tr class="TR">
										<td class="titleTD">종료 날짜</td>
										<td><input type="date" name="endDate"
											class="form-control"></td>
									</tr>
									<tr class="TR">
										<td class="titleTD">구분</td>
										<td><select name="kind" class="form-control"><option
													value="user">user</option>
												<option value="actor">actor</option></select></td>
									</tr>
								</table>
							</div>
							<div class="modal-footer">
								<input type="button" value="insert" id="insert"
									class="btn btn-success">
							</div>
						</form>
						<!-- endForm -->
					</div>

				</div>
			</div>

			<!-- end Season Modal -->

			<!-- ---------------------------------------------------------USER ----------------------------------------------------->
			<h2 style="text-align: center;">UserBoard SEASON</h2>
			<div class="container" id="userBoardSeason">
				<table class="table table-hover">
					<thead><tr class="head">
						<td>NUM</td>
						<td>SEASON</td>
						<td>START</td>
						<td>END</td>
						<td>STATE</td>
						<td>FUNCTION</td>
					</tr></thead>
					
					<tbody><c:forEach items="${userSeason}" var="user">
						<tr>
							<td>${user.num}</td>
							<td>${user.season }</td>
							<td>${user.startDate }</td>
							<td>${user.endDate }</td>
							<c:if test="${user.state == 0}">
								<td>시즌 기간 아님</td>
								<td>
									<button class="btn btn-danger SeasonDelete" id="${user.num}">Delete</button>
								</td>
							</c:if>
							<c:if test="${user.state == 1}">
								<td>진행 중</td>
								<td>
									<button class="btn btn-danger SeasonDelete" id="${user.num}">Delete</button>
								</td>
							</c:if>
						</tr>
					</c:forEach></tbody>
				</table>
			</div>
			
			<div class="paging">
				<div class="btn-group">
					<c:if test="${upageResult.curBlock>1}">
						<input type="button" class="ugo btn btn-default" id="${upageResult.startNum-1}" value="[이전]">
					</c:if>
					<c:forEach begin="${upageResult.startNum}" end="${upageResult.lastNum}" var="i">
						<input type="button" class="ugo btn btn-default" id="${i}" value="${i}">
					</c:forEach>
					<c:if test="${upageResult.curBlock<upageResult.totalBlock}">
						<input type="button" class="ugo btn btn-default" id="${upageResult.lastNum+1}" value="[다음]">
					</c:if>
				</div>
			</div>
			<hr>

			<!-- ---------------------------------------------------------ACTOR ----------------------------------------------------->
			<h2 style="text-align: center;">ActorPRBoard SEASON</h2>
			<div class="container" id="actorPRBoardSeason">
				<table class="table table-hover">
					<thead><tr class="head">
						<td>NUM</td>
						<td>SEASON</td>
						<td>START</td>
						<td>END</td>
						<td>STATE</td>
						<td>FUNCTION</td>
					</tr></thead>

					<c:forEach items="${actorSeason}" var="actor">
						<tr>
							<td>${actor.num}</td>
							<td>${actor.season }</td>
							<td>${actor.startDate }</td>
							<td>${actor.endDate }</td>
							<c:if test="${actor.state == 0}">
								<td>시즌 기간 아님</td>
								<td>
									<button class="btn btn-danger SeasonDelete" id="${actor.num}">Delete</button>
								</td>
							</c:if>
							<c:if test="${actor.state == 1}">
								<td>진행 중</td>
								<td>
									<button class="btn btn-danger SeasonDelete" id="${actor.num}">Delete</button>
								</td>
							</c:if>
						</tr>
					</c:forEach>
				</table>
			</div>
			
			<div class="paging">
				<div class="btn-group">
					<c:if test="${apageResult.curBlock>1}">
						<input type="button" class="ago btn btn-default" id="${apageResult.startNum-1}" value="[이전]">
					</c:if>
					<c:forEach begin="${apageResult.startNum}" end="${apageResult.lastNum}" var="i">
						<input type="button" class="ago btn btn-default" id="${i}" value="${i}">
					</c:forEach>
					<c:if test="${apageResult.curBlock<apageResult.totalBlock}">
						<input type="button" class="ago btn btn-default" id="${apageResult.lastNum+1}" value="[다음]">
					</c:if>
				</div>
			</div>
		</div>

	</section>
</body>
</html>
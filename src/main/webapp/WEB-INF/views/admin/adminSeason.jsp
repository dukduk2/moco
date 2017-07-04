<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
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
<style type="text/css">
	.title{
		text-align: center;
	}
	.btnBox{
		text-align: right;
	}
	.paging{
		text-align: center;
	}
	.form-control{
		width: 300px;
	}
	.TR{
		height: 50px;	
	}
	.titleTD{
		width: 100px;
	}
</style>
</head>
<body>

<br><Br>


<div class="container">
  <!-- Trigger the modal with a button -->
  <button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#myModal">Season Insert</button>
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
        <form action="adminSeasonInsert" method="post" id="adminSeasonInsert">
	        <div class="modal-body">
	    		<table>
	    			<tr class="TR">
	    				<td class="titleTD">시즌</td>
	    				<td><input type="text" name="season" placeholder="season을 입력하세요" class="form-control"></td>
	    			</tr>
	    			<tr class="TR">
	    				<td class="titleTD">시작 날짜</td>
	    				<td><input type="date" name="startDate" class="form-control"></td>
	    			</tr>
	    			<tr class="TR">
	    				<td class="titleTD">종료 날짜</td>
	    				<td><input type="date" name="endDate" class="form-control"></td>
	    			</tr>
	    			<tr class="TR">
	    				<td class="titleTD">구분</td>
	    				<td>
	    					<select name="kind" class="form-control"><option value="user">user</option><option value="actor">actor</option></select>
	    				</td>
	    			</tr>
	    		</table>
	        </div>
	        <div class="modal-footer">
	          <input type="button" value="insert" id="insert" class="btn btn-success">
	        </div>
	    </form>
        <!-- endForm -->
      </div>
      
    </div>
  </div>
  
</div>
<!-- end Season Modal -->

<!-- ---------------------------------------------------------USER ----------------------------------------------------->
<h3 class="title">userBoard SEASON</h3>
<div class="container" id="userBoardSeason">
	<table class="table">
				<tr>
					<td>NUM</td>
					<td>SEASON</td>
					<td>START</td>
					<td>END</td>
					<td>STATE</td>
					<td>FUNCTION</td>
				</tr>
			<c:forEach items="${userSeason}" var="user">
				<tr>
					<td>${user.num}</td>
					<td>${user.season }</td>
					<td>${user.startDate }</td>
					<td>${user.endDate }</td>
					<c:if test="${user.state == 0}">
						<td>시즌 기간 아님</td>
						<td>
							<button class="btn btn-danger SeasonDelete" id="${user.num}">시즌 삭제</button>
						</td>
					</c:if>
					<c:if test="${user.state == 1}">
						<td>진행 중</td>
						<td>
							<button class="btn btn-danger SeasonDelete" id="${user.num}">시즌 삭제</button>
						</td>
					</c:if>
				</tr>
		</c:forEach>
	</table>
</div>
	<!-- 페이징 처리 -->
	<div class="paging">
		<c:if test="${upageResult.curBlock>1}">
			<button class="btn"><span class="ugo" id="${upageResult.startNum-1}">[이전]</span></button>
		</c:if>
		<c:forEach begin="${upageResult.startNum}" end="${upageResult.lastNum}" var="i">
			<button class="btn"><span class="ugo" id="${i}">${i}</span></button>
		</c:forEach>
		<c:if test="${upageResult.curBlock<upageResult.totalBlock}">
			<button class="btn"><span class="ugo" id="${upageResult.lastNum+1}">[다음]</span></button>
		</c:if>
	</div>
	<hr>

<!-- ---------------------------------------------------------ACTOR ----------------------------------------------------->
<h3 class="title">actorPRBoard SEASON</h3>
<div class="container" id="actorPRBoardSeason">
	<table class="table">
				<tr>
					<td>NUM</td>
					<td>SEASON</td>
					<td>START</td>
					<td>END</td>
					<td>STATE</td>
					<td>FUNCTION</td>
				</tr>
			<c:forEach items="${actorSeason}" var="actor">
				<tr>
					<td>${actor.num}</td>
					<td>${actor.season }</td>
					<td>${actor.startDate }</td>
					<td>${actor.endDate }</td>
					<c:if test="${actor.state == 0}">
						<td>시즌 기간 아님</td>
						<td>
							<button class="btn btn-danger SeasonDelete" id="${actor.num}">시즌 삭제</button>
						</td>
					</c:if>
					<c:if test="${actor.state == 1}">
						<td>진행 중</td>
						<td>
							<button class="btn btn-danger SeasonDelete" id="${actor.num}">시즌 삭제</button>
						</td>
					</c:if>
				</tr>
		</c:forEach>
	</table>
</div>
	<!-- 페이징 처리 -->
	<div class="paging">
		<c:if test="${apageResult.curBlock>1}">
			<button class="btn"><span class="ago" id="${apageResult.startNum-1}">[이전]</span></button>
		</c:if>
		<c:forEach begin="${apageResult.startNum}" end="${apageResult.lastNum}" var="i">
			<button class="btn"><span class="ago" id="${i}">${i}</span></button>
		</c:forEach>
		<c:if test="${apageResult.curBlock<apageResult.totalBlock}">
			<button class="btn"><span class="ago" id="${apageResult.lastNum+1}">[다음]</span></button>
		</c:if>
	</div>
	
	<br>
	
	<!-- BTN -->
	<div class="container btnBox">
		<a href="./index"><button class="btn">Admin Index</button></a>&nbsp;
		<a href="../"><button class="btn">HOME</button></a>
	</div>
	
	
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

<!-- jQuery library -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<!-- Latest compiled JavaScript -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script type="text/javascript">
	$(function() {
		var curPage1 = ${map1.curPage1}; //commit
		var curPage2 = ${map2.curPage2}; //uncommit

		$(".go1").click(function() {
			curPage1 = $(this).attr("id");

			$.get("./agencyCommitList?curPage=" + curPage1, 
					function(data) {
				$("#commitAjax").html(data);
			});
		});
		
		$(".go2").click(function() {

			curPage2 = $(this).attr("id");
			$.get("./agencyUncommitList?curPage=" + curPage2, function(data) {
				$("#uncommitAjax").html(data);
			});
		});
		
		/* $("#uncommitBtn").click(function() {
			$.get("./agencyUncommitList?curPage=" + curPage2, function(data) {
				$("#uncommitAjax").html(data);
			});
		}); */

		
	});
</script>
<style type="text/css">
.contents-wrap {
	width: 1000px;
	margin: 0 auto;
}
</style>
</head>
<body>
	<div class="contents-wrap">
		<h2>AGENCY LIST</h2>

		<h3>승인되지 않은 배급사</h3>
		<!-- <button id="uncommitBtn">UNCOMMIT LIST</button> -->
		<div id="uncommitAjax">
		<table class="table table-hover">
		<tr>
			<th>num</th>
			<th>title</th>
			<th>director</th>
			<th>pubdate</th>
		</tr>
		<c:forEach items="${list2 }" var="dto">
			<tr>
			<td>${dto.num }</td>
			<td><a href="./agencyView?num=${dto.num}">${dto.title }</a></td>
			<td>${dto.director }</td>
			<td>${dto.pubdate }</td>	
			</tr>
		</c:forEach>
		</table>
		</div>
		
		<div class="paging">
			<c:if test="${pageResult2.curBlock>1 }">
				<button class="btn">
					<span class="go2" id="${pageResult2.startNum-1}">[이전]</span>
				</button>
			</c:if>
			<c:forEach begin="${pageResult2.startNum}" end="${pageResult2.lastNum}"
				var="i">
				<button class="btn">
					<span class="go2" id="${i}">${i}</span>
				</button>
			</c:forEach>
			<c:if test="${pageResult2.curBlock<pageResult2.totalBlock}">
				<button class="btn">
					<span class="go2" id="${pageResult2.lastNum+1}">[다음]</span>
				</button>
			</c:if>
		</div>

		<h3>승인된 배급사</h3>
		<!-- <button id="commitBtn">COMMIT LIST</button> -->
		<div id="commitAjax">
		<table class="table table-hover">
			<tr>
				<th>num</th>
				<th>title</th>
				<th>director</th>
				<th>pubdate</th>
			</tr>
			<c:forEach items="${list1 }" var="dto">
			<tr>
				<td>${dto.num }</td>
				<td><a href="./agencyView?num=${dto.num}">${dto.title }</a></td>
				<td>${dto.director }</td>
				<td>${dto.pubdate }</td>
			</tr>
	</c:forEach>
			
		</table>
</div>
		<div class="paging">
			<c:if test="${pageResult1.curBlock>1 }">
				<button class="btn">
					<span class="go1" id="${pageResult1.startNum-1}">[이전]</span>
				</button>
			</c:if>
			<c:forEach begin="${pageResult1.startNum}" end="${pageResult1.lastNum}"
				var="i">
				<button class="btn">
					<span class="go1" id="${i}">${i}</span>
				</button>
			</c:forEach>
			<c:if test="${pageResult1.curBlock<pageResult1.totalBlock}">
				<button class="btn">
					<span class="go1" id="${pageResult1.lastNum+1}">[다음]</span>
				</button>
			</c:if>
		</div>
		<%-- <table class="table table-hover">
		<th>num</th>
		<th>title</th>
		<th>director</th>
		<th>pubdate</th>
		<c:forEach items="${list }" var="dto">
		<c:if test="${dto.commit eq 1 }">
			<tr>
			<td>${dto.num }</td>
			<td><a href="./agencyView?num=${dto.num}">${dto.title }</a></td>
			<td>${dto.director }</td>
			<td>${dto.pubdate }</td>
			
			
			</tr>
			</c:if>
		</c:forEach>
		</table> --%>



		<p>
			<a class="btn btn-info" href="../">HOME</a>
		</p>

	</div>
</body>
</html>
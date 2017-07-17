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
		$("#insertForm_div").hide();
		$(".videoTR").hide();
		var check = false;
		
		// videoView
		$(".videoView").click(function() {
			var id = $(this).attr("id");
			var iid = id+"TR";
			if(!check){
				$("#"+iid+"").show();
				check = !check;
			}else{
				$("#"+iid+"").hide();
				check = !check;
			}
		});
		
		/* // videoCancel
		$(".videoCancel").click(function() {
			var id = $(this).attr("id");
			var iid = id+"TR";
			$("#"+iid+"").hide();
		}); */
		
		// upload
		$("#upload").click(function(){
			$("#insertForm").submit();
		});

		// x
		$("#x").click(function() {
			var fileU = $("#file").val();
	    	if(fileU.length > 0){
	    		var check = window.confirm("현재 선택된 파일을 지우시겠습니까?");
	    		if(check){
	    			$("#file").val("");
	    		}
	    	}else {
	    		alert("현재 선택된 파일이 없습니다.");
	    	}
		});
		
		// delete
		$(".movieDelete").click(function() {
			var fileName = $(this).attr("id");
			$.post("./movieDelete",
				{
					fileName : fileName
				},
				function(data){
					location.reload();
				});
		});
		
		// page
		$(".go").click(function(){
			var curPage=$(this).attr("id");
			location.href="./movieUpload?curPage="+curPage+"&search=${map.search}";
		});
		
	});
</script>
<style type="text/css">
.videoView{
	font-weight : 1.5em;
	font-weight : bold;
	cursor: pointer;
}
#x{
	cursor: pointer;
}
.paging{
	text-align: center;	
}
.go{
	font-size : 1.2em;
	cursor: pointer;
}
.btnBox{
	text-align: right;
}
.titleSpan{
	font-size: 1.2em;
	font-weight: bold;	
}
.formTR{
	height: 70px;
}
.titleTD{
	width: 80px;
}
.contentsTD{
	width: 300px;
}
.lastTD{
	width: 150px;
	text-align: center;
}
</style>
</head>
<body>
	<%@ include file="/resources/part/header3.jspf" %>
	<section>
		<div class="container">
			<h2 style="text-align: center;">MovieUpload LIST</h2>

			<div class="search_left">
				<table>
					<tr>
						<!-- Trigger the modal with a button -->
						<td><button type="button" class="btn btn-default" data-toggle="modal" data-target="#myModal">ADD</button></td>
					</tr>
				</table>
				<!-- Modal -->
				<div class="modal fade" id="myModal" role="dialog">
					<div class="modal-dialog">
						<!-- Modal content-->
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal">&times;</button>
								<h4 class="modal-title">영화 upload</h4>
							</div>
							<form action="./movieUpload" id="insertForm" method="post" enctype="multipart/form-data">
								<div class="modal-body">
									<table>
										<tr class="formTR">
											<td class="titleTD"><span class="titleSpan">NUM</span></td>
											<td class="contentsTD"><input type="number" value="${movieNum}" name="movieNum" class="form-control"></td>
											<td class="lastTD">
												<c:if test="${movieNum==0}">
													<select name="movieKind" class="form-control">
														<option value="basicMovie">일반 영화</option>
														<option value="lowPriceMovie">저예산 영화</option>
													</select>
												</c:if>
												<c:if test="${movieNum>0}">
													<input type="hidden" name="movieKind" value="${movieKind}">
												</c:if>
											</td>
										</tr>
										<tr class="formTR">
											<td class="titleTD"><span class="titleSpan">PRICE</span></td>
											<td class="contentsTD"><input type="number" name="price" class="form-control"></td>
											<td class="lastTD"></td>
										</tr>
										<tr class="formTR">
											<td class="titleTD"><span class="titleSpan">MOVIE</span></td>
											<td class="contentsTD"><input type="file" name="movie" id="file" class="form-control"></td>
											<td class="lastTD"><span id="x" class="titleSpan">X</span></td>
										</tr>
									</table>
								</div>
								<div class="modal-footer">
									<input type="button" id="upload" class="btn btn-primary" value="upload">
								</div>
							</form>
						</div>
			      
					</div>
				</div>
			</div>
				
			<div class="search_right">
				<form action="./movieUpload" method="get">
					<table>
						<tr>
							<td><input type="text" class="form-control" placeholder="제목으로 검색..." name="search" style="width: 200px;"></td>
							<td><button class="btn btn-default">SEARCH</button></td>
						</tr>
					</table>
					<input type="hidden" name="curPage" value="1">
				</form>
			</div>

			<table class="table table-hover">
				<thead><tr class="head">
					<td>NUM</td>
					<td>MOVIE</td>
					<td>PRICE</td>
					<td>FUNCTION</td>
				</tr></thead>

				<tbody>
				<c:forEach items="${fileList}" var="movie" varStatus="i">
					<tr>
						<td>${movie.num}</td>
						<td ><span class="videoView" id="${i.current.num}">${movie.oname}</span></td>
						<td>${movie.price} 원</td>
						<td>
							<button id="${movie.fname}" class="movieDelete btn btn-danger">Delete</button>
						</td>
					</tr>
					<tr id="${i.current.num}TR" class="videoTR">
						<td colspan="4">
							<video width="500" controls="controls" id="video">
								<source src="../resources/upload/adminMovieUpload/${movie.fname}" type="video/mp4">
							</video>
							<%-- <br>
							<input type="button" value="닫기" id="${i.current.num}" class="btn videoCancel"> --%>
						</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
				
			<!-- 페이징 처리 -->
			<div class="paging">
				<div class="btn-group">
					<c:if test="${pageResult.curBlock>1}">
						<input type="button" class="go btn btn-default" id="${pageResult.startNum-1}" value="[이전]">
					</c:if>
					<c:forEach begin="${pageResult.startNum}" end="${pageResult.lastNum}" var="i">
						<input type="button" class="go btn btn-default" id="${i}" value="${i}">
					</c:forEach>
					<c:if test="${pageResult.curBlock<pageResult.totalBlock}">
						<input type="button" class="go btn btn-default" id="${pageResult.lastNum+1}" value="[다음]">
					</c:if>
				</div>
			</div>

		</div>
	</section>
</body>
</html>
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
		$("#insertForm_div").hide();
		$(".videoTR").hide();
		
		// videoView
		$(".videoView").click(function() {
			var id = $(this).attr("id");
			var iid = id+"TR";
			$("#"+iid+"").show();
		});
		
		// videoCancel
		$(".videoCancel").click(function() {
			var id = $(this).attr("id");
			var iid = id+"TR";
			$("#"+iid+"").hide();
		});
		
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
<div class="container">
	<h2>movieUpload LIST</h2>
	<br><br>
	<div class="searchForm">
		<form action="./movieUpload" method="get">
			<p><input type="text" placeholder="제목으로 검색..." name="search" style="width: 200px;">&nbsp;<button class="btn">SEARCH</button></p>
			<input type="hidden" name="curPage" value="1">
		</form>
	</div>
	<br>
	<table class="table">
		<tr>
			<td>NUM</td>
			<td>MOVIE</td>
			<td>PRICE</td>
			<td>FUNCTION</td>
		</tr>
		<c:forEach items="${fileList}" var="movie" varStatus="i">
			<tr>
				<td>${movie.num}</td>
				<td ><span class="videoView" id="${i.current.num}">${movie.oname}</span></td>
				<td>${movie.price} 원</td>
				<td>
					<button id="${movie.fname}" class="movieDelete btn">Delete</button>
				</td>
			</tr>
			<tr id="${i.current.num}TR" class="videoTR">
				<td colspan="4">
					<video width="500" controls="controls" id="video">
						<source src="../resources/upload/adminMovieUpload/${movie.fname}" type="video/mp4">
					</video>
					<br>
					<input type="button" value="닫기" id="${i.current.num}" class="btn videoCancel">
				</td>
			</tr>
		</c:forEach>
	</table>
	<br>

<div class="container">
  <!-- Trigger the modal with a button -->
  <button type="button" class="btn btn-default btn-lg" data-toggle="modal" data-target="#myModal">ADD</button>
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
	
	<!-- 페이징 처리 -->
	<div class="paging">
		<c:if test="${pageResult.curBlock>1}">
			<button class="btn"><span class="go" id="${pageResult.startNum-1}">[이전]</span></button>
		</c:if>
		<c:forEach begin="${pageResult.startNum}" end="${pageResult.lastNum}" var="i">
			<button class="btn"><span class="go" id="${i}">${i}</span></button>
		</c:forEach>
		<c:if test="${pageResult.curBlock<pageResult.totalBlock}">
			<button class="btn"><span class="go" id="${pageResult.lastNum+1}">[다음]</span></button>
		</c:if>
	</div>
	
	<div class="btnBox">
		<a href="./index"><button class="btn">Admin Index</button></a>&nbsp;&nbsp;
		<a href="../"><button class="btn">HOME</button></a>
	</div>
</div>
</body>
</html>
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
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script type="text/javascript">
	$(function() {
		var sort = ${sort}; //이름순
		var totalCount=${totalCount};
		var message='${message}';
		//var member="";
		var member=new Array(11);
		var i=0;
		var size=0;
		
		$('input:checkbox[name="vote"]').each(function(){
			if($(this).prop("checked")==true){
				member[i]=$(this).val();
				i++;
				alert(member);
			}
				
			
		});
		
		$("#vote").click(function() {

			var chx = $("input:checkbox[name=vote]:checked").length;

			if (chx > 11) {
				alert("11명에게만 투표 가능합니다.");
			} else if (chx < 11) {
				alert("11명에게 투표해주세요.");
			} else if (chx=11 && message==''){
				$("#frm").submit();
				alert("투표가 완료되었습니다.");
			} else if (message!==''){
				alert("투표는 하루에 한 번만 가능합니다. 내일 다시 시도해주세요.");
				$("input:checkbox[name=vote]").prop("checked",false);
			}
		});
		
		$("#sort").change(function() {
			var sort2 = $(this).val();

			if (sort2 == "인기순") {
				sort = 2;
				location.href = "./actorPRList?sort=" + sort;
			} else {
				sort = 1;
				location.href = "./actorPRList?sort=" + sort;
			}
		});	
			
		/* $("#season").change(function() {
			var season = $("#season").val();
			alert(season);
			$("#seasonForm").submit();
		}); */

		$("#search").click(function() {
			$("#searchForm").submit();
		}); 		
 
	});
</script>
<style type="text/css">

#sort{
	float:right;
	border:1px solid gary;
}

.profile {
	border-bottom: 1px solid RGB(157, 157, 157);
	width: 250px;
	height: 250px;
	margin-right: 10px;
	margin-top: 10px;
	display: inline-block;
}

#frm{
	float: left;
	width: 1350px;
	border:1px solid gray;
}

#btn {
	display: block;
}

#buttonList{
	width:1350px;
}
.contents-wrap {
	width: 1700px;
	margin: 0 auto;
	margin-left: 300px;
}

.chk {
	float: right;
}

img {
	margin-top: 15px;
}

#listAjax {
	height: 770px;
	overflow:scroll
}
</style>
</head>
<body>
	<%@ include file="/resources/part/header2.jspf" %>
	<section>
	<div class="contents-wrap">

		<h2>ActorPR LIST</h2>

		<div id="buttonList">
		<c:if
			test="${totalCount <= 101 && memberDTO ne null && memberDTO.kind eq '배우'}">
			<a href="./actorPRWrite"><button class="btn">Actor Apply</button></a>
		</c:if>
		<a href="../../"><button class="btn">HOME</button></a> 

		<div class="search">
			<form action="./actorPRList" id="searchForm">
				<input type="text" name="search" placeholder="이름 검색"> <input
					type="hidden" name="curPage" value="1"> <input
					type="button" class="btn" value="Search" id="search">
			</form>
		</div>
		
		 <select id="sort">
			<c:if test="${sort eq 1 }">
				<option id="nameSort" value="이름순" selected="selected">이름순</option>
				<option id="popularitySort" value="인기순">인기순</option>
			</c:if>
			<c:if test="${sort ne 1 }">
				<option id="nameSort" value="이름순">이름순</option>
				<option id="popularitySort" value="인기순" selected="selected">인기순</option>
			</c:if>
		</select>
		
		</div>

	<form action="voteCountUpdate" method="POST" id="frm">
			<div id="listAjax">
				<c:forEach items="${list}" var="list" varStatus="i">
					<input type="hidden" name="num" value="${list.num }">
					<div class="profile">

						<a href="./actorPRView?num=${list.num}">
							<button type="button" class="btn btn-info">${list.writer }
								<span class="badge">${list.voteCount }</span>
							</button>
						</a> <input type="checkbox" name="vote" class="chk" value="${list.writer }" id="chk${list.num }">
								<a href="./actorPRView?num=${list.num}"> 
									<img src="../../resources/upload/member/${fnames[i.index]}" class="img-responsive" style="width: 100%; height: 70%;"
							alt="Image">
						</a>
					</div>
				</c:forEach>
			</div>
			<c:if test="${memberDTO ne null }">
			<input class="btn btn-info" type="button" id="vote" value="vote">
			</c:if>
		</form>
		<!-- <div id="voteList">
			<p id="voteList2" name="member"></p>
		</div> -->

	</div>
	
	</section>
</body>
</html>
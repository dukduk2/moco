<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/resources/part/bootStrap.jspf" %>
<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.js"></script>
<link rel="styleSheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/header.css">
<link rel="styleSheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/section.css">
<title>MOVIE COMMUNICATION</title>
<script type="text/javascript">
	$(function() {
		$(".memberIMG").each(function(index, item){
			if(index ==0){
				$(this).attr("id", "gold");
			}else if(index == 1){
				$(this).attr("id", "silver");
			}else{
				$(this).attr("id", "bronze");
			}
		});
	});
</script>
<style type="text/css">
h3{
	margin-left: 10px;
}
.rank {
	width: 70%;
	height: 700px;
	border: solid #ccc 1px;
	margin: 0 auto;
	margin-top: 10px;
	font-size: 30px;
	font-weight: bold;
}

.sub {
	width: 45%;
	height: 400px;
	margin: 20px 0;
	font-size: 30px;
	font-weight: bold;
}

.left{
	margin-left: 4%;
	border: solid #ccc 1px;
	float: left;
}

.right {
	margin-right: 4%;
	border: solid #ccc 1px;
	float: right;
}
#funding-top{
	width: 100%;
	height: 50%;
}
#funding-bot{
	width: 100%;
	height: 50%;
}
.funding-info{
	width: 25%;
	height: 100%;
	float: left;
}
.funding-info img{
	width: 80%;
	height: 60%;
	background-color: #d9d9d9;
	border-radius: 50%;
}
.funding-info p{
	font-size: 13px;
	color: #999999;
}
.funding-info .chart{
	font-size: 20px;
	color: #737373;
}
#funding-intro{
	font-size: 20px;
	color: #737373;
}
.memberIMG{
	width: 100px;
	height: 100px;
	border-radius: 100%;
}
.rank3{
	padding-left: 150px;
}
.rank3Info{
	float: left;
	font-size: 0.5em;
	text-align: center;
	margin-right: 25px;
	margin-top: 10px;
}
#gold{
	border: 4px solid rgb(255,215,0);
}
#silver{
	border : 4px solid silver;
}
#bronze{
	border: 4px solid rgb(205, 127, 50); 
}
.profile {
	border-bottom: 1px solid RGB(157, 157, 157);
	width: 200px;
	height: 200px;
	margin-right: 10px;
	margin-top: 5px;
	margin-left: 10px;
	display: inline-block;
}
#userboard-intro{
	font-size: 0.6em;
	color: #737373;
}
.userboardTitle{
	text-align: center;
	width: 675px;
	font-size: 0.6em;
}
</style>
</head>
<body>
	<%@ include file="/resources/part/header2.jspf" %>
	<section>
		<div class="rank">
			<p style="font-size:30px; font-weight:bold;">ActorPR TOP 11</p>
			<c:forEach items="${list }" var="list" varStatus="i">
				<div class="profile">

						<a href="./actorPR/actorPRView?num=${list.num}">
							<button type="button" class="btn btn-default">${list.writer }
								<span class="badge">${list.voteCount }</span>
							</button>
							<img src="${pageContext.request.contextPath}/resources/upload/member/${fnames[i.index]}" class="img-responsive" style="width: 100%; height: 70%;"
							alt="Image">
						</a>
					</div>
			</c:forEach>
		</div>
		
		<div class="sub left">
			<div id="funding-top">
				<p>시나리오 펀딩이란?</p>
				<p id="funding-intro">시나리오 펀딩은 영화 제작 크라우드 펀딩입니다. 최소투자금액 1만원으로 간접적
				 영화 제작 투자를 가능하게 하고 있으며 영화 상영으로 발생하는 수입의 일정 부분을 다시 투자자들에게 배분합니다.
				 펀딩 목표금액 미달성시 투자 금액의 100%를 다시 돌려드립니다.
				</p>
			</div>
			<div id="funding-bot">
				<div class="funding-info">
					<img src="../resources/upload/directorBoardUpload/community1.png">
					<p>누적 투자자 수</p>
					<fmt:formatNumber var="totalInvestor" pattern="#,###">${totalInvestor }</fmt:formatNumber>
					<p class="chart">${totalInvestor }명</p>
				</div>
				<div class="funding-info">
					<img src="../resources/upload/directorBoardUpload/financial1.png">
					<p>인당 평균 누적 투자액</p>
					<fmt:formatNumber var="avgInvestMoney" pattern="#,###">${avgInvestMoney }</fmt:formatNumber>
					<p class="chart">${avgInvestMoney }원</p>
				</div>
				<div class="funding-info">
					<img src="../resources/upload/directorBoardUpload/success2.png">
					<p>펀딩 달성률</p>
					<fmt:formatNumber var="chart" pattern="#.#">${chart }</fmt:formatNumber>
					<p class="chart">${chart }%</p>
				</div>
				<div class="funding-info">
					<img src="../resources/upload/directorBoardUpload/totalMoney.png">
					<p>누적 투자액</p>
					<fmt:formatNumber var="totalInvestMoney" pattern="#,###">${totalInvestMoney }</fmt:formatNumber>
					<p class="chart">${totalInvestMoney }만원</p>
				</div>
			</div>
		</div>
		<div class="sub right">
			<p>유저 프로젝트란?</p>
			<p id="userboard-intro">
				저희 사이트에서는 1년에 2회 '유저 프로젝트'를 실행합니다. 시즌기간 동안 
				유저들이 직접 팀을 꾸려 저예산 영화를 만들고, 그 만든 것을 공유하는 것이 '유저 프로젝트' 인대요.
				글쓴이가 먼저 글을 등록하고 관리자 승인을 거치게 됩니다. 그 후 허가가 되면 다른 유저들도 볼 수 있게 됩니다.
				시즌동안 등록된 글에 달린 '좋아요' 수 만큼 글쓴이에게 적립이 되고, 적립된 만큼 포인트로 환산 할 수 있습니다.
				많은 참여 부탁드립니다.
			</p>
			<div class="userboardTitle">실시간 RANK</div>
			<div class="rank3">
				<c:forEach items="${rank3Member}" var="memberDTO" varStatus="i">
					<div class="rank3Info">
						<a href="./userBoard/userBoardView?num=${rank3Likes[i.index].num}">
							<img id="${rank3Likes[i.index].likes}" class="memberIMG" alt="" src="${pageContext.request.contextPath}/resources/upload/member/${memberDTO.fname}">
						</a>
						<br>
						좋아요 ${rank3Likes[i.index].likes}
					</div>
				</c:forEach>
			</div>
		</div>
	</section>
</body>
</html>
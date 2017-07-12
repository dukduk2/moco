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
<style type="text/css">
.rank {
	width: 70%;
	height: 600px;
	border: solid blue 2px;
	margin: 0 auto;
	margin-top: -50px;
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
	border: solid red 2px;
	float: left;
}

.right {
	margin-right: 4%;
	border: solid green 2px;
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
.profile {
	border-bottom: 1px solid RGB(157, 157, 157);
	width: 200px;
	height: 200px;
	margin-right: 10px;
	margin-top: 5px;
	margin-left: 10px;
	display: inline-block;
}
</style>
</head>
<body>
	<%@ include file="/resources/part/header2.jspf" %>
	<section>
		<div class="rank">
			<c:forEach items="${list }" var="list">
				<div class="profile">

						<a href="./actorPR/actorPRView?num=${list.num}">
							<button type="button" class="btn btn-info">${list.writer }
								<span class="badge">${list.voteCount }</span>
							</button>
							<img src="../resources/upload/member/${fnames[i.index]}" class="img-responsive" style="width: 100%; height: 70%;"
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
		<div class="sub right">sub2</div>
	</section>
</body>
</html>
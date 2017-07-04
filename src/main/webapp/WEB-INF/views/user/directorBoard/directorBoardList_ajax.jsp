<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- 펀딩 컨텐츠 -->
<div id="search-result">
	<c:forEach var="list" items="${list }">
		<div class="contents" id="${list.num}">
		<div class="contents-top">
			<div class="contents-top-left">
				<img src="../../resources/images/directorBoard/sample_img.jpg">
			</div>
			<div class="contents-top-rigth">
				<p>제목 - ${list.title }</p>
				<p>감독 - ${list.writer}</p>
				<p>장르 - ${list.genre }</p>
				<fmt:formatNumber var="cPrice" pattern="#,###">${list.curPrice }</fmt:formatNumber>
				<fmt:formatNumber var="tPrice" pattern="#,###">${list.targetPrice }</fmt:formatNumber>
				<p>투자 금액 - ${cPrice } / ${tPrice }원</p>
				<div class="progress">
				<c:set var="result">${list.curPrice/list.targetPrice*100}</c:set>
				<fmt:formatNumber var="result" value="${result }" pattern="##"></fmt:formatNumber>
					<div class="progress-bar progress-bar-success progress-bar-striped"
						role="progressbar" aria-valuenow="${result}"
						aria-valuemin="0" aria-valuemax="100"
						style="width: ${result}%">
						<div class="txt">${result }%COMPLETE</div>
					</div>
				</div>
			</div>
		</div>
		<div class="contents-middle">
			<p>펀딩 오픈일 ${list.openDate}</p>
		</div>
		<div class="contents-bottom">
			<div style="float: left;"><p>펀딩 마감일 ${list.targetDate }</p></div>
			<c:if test="${list.state eq 1 }">
				<div class="state" id="state1">진행중</div>
			</c:if>
			<c:if test="${list.state eq 0 }">
				<div class="state" id="state0">마감완료</div>
			</c:if>
		</div>
	</div>
	</c:forEach>
	<c:if test="${searchMessage == null }">
		<c:if test="${totalCount > lastRow}">
			<button class="btn load-more" id="${lastRow }">MORE</button>
		</c:if>
	</c:if>
	<c:if test="${searchMessage != null }">
		<p>${searchMessage }</p>
	</c:if>
</div>




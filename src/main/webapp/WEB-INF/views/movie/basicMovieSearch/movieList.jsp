<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div id="searchResult">
<c:forEach var="list" items="${movieList }">
	<div class="searchResultWrap" id="${list.num }">
		<div class="searchResultWrap-left">
			<c:if test="${list.thumnail == null }">
				<img src="../../resources/images/directorBoard/sample_img.jpg">
			</c:if>
			<c:if test="${list.thumnail != null }">
				<img src="${list.thumnail }">
			</c:if>
		</div>
		<div class="searchResultWrap-right">
			<p style="font-size: 25px;">${list.title }(${list.eng_title })</p>
			<span class="star-rating">
				<span style="width: ${list.user_rating*10}%"></span>
			</span>
			<span style="font-size: 17px; margin-bottom: 2px;">${list.user_rating }/10</span>
			<p>${list.genre }| ${list.pub_date } | ${list.play_time } |	${list.nation } | ${list.watching_rate}</p>
			<p>감독 ${list.director }</p>
			<p>주연 ${list.actor }</p>
		</div>
	</div>
</c:forEach>
<!-- PAGING -->
<ul class="paging pagination">
	<c:if test="${pageResult.curBlock>1}">
		<li class="go" id="${pageResult.startNum-1}"><a>이전</a></li>
	</c:if>
	<c:forEach begin="${pageResult.startNum}" end="${pageResult.lastNum}" var="i">
		<li class="go" id="${i}"><a>${i}</a></li>
	</c:forEach>
	<c:if test="${pageResult.curBlock<pageResult.totalBlock}">
		<li class="go" id="${pageResult.lastNum+1}"><a>다음</a></li>
	</c:if>
</ul>
</div>

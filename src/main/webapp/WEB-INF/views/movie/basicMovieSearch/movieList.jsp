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
				<span class="point" style="font-size: 17px; margin-bottom: 2px;">${list.user_rating }/10</span>
				<p><span class="point">${list.genre}</span>| <span class="point">${list.pub_date}</span> | <span class="point">${list.play_time}</span> |	<span class="point">${list.nation}</span> | <span class="point">${list.watching_rate}</span></p>
				<p><span class="point">감독</span> ${list.director}</p>
				<p><span class="point">주연</span> ${list.actor}</p>
			</div>
		</div>
	</c:forEach>
	<!-- PAGING -->
	<div class="paging">
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
</div>

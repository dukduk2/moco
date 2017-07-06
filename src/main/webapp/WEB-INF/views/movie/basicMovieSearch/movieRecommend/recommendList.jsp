<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div id="recommendResult">
	<c:choose>
		<c:when test="${criteria eq 'director'}">
			<c:forEach begin="1" end="20" var="director" items="${movie_map.directorList}" varStatus="status">
				<p>${director.directorS}(${director.avr} / 10)</p>
			</c:forEach>
		</c:when>

		<c:when test="${criteria eq 'review'}">
			<c:forEach var="movie" items="${movie_map.reviewList}" varStatus="status">
				<div class="recommendContents" id="${movie.num}">
					<div class="contents-top">
						<div class="rank">${status.count}</div>
						<img src="${movie.thumnail}" width="100%" height="100%">
					</div>
					<div class="contents-middle">
						<p class="title">${movie.title}</p>
						<p><span class="point">감독</span> ${movie.director}</p>
						<p><span class="point">장르</span> ${movie.genre}</p>
						<p><span class="point">평점</span> ${movie.user_rating} / 10</p>
						<p>${movie.count}리뷰</p>
					</div>
				</div>
			</c:forEach>
		</c:when>

		<c:when test="${criteria eq 'jjim'}">
			<c:forEach var="movie" items="${movie_map.jjimList}" varStatus="status">
				<div class="recommendContents" id="${movie.num}">
					<div class="contents-top">
						<div class="rank">${status.count}</div>
						<img src="${movie.thumnail}" width="100%" height="100%">
					</div>
					<div class="contents-middle">
						<p class="title">${movie.title}</p>
						<p>${movie.director}</p>
						<p><span class="point">장르</span> ${movie.genre}</p>
						<p><span class="point">평점</span> ${movie.user_rating} / 10</p>
						<p>${movie.count}찜</p>
					</div>
				</div>
			</c:forEach>
		</c:when>

		<c:when test="${criteria eq 'recent'}">
			<c:forEach var="movie" items="${movie_map.recentList}" varStatus="status">
				<div class="recommendContents" id="${movie.num}">
					<div class="contents-top">
						<div class="rank">${status.count}</div>
						<img src="${movie.thumnail}" width="100%" height="100%">
					</div>
					<div class="contents-middle">
						<p class="title">${movie.title}</p>
						<p>${movie.pub_date}개봉</p>
						<p>장르 ${movie.genre}</p>
						<p>평점 ${movie.user_rating} / 10</p>
					</div>
				</div>
			</c:forEach>
		</c:when>

		<c:when test="${criteria eq 'age'}">
			<p>${movie_map.noListMessage}</p>
			<c:forEach var="movie" items="${movie_map.ageViewList}" varStatus="status">
				<div class="recommendContents" id="${movie.num}">
					<div class="contents-top">
						<div class="rank">${status.count}</div>
						<img src="${movie.thumnail}" width="100%" height="100%">
					</div>
					<div class="contents-middle">
						<p class="title">${movie.title}</p>
						<p>${movie.pub_date}개봉</p>
						<p>장르 ${movie.genre}</p>
						<p>평점 ${movie.user_rating} / 10</p>
						<p>${movie.count}명 관람</p>
					</div>
				</div>
			</c:forEach>
		</c:when>

		<c:otherwise>
			<c:forEach begin="1" end="20" var="movie" items="${movie_map.movieList}" varStatus="status">
				<div class="recommendContents" id="${movie.num}">
					<div class="contents-top">
						<div class="rank">${status.count}</div>
						<img src="${movie.thumnail}" width="100%" height="100%">
					</div>
					<div class="contents-middle">
						<p class="title">${movie.title}</p>
						<p><span class="point">감독</span> ${movie.director}</p>
						<p><span class="point">장르</span> ${movie.genre}</p>
						<p><span class="point">평점</span> ${movie.user_rating} / 10</p>
					</div>
				</div>
			</c:forEach>
		</c:otherwise>
	</c:choose>
</div>
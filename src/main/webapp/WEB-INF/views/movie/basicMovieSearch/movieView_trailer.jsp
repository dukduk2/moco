<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div id="middleWrap">
	<ul class="nav nav-tabs nav-justified">
		<li><a href="./movieView?num=${movieDTO.num }&kind=story">줄거리</a></li>
		<li class="active"><a href="">예고편</a></li>
	</ul>
	<div class="middle">
		<video controls autoplay>
			<source src="../../resources/upload/movieTrailer/sample_video.mp4" type="video/mp4">
		</video>
	</div>
</div>
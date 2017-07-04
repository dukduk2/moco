<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<table class="table">
	<!-- viewCheck를 아직 안하였고 로그인 되어있을 때 -->
	<c:if test="${!viewCheck && memberDTO != null}">
		<tr>
			<td colspan="7"><span>${memberDTO.id} 님! 영화를 보셨다면 우측 버튼을 클릭해 주세요! &nbsp;&nbsp;</span><button class="btn" id="viewCheckButton">봤어요!</button></td>
		</tr>
	</c:if>
	<!-- viewCheck, 현재 로그인 되어있고, 후기를 안남겼다면 쓰기 가능 -->
	<c:if test="${viewCheck && memberDTO != null && !reviewCheck}">
		<tr>
			<td>
				<div class="dropdown">
					<button class="btn btn-primary dropdown-toggle" type="button" data-toggle="dropdown">
						Star Rating<span class="caret"></span>
					</button>
					<ul class="dropdown-menu">
						<li class="reviewStar" id="one">
						    <i class="fa fa-star-half-full" style="font-size:20px"></i>
						    <i class="fa fa-star-o" style="font-size:20px"></i>
						    <i class="fa fa-star-o" style="font-size:20px"></i>
						    <i class="fa fa-star-o" style="font-size:20px"></i>
						    <i class="fa fa-star-o" style="font-size:20px"></i>
					     1점</li>
					    <li class="reviewStar" id="two">
						    <i class="fa fa-star" style="font-size:20px"></i>
						    <i class="fa fa-star-o" style="font-size:20px"></i>
						    <i class="fa fa-star-o" style="font-size:20px"></i>
						    <i class="fa fa-star-o" style="font-size:20px"></i>
						    <i class="fa fa-star-o" style="font-size:20px"></i>
					     2점</li>
					     <li class="reviewStar" id="three">
					     	<i class="fa fa-star" style="font-size:20px"></i>
						    <i class="fa fa-star-half-full" style="font-size:20px"></i>
						    <i class="fa fa-star-o" style="font-size:20px"></i>
						    <i class="fa fa-star-o" style="font-size:20px"></i>
						    <i class="fa fa-star-o" style="font-size:20px"></i>
					      3점</li>
					      <li class="reviewStar" id="four">
					      	<i class="fa fa-star" style="font-size:20px"></i>
					      	<i class="fa fa-star" style="font-size:20px"></i>
					      	<i class="fa fa-star-o" style="font-size:20px"></i>
						    <i class="fa fa-star-o" style="font-size:20px"></i>
						    <i class="fa fa-star-o" style="font-size:20px"></i>
					       4점</li>
					       <li class="reviewStar" id="five">
					      	<i class="fa fa-star" style="font-size:20px"></i>
					      	<i class="fa fa-star" style="font-size:20px"></i>
					      	<i class="fa fa-star-half-full" style="font-size:20px"></i>
						    <i class="fa fa-star-o" style="font-size:20px"></i>
						    <i class="fa fa-star-o" style="font-size:20px"></i>
					       5점</li>
					       <li class="reviewStar" id="six">
					      	<i class="fa fa-star" style="font-size:20px"></i>
					      	<i class="fa fa-star" style="font-size:20px"></i>
					      	<i class="fa fa-star" style="font-size:20px"></i>
						    <i class="fa fa-star-o" style="font-size:20px"></i>
						    <i class="fa fa-star-o" style="font-size:20px"></i>
					       6점</li>
					       <li class="reviewStar" id="seven">
					      	<i class="fa fa-star" style="font-size:20px"></i>
					      	<i class="fa fa-star" style="font-size:20px"></i>
					      	<i class="fa fa-star" style="font-size:20px"></i>
						    <i class="fa fa-star-half-full" style="font-size:20px"></i>
						    <i class="fa fa-star-o" style="font-size:20px"></i>
					       7점</li>
					       <li class="reviewStar" id="eight">
					      	<i class="fa fa-star" style="font-size:20px"></i>
					      	<i class="fa fa-star" style="font-size:20px"></i>
					      	<i class="fa fa-star" style="font-size:20px"></i>
						    <i class="fa fa-star" style="font-size:20px"></i>
						    <i class="fa fa-star-o" style="font-size:20px"></i>
					       8점</li>
					       <li class="reviewStar" id="nine">
					      	<i class="fa fa-star" style="font-size:20px"></i>
					      	<i class="fa fa-star" style="font-size:20px"></i>
					      	<i class="fa fa-star" style="font-size:20px"></i>
						    <i class="fa fa-star" style="font-size:20px"></i>
						    <i class="fa fa-star-half-full" style="font-size:20px"></i>
					       9점</li>
					       <li class="reviewStar" id="ten">
					      	<i class="fa fa-star" style="font-size:20px"></i>
					      	<i class="fa fa-star" style="font-size:20px"></i>
					      	<i class="fa fa-star" style="font-size:20px"></i>
						    <i class="fa fa-star" style="font-size:20px"></i>
						    <i class="fa fa-star" style="font-size:20px"></i>
					       10점</li>
					</ul>
				</div>
			</td>
			<td>
				<span id="reviewStarResult">
					<i class="fa fa-star" style="font-size:20px"></i>
					<i class="fa fa-star" style="font-size:20px"></i>
					<i class="fa fa-star-half-full" style="font-size:20px"></i>
					<i class="fa fa-star-o" style="font-size:20px"></i>
					<i class="fa fa-star-o" style="font-size:20px"></i>
					5점
				</span>
				<input type="hidden" value="5" id="reviewStarHidden">
			</td>
			<td><input type="text" value="${memberDTO.id}" readonly="readonly" id="reviewWriter"></td>
			<td><textarea id="reviewContents" style="width: 400px; height: 50px;" placeholder="별점을 남기지 않으실 경우 5점으로 처리 됩니다."></textarea></td>
			<td><button id="reviewWrite" class="btn">Write</button></td>
			<td></td>
			<td></td>
		</tr>
	</c:if>
	<c:if test="${reviewCheck}">
		<tr>
			<td colspan="7" style="text-align: center;"><span style="font-size: 1.5em; font-weight: bold;">이미 후기를 작성하셨습니다.</span></td>
		</tr>
	</c:if>
	<!-- 리뷰가 1개라도 있다면 -->
	<c:if test="${totalCount > 0}">			
	<!-- 다른 사람 리뷰 -->
		<c:forEach items="${reviewList}" var="review">
			<tr>
				<c:if test="${review.num != reviewDTO.num}">
					<td colspan="2">
						<c:choose>
							<c:when test="${review.myRating == 1}">
								<span class="star">
									<i class="fa fa-star-half-full" style="font-size:20px"></i>
								    <i class="fa fa-star-o" style="font-size:20px"></i>
								    <i class="fa fa-star-o" style="font-size:20px"></i>
								    <i class="fa fa-star-o" style="font-size:20px"></i>
								    <i class="fa fa-star-o" style="font-size:20px"></i>
								1점</span>
							</c:when>
							<c:when test="${review.myRating == 2}">
								<span class="star">
									<i class="fa fa-star" style="font-size:20px"></i>
								    <i class="fa fa-star-o" style="font-size:20px"></i>
								    <i class="fa fa-star-o" style="font-size:20px"></i>
								    <i class="fa fa-star-o" style="font-size:20px"></i>
								    <i class="fa fa-star-o" style="font-size:20px"></i>
								2점</span>
							</c:when>
							<c:when test="${review.myRating == 3}">
								<span class="star">
									<i class="fa fa-star" style="font-size:20px"></i>
								    <i class="fa fa-star-half-full" style="font-size:20px"></i>
								    <i class="fa fa-star-o" style="font-size:20px"></i>
								    <i class="fa fa-star-o" style="font-size:20px"></i>
								    <i class="fa fa-star-o" style="font-size:20px"></i>
								3점</span>
							</c:when>
							<c:when test="${review.myRating == 4}">
								<span class="star">
									<i class="fa fa-star" style="font-size:20px"></i>
							      	<i class="fa fa-star" style="font-size:20px"></i>
							      	<i class="fa fa-star-o" style="font-size:20px"></i>
								    <i class="fa fa-star-o" style="font-size:20px"></i>
								    <i class="fa fa-star-o" style="font-size:20px"></i>
								4점</span>
							</c:when>
							<c:when test="${review.myRating == 5}">
								<span class="star">
									<i class="fa fa-star" style="font-size:20px"></i>
							      	<i class="fa fa-star" style="font-size:20px"></i>
							      	<i class="fa fa-star-half-full" style="font-size:20px"></i>
								    <i class="fa fa-star-o" style="font-size:20px"></i>
								    <i class="fa fa-star-o" style="font-size:20px"></i>
								5점</span>
							</c:when>
							<c:when test="${review.myRating == 6 }">
								<span class="star">
									<i class="fa fa-star" style="font-size:20px"></i>
							      	<i class="fa fa-star" style="font-size:20px"></i>
							      	<i class="fa fa-star" style="font-size:20px"></i>
								    <i class="fa fa-star-o" style="font-size:20px"></i>
								    <i class="fa fa-star-o" style="font-size:20px"></i>
								6점</span>
							</c:when>
							<c:when test="${review.myRating == 7 }">
								<span class="star">
									<i class="fa fa-star" style="font-size:20px"></i>
							      	<i class="fa fa-star" style="font-size:20px"></i>
							      	<i class="fa fa-star" style="font-size:20px"></i>
								    <i class="fa fa-star-half-full" style="font-size:20px"></i>
								    <i class="fa fa-star-o" style="font-size:20px"></i>
								7점</span>
							</c:when>
							<c:when test="${review.myRating == 8 }">
								<span class="star">
									<i class="fa fa-star" style="font-size:20px"></i>
							      	<i class="fa fa-star" style="font-size:20px"></i>
							      	<i class="fa fa-star" style="font-size:20px"></i>
								    <i class="fa fa-star" style="font-size:20px"></i>
								    <i class="fa fa-star-o" style="font-size:20px"></i>
								8점</span>
							</c:when>
							<c:when test="${review.myRating == 9 }">
								<span class="star">
									<i class="fa fa-star" style="font-size:20px"></i>
							      	<i class="fa fa-star" style="font-size:20px"></i>
							      	<i class="fa fa-star" style="font-size:20px"></i>
								    <i class="fa fa-star" style="font-size:20px"></i>
								    <i class="fa fa-star-half-full" style="font-size:20px"></i>
								9점</span>
							</c:when>
							<c:when test="${review.myRating == 10 }">
								<span class="star">
									<i class="fa fa-star" style="font-size:20px"></i>
							      	<i class="fa fa-star" style="font-size:20px"></i>
							      	<i class="fa fa-star" style="font-size:20px"></i>
								    <i class="fa fa-star" style="font-size:20px"></i>
								    <i class="fa fa-star" style="font-size:20px"></i>
								10점</span>
							</c:when>
						</c:choose>
					</td>
					<td>
						<input type="text" readonly="readonly" value="${review.writer}" style="border:none;">
					</td>
					<td>
						<textarea rows="" cols="" readonly="readonly" style="width: 400px; height: 50px; border:none;">${review.contents}</textarea>
					</td>
					<td>
						<button class="reviewLikes btn btn-default" id="${review.num}">좋아요 ${review.likes}</button>
					</td>									
					<input type="hidden" id="reviewLikesMessage" value="${message}">
				</c:if>
				<c:if test="${review.num == reviewDTO.num}">
					<td>
						<div class="dropdown">
					<button class="btn btn-primary dropdown-toggle" type="button" data-toggle="dropdown">
						Star Rating<span class="caret"></span>
					</button>
					<ul class="dropdown-menu">
						<li class="reviewUpdateStar" id="one_">
						    <i class="fa fa-star-half-full" style="font-size:20px"></i>
						    <i class="fa fa-star-o" style="font-size:20px"></i>
						    <i class="fa fa-star-o" style="font-size:20px"></i>
						    <i class="fa fa-star-o" style="font-size:20px"></i>
						    <i class="fa fa-star-o" style="font-size:20px"></i>
					     1점</li>
					    <li class="reviewUpdateStar" id="two_">
						    <i class="fa fa-star" style="font-size:20px"></i>
						    <i class="fa fa-star-o" style="font-size:20px"></i>
						    <i class="fa fa-star-o" style="font-size:20px"></i>
						    <i class="fa fa-star-o" style="font-size:20px"></i>
						    <i class="fa fa-star-o" style="font-size:20px"></i>
					     2점</li>
					     <li class="reviewUpdateStar" id="three_">
					     	<i class="fa fa-star" style="font-size:20px"></i>
						    <i class="fa fa-star-half-full" style="font-size:20px"></i>
						    <i class="fa fa-star-o" style="font-size:20px"></i>
						    <i class="fa fa-star-o" style="font-size:20px"></i>
						    <i class="fa fa-star-o" style="font-size:20px"></i>
					      3점</li>
					      <li class="reviewUpdateStar" id="four_">
					      	<i class="fa fa-star" style="font-size:20px"></i>
					      	<i class="fa fa-star" style="font-size:20px"></i>
					      	<i class="fa fa-star-o" style="font-size:20px"></i>
						    <i class="fa fa-star-o" style="font-size:20px"></i>
						    <i class="fa fa-star-o" style="font-size:20px"></i>
					       4점</li>
					       <li class="reviewUpdateStar" id="five_">
					      	<i class="fa fa-star" style="font-size:20px"></i>
					      	<i class="fa fa-star" style="font-size:20px"></i>
					      	<i class="fa fa-star-half-full" style="font-size:20px"></i>
						    <i class="fa fa-star-o" style="font-size:20px"></i>
						    <i class="fa fa-star-o" style="font-size:20px"></i>
					       5점</li>
					       <li class="reviewUpdateStar" id="six_">
					      	<i class="fa fa-star" style="font-size:20px"></i>
					      	<i class="fa fa-star" style="font-size:20px"></i>
					      	<i class="fa fa-star" style="font-size:20px"></i>
						    <i class="fa fa-star-o" style="font-size:20px"></i>
						    <i class="fa fa-star-o" style="font-size:20px"></i>
					       6점</li>
					       <li class="reviewUpdateStar" id="seven_">
					      	<i class="fa fa-star" style="font-size:20px"></i>
					      	<i class="fa fa-star" style="font-size:20px"></i>
					      	<i class="fa fa-star" style="font-size:20px"></i>
						    <i class="fa fa-star-half-full" style="font-size:20px"></i>
						    <i class="fa fa-star-o" style="font-size:20px"></i>
					       7점</li>
					       <li class="reviewUpdateStar" id="eight_">
					      	<i class="fa fa-star" style="font-size:20px"></i>
					      	<i class="fa fa-star" style="font-size:20px"></i>
					      	<i class="fa fa-star" style="font-size:20px"></i>
						    <i class="fa fa-star" style="font-size:20px"></i>
						    <i class="fa fa-star-o" style="font-size:20px"></i>
					       8점</li>
					       <li class="reviewUpdateStar" id="nine_">
					      	<i class="fa fa-star" style="font-size:20px"></i>
					      	<i class="fa fa-star" style="font-size:20px"></i>
					      	<i class="fa fa-star" style="font-size:20px"></i>
						    <i class="fa fa-star" style="font-size:20px"></i>
						    <i class="fa fa-star-half-full" style="font-size:20px"></i>
					       9점</li>
					       <li class="reviewUpdateStar" id="ten_">
					      	<i class="fa fa-star" style="font-size:20px"></i>
					      	<i class="fa fa-star" style="font-size:20px"></i>
					      	<i class="fa fa-star" style="font-size:20px"></i>
						    <i class="fa fa-star" style="font-size:20px"></i>
						    <i class="fa fa-star" style="font-size:20px"></i>
					       10점</li>
					</ul>
				</div>
					</td>
					<td>
						<c:choose>
							<c:when test="${reviewDTO.myRating == 1}">
								<span class="star" id="reviewUpdateStarResult">
									<i class="fa fa-star-half-full" style="font-size:20px"></i>
								    <i class="fa fa-star-o" style="font-size:20px"></i>
								    <i class="fa fa-star-o" style="font-size:20px"></i>
								    <i class="fa fa-star-o" style="font-size:20px"></i>
								    <i class="fa fa-star-o" style="font-size:20px"></i>
								1점</span>
							</c:when>
							<c:when test="${reviewDTO.myRating == 2}">
								<span class="star" id="reviewUpdateStarResult">
									<i class="fa fa-star" style="font-size:20px"></i>
								    <i class="fa fa-star-o" style="font-size:20px"></i>
								    <i class="fa fa-star-o" style="font-size:20px"></i>
								    <i class="fa fa-star-o" style="font-size:20px"></i>
								    <i class="fa fa-star-o" style="font-size:20px"></i>
								2점</span>
							</c:when>
							<c:when test="${reviewDTO.myRating == 3}">
								<span class="star" id="reviewUpdateStarResult">
									<i class="fa fa-star" style="font-size:20px"></i>
								    <i class="fa fa-star-half-full" style="font-size:20px"></i>
								    <i class="fa fa-star-o" style="font-size:20px"></i>
								    <i class="fa fa-star-o" style="font-size:20px"></i>
								    <i class="fa fa-star-o" style="font-size:20px"></i>
								3점</span>
							</c:when>
							<c:when test="${reviewDTO.myRating == 4}">
								<span class="star" id="reviewUpdateStarResult">
									<i class="fa fa-star" style="font-size:20px"></i>
							      	<i class="fa fa-star" style="font-size:20px"></i>
							      	<i class="fa fa-star-o" style="font-size:20px"></i>
								    <i class="fa fa-star-o" style="font-size:20px"></i>
								    <i class="fa fa-star-o" style="font-size:20px"></i>
								4점</span>
							</c:when>
							<c:when test="${reviewDTO.myRating == 5}">
								<span class="star" id="reviewUpdateStarResult">
									<i class="fa fa-star" style="font-size:20px"></i>
							      	<i class="fa fa-star" style="font-size:20px"></i>
							      	<i class="fa fa-star-half-full" style="font-size:20px"></i>
								    <i class="fa fa-star-o" style="font-size:20px"></i>
								    <i class="fa fa-star-o" style="font-size:20px"></i>
								5점</span>
							</c:when>
							<c:when test="${reviewDTO.myRating == 6 }">
								<span class="star" id="reviewUpdateStarResult">
									<i class="fa fa-star" style="font-size:20px"></i>
							      	<i class="fa fa-star" style="font-size:20px"></i>
							      	<i class="fa fa-star" style="font-size:20px"></i>
								    <i class="fa fa-star-o" style="font-size:20px"></i>
								    <i class="fa fa-star-o" style="font-size:20px"></i>
								6점</span>
							</c:when>
							<c:when test="${reviewDTO.myRating == 7 }">
								<span class="star" id="reviewUpdateStarResult">
									<i class="fa fa-star" style="font-size:20px"></i>
							      	<i class="fa fa-star" style="font-size:20px"></i>
							      	<i class="fa fa-star" style="font-size:20px"></i>
								    <i class="fa fa-star-half-full" style="font-size:20px"></i>
								    <i class="fa fa-star-o" style="font-size:20px"></i>
								7점</span>
							</c:when>
							<c:when test="${reviewDTO.myRating == 8 }">
								<span class="star" id="reviewUpdateStarResult">
									<i class="fa fa-star" style="font-size:20px"></i>
							      	<i class="fa fa-star" style="font-size:20px"></i>
							      	<i class="fa fa-star" style="font-size:20px"></i>
								    <i class="fa fa-star" style="font-size:20px"></i>
								    <i class="fa fa-star-o" style="font-size:20px"></i>
								8점</span>
							</c:when>
							<c:when test="${reviewDTO.myRating == 9 }">
								<span class="star" id="reviewUpdateStarResult">
									<i class="fa fa-star" style="font-size:20px"></i>
							      	<i class="fa fa-star" style="font-size:20px"></i>
							      	<i class="fa fa-star" style="font-size:20px"></i>
								    <i class="fa fa-star" style="font-size:20px"></i>
								    <i class="fa fa-star-half-full" style="font-size:20px"></i>
								9점</span>
							</c:when>
							<c:when test="${reviewDTO.myRating == 10 }">
								<span class="star" id="reviewUpdateStarResult">
									<i class="fa fa-star" style="font-size:20px"></i>
							      	<i class="fa fa-star" style="font-size:20px"></i>
							      	<i class="fa fa-star" style="font-size:20px"></i>
								    <i class="fa fa-star" style="font-size:20px"></i>
								    <i class="fa fa-star" style="font-size:20px"></i>
								10점</span>
							</c:when>
						</c:choose>
						</td>
						<td>
						<input type="text" readonly="readonly" value="${reviewDTO.writer}" id="reviewUpdateWriter">
						<input type="hidden" id="reviewUpdateNum" value="${reviewDTO.num }">
						<input type="hidden" id="updateMyRating" value="${reviewDTO.myRating}">
					</td>
					<td>
						<textarea rows="" cols="" id="reviewUpdateContents" style="width: 400px; height: 50px;">${reviewDTO.contents}</textarea>
					</td>
				</c:if>
				<!-- BTN -->
				<c:if test="${memberDTO.id == review.writer && reviewDTO.num != review.num}">
					<td><button id="${review.num}" class="btn reviewUpdate">수정</button></td>
					<td><span id="${review.num}" class="reviewDelete" style="cursor: pointer;">X</span></td>
				</c:if>
				<c:if test="${memberDTO.id == review.writer && reviewDTO.num == review.num}">
					<td><button id="reviewUpdate" class="btn">수정 완료</button></td>
					<td><button class="btn" id="reviewUpdateCancel">취소</button></td>
				</c:if>
				<c:if test="${memberDTO.id != review.writer}">
					<td></td>
					<td></td>
				</c:if>
			</tr>
		</c:forEach>
	</c:if>
	<!-- 아직 리뷰가 없다면 -->
	<c:if test="${totalCount == 0}">
		<tr>
			<td colspan="7">아직 작성된 후기가 없습니다. ${memberDTO.id } 님의 소중한 후기를 부탁드립니다! </td>
		</tr>
	</c:if>
</table>
<br>

<!-- 페이징 처리 -->
	<div class="paging" style="text-align: center;">
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
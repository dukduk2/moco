<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:if test="${size ne 0}">
	<div class="movieInfo">
		<img id="${lowpricemovie.num}" class="movieGo" src="${lowpricemovie.thumnail}" style="width:250px;">
		<br>
		<span>${lowpricemovie.title }</span>
	</div>
	<!-- 현재시간 -->
	<div class="screenTime">
		<jsp:useBean id="now" class="java.util.Date"/>
		<fmt:formatDate value="${now}" var="now" pattern="yyyyMMddHHmm" />
		
		<!-- 현재시간과 비교하여 상영시간 출력. -->
		<c:forEach items="${date}" var="d" varStatus="i">
			<fmt:parseDate value="${d}${hour[i.index]}${minute[i.index]}" var="screenDate" pattern="yyyyMMddHHmm" />
			<fmt:formatDate value="${screenDate}" var="sd" pattern="yyyyMMddHHmm" />
			<fmt:formatDate value="${screenDate}" var="ex" pattern="yy년MM월dd일" />
			<c:if test="${sd-now > 0}">
				<!-- Trigger the modal with a button -->
				${ex} <span id="${screenList[i.index].num}" class="btn btn-default btn-lg reservationAdd" data-toggle="modal" data-target="#myModal">${hour[i.index]}:${minute[i.index]}</span> - ${screenList[i.index].available_seat}
				<br>
				<input type="hidden" class="time${screenList[i.index].num}" value="${lowpricemovie.play_time}">
				<input type="hidden" class="multiplex${screenList[i.index].num}" value="${screenList[i.index].multi_num}">
			</c:if>
		</c:forEach>
		<br>
	</div>
</c:if>
<c:if test="${size eq 0}">
	현재 상영중인 영화가 없습니다.
</c:if>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

${lowpricemovie.title }
<br>
<img src="${lowpricemovie.thumnail }">
<br>

<!-- 현재시간 -->
<jsp:useBean id="now" class="java.util.Date"/>
<fmt:formatDate value="${now}" var="now" pattern="yyyyMMddHHmm" />
현재시간 : ${now}
<br>

<c:forEach items="${date}" var="d" varStatus="i">
	<fmt:parseDate value="${d}${hour[i.index]}${minute[i.index]}" var="screenDate" pattern="yyyyMMddHHmm" />
	<fmt:formatDate value="${screenDate}" var="sd" pattern="yyyyMMddHHmm" />
	<c:if test="${sd-now > 0}">
		상영시간 : ${d} ${hour[i.index]}:${minute[i.index]} - ${screenList[i.index].available_seat}
		<br>
	</c:if>
</c:forEach>




 



	



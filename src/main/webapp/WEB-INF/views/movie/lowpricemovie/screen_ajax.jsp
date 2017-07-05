<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    

${lowpricemovie.title }
<br>
<img src="${lowpricemovie.thumnail }">
<br>
<c:forEach items="${date}" var="d" varStatus="i">
	${d} ${hour[i.index]}:${minute[i.index]} - ${screenList[i.index].available_seat}
	<br>
</c:forEach>
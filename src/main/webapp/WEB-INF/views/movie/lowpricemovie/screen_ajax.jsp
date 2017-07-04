<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    

<img src="${lowpricemovie.thumnail }">
${lowpricemovie.title }
<c:forEach items="screenList" var="screen">
	${screen.hour } : ${screen.minute} - ${screen.available_seat }<br>
</c:forEach>
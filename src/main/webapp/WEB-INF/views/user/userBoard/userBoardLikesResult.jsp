<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<c:if test="${message == true}">
	좋아요 취소 <i class="fa fa-thumbs-up" style="font-size:24px;color:skyblue"></i>
</c:if>
<c:if test="${message == false}">
	좋아요 <i class="fa fa-thumbs-o-up" style="font-size:24px"></i>
</c:if>
${likesResult}
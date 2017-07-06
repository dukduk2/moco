<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<table class="table">
	<tr>
		<td><input type="text" readonly="readonly" value="${memberDTO.id}" id="replyWriter" style="width: 200px; height: 40px;"></td>
		<td colspan="2"><textarea rows="" cols="" style="width: 400px; height: 50px;" id="replyContents"></textarea></td>
		<td><input type="button" id="replyInsert" value="등록" class="btn"></td>
	</tr>
	<c:forEach items="${ReplyList}" var="reply">
		<tr>
			<!-- update -->
			<c:if test="${reply.num == replyDTO.num}">
				<td>
					<input type="text" readonly="readonly" value="${replyDTO.writer}" id="replyUpdateWriter">
					<input type="hidden" id="replyUpdateNum" value="${replyDTO.num}">
				</td>
				<td colspan="2"><textarea id="replyUpdateContents" style="width: 400px; height: 50px;">${replyDTO.contents}</textarea></td>
			</c:if>
			<!-- !update -->
			<c:if test="${reply.num != replyDTO.num}">
				<td><input type="text" readonly="readonly" value="${reply.writer}" class="replyViewDisp"></td>
				<td colspan="2"><textarea readonly="readonly" style="width: 400px; height: 50px;" class="replyViewDisp">${reply.contents}</textarea></td>
			</c:if>
			<!-- BTN -->
			<c:if test="${memberDTO.id == reply.writer && replyDTO.num == reply.num}">
				<td>	
					<button class="btn" id="replyUpdate">수정완료</button>
				</td>
				<td>
					<button class="btn" id="replyUpdateCancel">취소</button>
				</td>
			</c:if>
			<c:if test="${memberDTO.id == reply.writer && replyDTO.num != reply.num}">
				<td>	
					<input type="button" class="replyUpdate btn" id="${reply.num}" value="수정">
				</td>
				<td>
					<span class="replyDelete" id="${reply.num}" style="cursor: pointer;">X</span>
				</td>
			</c:if>
			<c:if test="${memberDTO.id != reply.writer}">
				<td></td>
				<td></td>
			</c:if>
		</tr>
	</c:forEach>
</table>
<c:if test="${size>max}">
	<input type="button" id="moreView" value="더보기">
</c:if>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">${theaterDTO.name} Commit Request</h4>
        </div>
        <div class="modal-body">
        	<span>${theaterDTO.name}의 요청을 승인하시겠습니까?</span>
        </div>
        <div class="modal-footer">
			<input type="hidden" id="Tnum" value="${theaterDTO.num}">
			<button id="confirm" class="btn btn-success">예</button>&nbsp;          
			<button id="refuse" class="btn btn-danger">아니오</button>&nbsp;
        </div>
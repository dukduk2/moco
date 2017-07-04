<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">${UserBoardDTO.writer} 님의 게시물</h4>
        </div>
        <div class="modal-body">
          <table>
          	<tr>
          		<td><span style="font-size: 1.2em; font-weight: bold;">CONTENTS</span></td>
          		<td>
		          <div>${UserBoardDTO.contents}</div>          			
          		</td>
          	</tr>
          	<tr>
          		<td><span style="font-size: 1.2em; font-weight: bold;">VIDEO</span></td>
          		<td>
          			<video width="450px;" controls="controls">
						<source src="../resources/upload/userBoard/${UserBoardDTO.fname}">
					</video>			
          		</td>
          	</tr>
          </table>
        </div>
        <div class="modal-footer">
			<input type="hidden" id="Vnum" value="${UserBoardDTO.num}">
			<button id="refuse" class="btn btn-danger">승인 거절</button>&nbsp;
			<button id="confirm" class="btn btn-success">승인</button>&nbsp;          
        </div>

	

	
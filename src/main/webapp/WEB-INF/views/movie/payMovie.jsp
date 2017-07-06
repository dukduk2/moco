<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	$(function(){
		$("#btn").click(function(){
			$("#frm").submit();
		});
	});
</script>
</head>
<body>
	<h2>PAY MOVIE</h2>
	<form action="./payMovie" method="post" id="frm">
	<input type="hidden" value="${dto.num }" name="num">
	<table>
		<tr>
			<td>MOVIE : </td>
			<td>DIRECTOR : </td>
			<td>PUBDATE : </td>
			<td>PRICE : </td>
		</tr>
		<tr>
			<td>${dto.title }</td>
			<td>${dto.director }</td>
			<td>${dto.pub_date }</td>
			<%-- <td>${price }</td> --%>
	</table>
	<input type="button" value="결제하기" id="btn">
	</form>

</body>
</html>
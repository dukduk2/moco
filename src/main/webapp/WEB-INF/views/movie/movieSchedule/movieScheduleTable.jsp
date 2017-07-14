<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/resources/part/bootStrap.jspf" %>
<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.js"></script>
<link rel="styleSheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/header.css">
<link rel="styleSheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/section.css">
<title>Movie Schedule</title>

<style type="text/css">
.wrap {
   width: 1000px;
   margin: 0px auto;
}

.btn-holder {
   height: 50px;
   text-align: center;
   font-size: 30px;
   margin: 10px 0 10px 0;
}

#calendar table {
   width: 1000px;
   border-collapse: collapse;
   text-align: center;
   border: solid black 2px;
}

#calendar table thead td {
   height: 50px;
   font-weight: bold;
}

#calendar table td {
   border: solid 1px #000;
}

#calendar table td.date-cell {
   height: 100px;
   font-size: 20px;
   font-weight: bolder;
}

#calendar table td.sun {
   color: red;
}

#calendar table td.sat {
   color: blue;
}

#calendar table td.not-this-month {
   background: #999;
}

#calendar table .title {
   color: black;
   font-weight: bold;
   font-size: 15px;
}
body {
	background-size: cover;
}
hr{
	border: 1px solid #ccc;
}
</style>
<script type="text/javascript">
	$(window).load(function() {
		//---------------------------------------------------------
		var title = [];
		var year = [];
		var month = [];
		var day = [];

		$.get("./movieScheduleTableShow", function(data) {
			$(data).each(function() {
				title.push(this.title);
				//년, 월, 일 쪼개서
				year.push(Number(this.moviedate.split('-')[0]));
				month.push(Number(this.moviedate.split('-')[1]));
				day.push(Number(this.moviedate.split('-')[2]));
			});
			var calendar = new controller();
			calendar.init();
		})
		//---------------------------------------------------------

		function controller(target) {

			var that = this;
			var m_oMonth = new Date();
			m_oMonth.setDate(1);

			this.init = function() {
				that.renderCalendar();
				that.initEvent();
			}

			/* 달력 UI 생성 */
			this.renderCalendar = function() {

				var arrTable = [];

				arrTable.push('<table><colgroup>');
				for (var i = 0; i < 7; i++) {
					arrTable.push('<col width="200">');
				}
				arrTable.push('</colgroup><thead><tr>');

				var arrWeek = "일월화수목금토".split("");
				for (var i = 0, len = arrWeek.length; i < len; i++) {
					var sClass = '';
					sClass += i % 7 == 0 ? 'sun' : '';
					sClass += i % 7 == 6 ? 'sat' : '';
					arrTable.push('<td class="'+sClass+'">'
							+ arrWeek[i] + '</td>');
				}
				arrTable.push('</tr></thead>');
				arrTable.push('<tbody>');

				var oStartDt = new Date(m_oMonth.getTime());
				// 1일에서 1일의 요일을 빼면 그 주 첫번째 날이 나온다.
				oStartDt.setDate(oStartDt.getDate() - oStartDt.getDay());				

				for (var i = 0; i < 50; i++) {
					if (i % 7 == 0) {
						arrTable.push('<tr>');
					}
				
					var sClass = 'date-cell ';
					/* sClass += m_oMonth.getMonth() != oStartDt.getMonth() ? 'not-this-month ' : ''; */
					sClass += i % 7 == 0 ? 'sun' : '';
					sClass += i % 7 == 6 ? 'sat' : '';
					
					//---------------------------------------------------------					
					if(m_oMonth.getMonth() != oStartDt.getMonth()){
						/* arrTable.push('<td class="'+sClass+'">'	+ oStartDt.getDate() + '</td>'); */
						arrTable.push('<td class="'+sClass+'">'	+ '</td>');
					} else {
						for (var j = 0; j < title.length; j++) {
							//alert("날짜 : " + m_oMonth.getFullYear() + "/" + (m_oMonth.getMonth()+1) + "/" + oStartDt.getDate() + '<br>' + year[j] + "/" + month[j] + "/" + day[j] + " : " + title[j]);
							if (m_oMonth.getFullYear() == year[j] && (m_oMonth.getMonth() + 1) == month[j] && oStartDt.getDate() == day[j]) {
								arrTable.push('<td class="'+sClass+'">'	+ oStartDt.getDate() + '<br><span class="title">' + title[j] + '</span></td>');
								break;
							} else {
								if(j == (title.length-1)){
									arrTable.push('<td class="'+sClass+'">'	+ oStartDt.getDate() + '</td>');
								}
							}
						}
					}					
					//---------------------------------------------------------

					/* arrTable.push('<td class="'+sClass+'">' + oStartDt.getDate() + '</td>'); */

					oStartDt.setDate(oStartDt.getDate() + 1);

					if (i % 7 == 6) {
						arrTable.push('</tr>');
						if (m_oMonth.getMonth() != oStartDt
								.getMonth()) {
							break;
						}
					}
				}
				arrTable.push('</tbody></table>');

				$('#calendar').html(arrTable.join(""));

				that.changeMonth();
			}

			/* Next, Prev 버튼 이벤트 */
			this.initEvent = function() {
				$('#btnPrev').click(that.onPrevCalendar);
				$('#btnNext').click(that.onNextCalendar);
			}

			/* 이전 달력 */
			this.onPrevCalendar = function() {
				m_oMonth.setMonth(m_oMonth.getMonth() - 1);
				that.renderCalendar();
			}

			/* 다음 달력 */
			this.onNextCalendar = function() {
				m_oMonth.setMonth(m_oMonth.getMonth() + 1);
				that.renderCalendar();
			}

			/* 달력 이동되면 상단에 현재 년 월 다시 표시 */
			this.changeMonth = function() {
				$('#currentDate').text(
						that.getYearMonth(m_oMonth)
								.substr(0, 9));
			}

			/* 날짜 객체를 년 월 문자 형식으로 변환 */
			this.getYearMonth = function(oDate) {
				return oDate.getFullYear() + '년 '
						+ (oDate.getMonth() + 1) + '월';
			}
		}
		
		$("#back").click(function(){
			location.href="javascript:history.back()";
		})
		
		$("#refreash").click(function(){
			location.href="javascript:location.reload()";
		})
		
		$("#home").click(function(){
			location.href="../";
		});
	});
</script>
</head>

<body>
	<div class="wrap">
		<h2>이 달의 상영영화</h2><hr>
		<div class="btn-holder">
			<button class="btn" id="btnPrev">&lt;</button>
			<span id="currentDate"></span>
			<button class="btn" id="btnNext">&gt;</button>
		</div>
		<div id="calendar"></div>
	</div>
</body>
</html>
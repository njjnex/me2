<%@ include file="/WEB-INF/pages/templates/header.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<title>ÐÐ¾Ð»ÑÐ·Ð¾Ð²Ð°ÑÐµÐ»ÑÑÐºÐ°Ñ Ð¿Ð°Ð½ÐµÐ»Ñ</title>

<script src="${pageContext.request.contextPath}/resources/js/jquery.js"></script>
<script type="text/javascript">
	$(function() {
		/* For zebra striping */
		$("table tr:nth-child(odd)").addClass("odd-row");
		/* For cell text alignment */
		$("table td:first-child, table th:first-child").addClass("first");
		/* For removing the last border */
		$("table td:last-child, table th:last-child").addClass("last");
	});
</script>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/userDetails.css">


</head>
<body>
	<div class="row">
		<div class="col-md-6">
			<div id="content">
				<table>
					<tr>
						<th>Аватар</th>
						<th>Имя пользователя</th>
						<th>Пароль</th>
						<th>Создал события</th>
						<th>Учавствует в событиях</th>
					</tr>

					<tr>
						<td><img src="${pageContext.request.contextPath}/resources/images/avatars/${user.id}.jpg" 
						style="width: 70px; height:70px; border: 1px solid #ddd; border-radius:30px"/></td>
						<td>${user.username}</td>
						<td>${user.password}</td>
						<td><c:forEach var="event" items="${user.userCreatedEvents}">
		${event.eventName} 
	 </c:forEach></td>
						<td><c:forEach var="event" items="${user.userJoinedEvents}">
		${event.eventName} 
	 </c:forEach></td>
				</table>
			</div>
		</div>
		<div class="col-md-6">
			<div id="content">
				<table>
					<tr>
						<th>Событие</th>
						<th>Название</th>
						<th width="600">Участники</th>
					</tr>
					<c:forEach var="event" items="${user.userCreatedEvents}">
						<tr>
							<td>${event.eventName}</td>
							<td><c:forEach var="user"
									items="${event.eventMembersJoined}">
			${user.username}<br>

								</c:forEach></td>
							<td><c:forEach var="user"
									items="${event.eventMembersJoined}">
			email: ${user.email},Телефон»: ${user.phone} <br>

								</c:forEach></td>
					</c:forEach>
				</table>
			</div>
		</div>
	</div>


	<br>
	<div id="content">
		<button id="mybutton"
			onclick="location.href='${pageContext.request.contextPath}/${user.username}/downloadDetails.html'">Выгрузить
			в файл</button>
	</div>


</body>
</html>
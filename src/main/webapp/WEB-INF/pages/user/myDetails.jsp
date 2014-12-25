<%@ include file="/WEB-INF/pages/templates/header.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<title>Личный кабинет</title>

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
	href="${pageContext.request.contextPath}/resources/css/myDetails.css">


</head>
<body>
	<div class="row">
		<div class="col-md-3">
			<img
				src="${pageContext.request.contextPath}/resources/images/avatars/${user.id}.jpg"
				style="width: 140px; height: 140px; border: 1px solid #ddd; border-radius: 5px" />
			<h2 style="color: green">${user.username}</h2>
		</div>

		<div class="col-md-9">
			<h3>Созданные мероприятия.</h3>
			<table>
				<tr>
					<th>Название</th>
					<th width="600">Дата</th>
					<th width="600">Участники</th>
				</tr>
				<c:forEach var="event" items="${user.userCreatedEvents}">
					<tr>
						<td>${event.eventName}</td>
						<td>${event.dateStarts}</td>
						<td><c:forEach var="user" items="${event.eventMembersJoined}">
			${user.username}<br>


							</c:forEach></td>
				</c:forEach>
			</table>
			<h3>Участвует в мероприятиях</h3>
			<table>
				<tr>
					<th>Название</th>
					<th>Дата проведения</th>
					<th>Создал</th>
					<th>Описание</th>
					<th>Место проведения</th>
				</tr>

				
				<c:forEach var="event" items="${user.userJoinedEvents}">
				<tr>
					<td>${event.eventName}</td>
					<td>${event.dateStarts}</td>
					<td>${event.createdBy}</td>
					<td>${event.description}</td>
					<td>${event.place}</td>
				</tr>	
	 </c:forEach>
			</table>


		</div>
	</div>
	
	<div id="content">
		<button id="mybutton"
			onclick="location.href='${pageContext.request.contextPath}/${user.username}/downloadDetails.html'">Выгрузить
			в файл</button>
	</div>


	<%@ include file="../templates/footer.jsp"%>
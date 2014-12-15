<%@ include file="/WEB-INF/pages/templates/header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<title>Пользовательская панель</title>

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

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/userDetails.css">


</head>
<body>
<div id="content">
<table>
<tr>
<th>Имя пользователя </th>
<th> Пароль </th>
<th> Создал мероприятия</th>
<th> Участвует в мероприятиях </th>
</tr>

<tr>
<td>${user.username}</td>
<td>${user.password}</td>
<td> <c:forEach var="event" items="${user.userCreatedEvents}" >
		${event.eventName} 
	 </c:forEach>
</td>
<td>
	 <c:forEach var="event" items="${user.userJoinedEvents}" >
		${event.eventName} 
	 </c:forEach>
</td>
</table>


<table>
<tr>
<th>Событие </th>
<th> Участники </th>
<th width="600"> Контакты </th>
</tr>



<c:forEach var="event" items="${user.userCreatedEvents}" >
<tr><td>		${event.eventName}</td>
	<td>
		<c:forEach var="user" items="${event.eventMembersJoined}">
			${user.username}<br>		
	
			</c:forEach>
	</td>
		<td>
		<c:forEach var="user" items="${event.eventMembersJoined}">
			email: ${user.email}, тел: ${user.phone} <br>		
	
			</c:forEach>
	</td>
		
		
</c:forEach>
</table>
<br>
<div id="content"><button id = "mybutton"  onclick="location.href='${pageContext.request.contextPath}/${user.username}/downloadDetails.html'">Выгрузить в файл</button></div>

</div>
</body>
</html>
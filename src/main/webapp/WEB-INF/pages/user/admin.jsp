<%@ include file="../templates/header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<title>Панель администратора</title>

<script src="./resources/js/jquery.js"></script>
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

<link rel="stylesheet" href="./resources/css/global.css">


</head>
<body>
<div id="content">
<table border="1" id="admintable">
<tr>
<th id="thadmin">Имя пользователя </th>
<th id="thadmin"> Пароль </th>
<th id="thadmin"> Создал мероприятия</th>
<th id="thadmin"> Участвует в мероприятиях </th>

<th id="thadmin"> Удалить </th>
</tr>

<c:forEach var="user" items="${users }">
<tr>
<td id="thadmin">${user.username}</td>
<td id="thadmin">${user.password}</td>
<td id="thadmin"> <c:forEach var="event" items="${user.userCreatedEvents}" >
		${event.eventName} 
	 </c:forEach>
</td>
<td id="thadmin">
	 <c:forEach var="event" items="${user.userJoinedEvents}" >
		${event.eventName} 
	 </c:forEach>
</td>

<td id="thadmin">
<c:if test="${user.username != 'Admin'}">
<button id = "mybuttonadmin"  onclick="location.href='${user.id}/deleteUser.html'">Удалить пользователя</button>
</c:if>
</td>


</c:forEach>

</table>
</div>
</body>
</html>
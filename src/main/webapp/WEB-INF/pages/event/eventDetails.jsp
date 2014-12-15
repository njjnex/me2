<%@ include file="../templates/header.jsp"%>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/main.css" />
	
<!-- bootstrap -->
     <link href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <script src="${pageContext.request.contextPath}/resources/js/jquery.js"></script>
    <script src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap.min.js"></script>
<!-- end bootstrap -->
<title>Событие - ${event.eventName}</title>
</head>
<body>
	<div id="event-details">
		<div class="event">
		<div class="plan">
			<h3>${event.eventName}
				<span><img src="${pageContext.request.contextPath}/resources/images/events/${event.id}.jpg"
				style="width: 98px; height: 98px; border: 2 px solid; border-radius: 50px; border-color: #f676b2;">
			</span>
			</h3>
		</div>
		 <ul>
            <li>Дата мероприятия <b>${event.dateStarts}</b></li>
            <li>Необходимо участников: <b>${event.eventMembersCount}</b></li>
            <li><a class="tooltip" href="#">Зарегистрировались:<b>${i}</b>
            	<span class="classic">
            		<c:forEach var="userJ" items="${event.eventMembersJoined}">
						${userJ.username}
					</c:forEach>				
				</span></a></li>
			<li>Нужно еще: <b>${event.eventMembersCount - i}</b></li>
			<li>Автор мероприятия:<b>${event.createdBy.username}</b></li>
			<li>Описание:<b>${event.description}</b></li>			
        </ul> 
	</div>
	</div>
</body>
</html>
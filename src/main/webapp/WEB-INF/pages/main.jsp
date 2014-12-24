<%@ include file="./templates/header.jsp" %>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/search.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/main.css" />


<!-- <title>Главная страница</title>
			
</head>
<body> -->
	<form class="form-wrapper cf" action="${pageContext.request.contextPath}/main.html" method="post">
        <input type="text" name="searchEventName" placeholder="Название мероприятия..." required>
        <button type="submit">Искать</button>
    </form>  

<div id="event-table" class="clear">
<c:forEach var="event" items="${events}">
<%
				int i = 0;
					boolean alreadyJoined = false;
					request.setAttribute("i", i);
					request.setAttribute("joined", alreadyJoined);
			%>
<c:forEach var="userJ" items="${event.eventMembersJoined}">
								<c:if test="${userJ.username eq activeUser }"> 
									<% 	alreadyJoined = true; 
										request.setAttribute("joined", alreadyJoined);
									%>
								</c:if>	
								<% 	i++;
										request.setAttribute("i", i);
									%>								
								</c:forEach>
							
	<c:choose>
		<c:when test="${!event.active}">
			<div class="noplan">
		</c:when>
		<c:otherwise>
			<div class="plan">
		</c:otherwise>

	</c:choose>

    
        <h3><a class ="event-name" href="events/${event.id}"> ${event.eventName}</a>
        	<span>
        		<object data="${pageContext.request.contextPath}/resources/images/events/${event.id}.jpg"
					style="width: 98px; height: 98px; border: 2 px solid; border-radius: 50px; border-color: #f676b2;">
					<img src="./resources/images/party.jpg"
					style="width: 98px; height: 98px; border: 2 px solid; border-radius: 50px; border-color: #f676b2;">
			    </object>		
			</span>
		</h3>
				
<c:choose>
	<c:when test="${activeUser=='Admin'}"> <a class="remove" href="${event.id}/deleteEvent.html">Удалить</a></c:when>
		<c:otherwise>			
			<c:choose>
					<c:when test="${!event.active and (event.createdBy.username ne activeUser)}"><a class="finished">Прошло</a></c:when>
					<c:otherwise>
						<c:choose>
							<c:when test="${joined}">
								<a class="signout" href="${event.id}/unjoinEvent.html">Отказаться</a>
							</c:when>
							<c:otherwise>
								<c:choose>
									<c:when test="${event.eventMembersCount eq i}">
										<a class="signup"> Заполнено</a>
									</c:when>
									<c:otherwise>
										<c:choose>
											<c:when test="${event.createdBy.username ne activeUser}">
												<a class="signup" href="${event.id}/joinEvent.html">Участвую!</a>
												<% alreadyJoined = true; %>
											</c:when>
											<c:otherwise>
												<c:choose>
													<c:when test="${(i eq 0)}">
														<a class="remove"
															href="${event.id}/deleteEvent.html">Удалить</a>
													</c:when>
													<c:otherwise>
														<a class="empty">_____</a>
													
													</c:otherwise>
												</c:choose>	
											</c:otherwise>
										</c:choose>
									</c:otherwise>
								</c:choose>
							</c:otherwise>
						</c:choose>
					</c:otherwise>
				</c:choose>	
			</c:otherwise>	
         </c:choose>	           
        <ul>
            <li>Время мероприятия <b>${event.dateStarts}</b></li>
            <li>Необходимо участников: <b>${event.eventMembersCount}</b></li>
            <li>Зарегистрировались:<b>${i}</b></li>
			<li>Нужно еще: <b>${event.eventMembersCount - i}</b></li>
			<li>Автор мероприятия:<b><br>${event.createdBy.username}</b></li>			
        </ul> 
        </div>
         </c:forEach>
      </div>
      
   </body>
</html>

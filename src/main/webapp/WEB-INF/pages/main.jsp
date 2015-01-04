<%@ include file="./templates/header.jsp" %>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/search.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/main.css" />


<title>Находите новых друзей.</title>
			
</head>
<body>
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

    
        <h3><a class ="event-name" href="${pageContext.request.contextPath}/events/${event.id}"> ${event.eventName}</a>
        	<span>
        		<img src="/static/event${event.id}.jpg" onerror="if (this.src != 'event${event.id}.jpg') this.src = '${pageContext.request.contextPath}/resources/images/events/template.png';"
					style="width: 98px; height: 98px; border: 2 px solid; border-radius: 50px; border-color: #f676b2;">
			    		
			</span>
		</h3>
				
<c:choose>
	<c:when test="${activeUser=='Admin'}"> <button type="button" class="btn btn-danger" onclick="windows.location.href='${event.id}/deleteEvent.html'">Удалить</button></c:when>
		<c:otherwise>			
			<c:choose>
					<c:when test="${!event.active and (event.createdBy.username ne activeUser)}"><button type="button" class="btn btn-warning" disabled="disabled">Прошло</button></c:when>
					<c:otherwise>
						<c:choose>
							<c:when test="${joined}">
								<button type="button" class="btn btn-primary" onclick="window.location.href='${pageContext.request.contextPath}/${event.id}/unjoinEvent.html'">Отказаться</button>
							</c:when>
							<c:otherwise>
								<c:choose>
									<c:when test="${event.eventMembersCount eq i}">
										<button type="button" class="btn btn-default" disabled="disabled"> Заполнено</button>
									</c:when>
									<c:otherwise>
										<c:choose>
											<c:when test="${event.createdBy.username ne activeUser}">
												<button type="button" class="btn btn-info" onclick="window.location.href='${event.id}/joinEvent.html'">Участвую!</button>
												<% alreadyJoined = true; %>
											</c:when>
											<c:otherwise>
												<c:choose>
													<c:when test="${(i eq 0)}">
														<button type="button" class="btn btn-danger" onclick="window.location.href='${event.id}/deleteEvent.html'">Удалить</button>
													</c:when>
													<c:otherwise>
														<button type="button" class="btn btn-danger" onclick="window.location.href='${event.id}/deleteEvent.html'"  disabled="disabled">Удалить</button>
													
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
            <li>Время мероприятия <b><br>${event.dateStarts}</b></li>
            <li>Необходимо участников: <b>${event.eventMembersCount}</b></li>
            <li>Зарегистрировались:<b>${i}</b></li>
			<li>Автор мероприятия:<b><br><a href="${pageContext.request.contextPath}/${event.createdBy.id}/userDetails.html">${event.createdBy.username}</a></b></li>			
        </ul> 
        </div>
         </c:forEach>
      </div>
  <%@ include file="./templates/footer.jsp" %>
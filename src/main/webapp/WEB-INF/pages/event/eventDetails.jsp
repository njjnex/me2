<%@ include file="../templates/header.jsp"%>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/eventDetails.css" />
</head>
<body>
	<%
		int i = 0;
		boolean alreadyJoined = false;
		request.setAttribute("i", i);
		request.setAttribute("joined", alreadyJoined);
	%>
	<c:forEach var="userJ" items="${event.eventMembersJoined}">
		<c:if test="${userJ.username eq activeUser }">
			<%
				alreadyJoined = true;
						request.setAttribute("joined", alreadyJoined);
			%>
		</c:if>
		
		<%
			i++;
				request.setAttribute("i", i);
		%>
	</c:forEach>
	<div class="container">
		<div class="resume">
			<div class="row">
				<div
					class="col-xs-12 col-sm-12 col-md-offset-1 col-md-10 col-lg-offset-2 col-lg-8">
					<div class="panel panel-default">
						<div class="panel-heading resume-heading ">
							<div class="row">
								<div class="col-lg-12">
									<div class="col-xs-12 col-sm-4">
										<figure>
											<img class="img-circle img-responsive" alt=""
												src="${pageContext.request.contextPath}/resources/images/events/${event.id}.jpg" 
												onerror="if (this.src != '${event.id}.jpg') this.src = '${pageContext.request.contextPath}/resources/images/events/template.png';">
										</figure>

										<div class="text-center">
											<h2>
												<strong>${event.eventName}</strong>
											</h2>
										</div>
									</div>

									<div class="col-xs-12 col-sm-8">
										<ul class="list-group">

											<li class="list-group-item list-group-item-warning"><strong>
													Дата мероприятия:</strong> ${event.dateStarts}</li>
											<li class="list-group-item list-group-item-warning"><strong>Максимум
													участников:</strong> ${event.eventMembersCount}</li>
											<li class="list-group-item list-group-item-warning"><strong>Зарегистрировались:</strong>
												<c:forEach var="userJ" items="${event.eventMembersJoined}">
													<a
														href="${pageContext.request.contextPath}/${userJ.id}/userDetails.html">${userJ.username}:</a>
												</c:forEach></li>
											<li class="list-group-item list-group-item-warning"><strong>Автор
													мероприятия:</strong><a
												href="${pageContext.request.contextPath}/${event.createdBy.id}/userDetails.html">
													${event.createdBy.username}</a></li>
											<li class="list-group-item list-group-item-warning"><strong>Контакты:</strong>
												<c:choose>
													<c:when test="${joined || (activeUser eq event.createdBy.username)}">

														<i class="fa fa-envelope"> ${event.createdBy.email} </i>
														<i class="fa fa-phone"> ${event.createdBy.phone} </i>
													</c:when>
													<c:otherwise>
														<span class="label label-primary">Только для
															участников мероприятия</span>
													</c:otherwise>
												</c:choose></li>
										</ul>
									</div>
								</div>
							</div>
						</div>




						<div class="bs-callout bs-callout-danger">
							<h4>Место проведения</h4>
							<p>${event.place}</p>

							<h4>Описание</h4>
							<p>
								<c:if test="${event.description eq null}"> Описание отстствует...</c:if>
								${event.description}
							</p>
							<p>

								<c:if
									test="${(i eq 0) && (event.createdBy.username eq activeUser)}">
									<button type="button" class="btn btn-danger"
										onclick="window.location.href='${pageContext.request.contextPath}/${event.id}/deleteEvent.html'">Удалить</button>
								</c:if>
								<c:if
									test="${(i ne 0) && (event.createdBy.username eq activeUser)}">
									<button type="button" class="btn btn-danger"
										onclick="window.location.href='${event.id}/deleteEvent.html'"
										disabled="disabled">Нельзя удалить событие с
										участниками.</button>
								</c:if>


								<c:choose>
									<c:when test="${activeUser=='Admin'}">
										<button type="button" class="btn btn-danger"
											onclick="windows.location.href='${pageContext.request.contextPath}/${event.id}/deleteEvent.html'">Удалить</button>
									</c:when>
									<c:otherwise>
										<c:choose>
											<c:when
												test="${!event.active and (event.createdBy.username ne activeUser)}">
												<button type="button" class="btn btn-warning"
													disabled="disabled">Прошло</button>
											</c:when>
											<c:otherwise>
												<c:choose>
													<c:when test="${joined}">
														<button type="button" class="btn btn-primary"
															onclick="window.location.href='${pageContext.request.contextPath}/${event.id}/unjoinEvent.html'">Отказаться</button>
													</c:when>
													<c:otherwise>
														<c:choose>
															<c:when test="${event.eventMembersCount eq i}">
																<button type="button" class="btn btn-default"
																	disabled="disabled">Заполнено</button>
															</c:when>
															<c:otherwise>
																<c:choose>
																	<c:when
																		test="${event.createdBy.username ne activeUser}">
																		<button type="button" class="btn btn-info"
																			onclick="window.location.href='${pageContext.request.contextPath}/${event.id}/joinEvent.html'">Участвую!</button>
																		<%
																			alreadyJoined = true;
																		%>
																	</c:when>
																</c:choose>
															</c:otherwise>
														</c:choose>
													</c:otherwise>
												</c:choose>
											</c:otherwise>
										</c:choose>
									</c:otherwise>
								</c:choose>
							</p>
						</div>
					</div>
				</div>
			</div>


			<div class="bs-callout bs-callout-danger">
				<h4>Сообщения</h4>
				<form action="${pageContext.request.contextPath}/events/${event.id}/postMessage.html" method="post">
					<c:choose>
						<c:when test="${activeUser eq 'anonymousUser'}">
							<h5>Неизвестный пользователь.</h5>
							<div class="form-group">
								<textarea class="form-control" rows="3" id="disabledInput"
									type="text"
									placeholder="Для того чтобы оставлять сообщения необходимо зарегистрироваться..."
									disabled></textarea>
							</div>
							<button type="submit" class="btn btn-default" disabled="disabled">Отправить</button>
						</c:when>
						<c:otherwise>
							<h5>${activeUser}</h5>
							<div class="form-group">
								<textarea class="form-control" rows="3" type="text" name="text"
									placeholder="Оставьте сообшение..."></textarea>
							</div>
							<button type="submit" class="btn btn-default">Отправить</button>
						</c:otherwise>
					</c:choose>
				</form>
					<c:forEach var="message" items="${messages}">
					${message.author.username} <br>
					${message.date}<br>
					${message.text}<br>
					</c:forEach>
			</div>
		</div>
	</div>
</body>
<%@ include file="../templates/footer.jsp"%>
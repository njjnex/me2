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


						<%--  <div class="text-center">
											<h2>
												<strong>${event.eventName}</strong>
											</h2>
										</div>  --%>
						<div class="panel-heading resume-heading ">
							<%-- <div class="text-center">
											<h2>
												<strong>${event.eventName}</strong>
											</h2>
										</div>  --%>
							<div class="row">
								<div class="col-lg-12">
									<div class="col-xs-12 col-sm-4">
										<figure>
											<img class="img-circle img-responsive" alt=""
												src="${pageContext.request.contextPath}/static/event${event.id}.jpg" onerror="if (this.src != 'event${event.id}.jpg') this.src = '${pageContext.request.contextPath}/resources/images/events/template.png';">
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
													<c:when
														test="${joined || (activeUser eq event.createdBy.username)}">

														<i class="fa fa-envelope"> ${event.createdBy.email} </i>
														<i class="fa fa-phone"> ${event.createdBy.phone} </i>
													</c:when>
													<c:otherwise>
														<span class="label label-success">Только для
															участников мероприятия</span>
													</c:otherwise>
												</c:choose></li>
											<li class="list-group-item list-group-item-warning"><strong>Место
													проведения:
													<p>${event.place}</p>
											</strong>
										</ul>
									</div>
								</div>
							</div>
						</div>

						<div class="bs-callout bs-callout-danger">
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
										onclick="window.location.href='${pageContext.request.contextPath}/${event.id}/deleteEvent.html'"
										disabled="disabled">Нельзя удалить событие с
										участниками.</button>
								</c:if>


								<c:choose>
									<c:when test="${activeUser=='Admin'}">
										<button type="button" class="btn btn-danger"
											onclick="window.location.href='${pageContext.request.contextPath}/${event.id}/deleteEvent.html'">Удалить</button>
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
							<br> <br> <br>
							<div class="bs-callout bs-callout-danger" id="danger2">
								<div class="row">
									<div class="col-lg-12 col-sm-12 col-xs-12">
										<h4 id="addComment">Сообщения:</h4>


										<form class="form-inline" method="post"
											action="${pageContext.request.contextPath}/events/${eventId}/postMessage.html">
											<c:choose>
												<c:when test="${activeUser ne 'anonymousUser'}">
													<div class="form-group">
														<div class="input-group">

															<textarea class="form-control" rows="3" cols="70"
																name="text"></textarea>
															<br>
														</div>
													</div>
													<button type="submit" class="btn btn-success">Отправить</button>
												</c:when>
												<c:otherwise>
													<div class="form-group">
														<div class="input-group">
															<textarea class="form-control" rows="3" cols="70"
																placeholder="Для отправки сообщений необходима авторизация."
																id="disabledInput" disabled></textarea>
															<br>
														</div>
													</div>
													<button type="submit" class="btn btn-default"
														disabled="disabled">Отправить</button>

												</c:otherwise>
											</c:choose>
										</form>
										<hr>
										<ul class="media-list comments">
											<c:forEach var="message" items="${messages}">
												<li class="media"><a class="pull-left" href="#"> <img
														class="media-object img-circle img-thumbnail"
														src="/static/avatar${user.id}.jpg"
									onerror="if (this.src != 'avatar${user.id}.jpg') this.src = '${pageContext.request.contextPath}/resources/images/avatars/template.png';"
														width="64" alt="Generic placeholder image">
												</a>
													<div class="media-body">
														<h5 class="media-heading pull-left">
															<a
																href="${pageContext.request.contextPath}/${message.author.id}/userDetails.html">${message.author.username}</a>
														</h5>
														<div class="comment-info pull-left">
															<div class="btn btn-default btn-xs">
																<i class="fa fa-clock-o"></i> ${message.date}
															</div>
														</div>
														<br class="clearfix">
														<p class="well"><c:if test="${activeUser eq message.author.username}">
															<a
																href="${pageContext.request.contextPath}/events/${eventId}/${message.id}/deleteMessage.html"
																class="glyphicon glyphicon-remove-circle"></a>
														</c:if>${message.text}</p>
														<%-- <c:if test="${activeUser eq message.author.username}">
															<a
																href="${pageContext.request.contextPath}/events/${eventId}/${message.id}/deleteMessage.html"
																class="glyphicon glyphicon-remove-circle"></a>
														</c:if> --%>
													</div></li>
											</c:forEach>

										</ul>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>

		</div>
	</div>




</body>
<%@ include file="../templates/footer.jsp"%>

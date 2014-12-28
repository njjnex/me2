<%@ include file="/WEB-INF/pages/templates/header.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<title>Личный кабинет</title>

<!-- Bootstrap-validator-->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/bootstrap/bootstrap-validator/css/bootstrapValidator.min.css" />
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/bootstrap/bootstrap-validator/js/bootstrapValidator.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/bootstrap/bootstrap-validator/js/language/ru_RU.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/js/validationUserUpdate.js"
	type="text/javascript"></script>
<!-- End bootstrap-validator -->

<!-- File upload jasny -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/bootstrap/jasny-bootstrap/css/jasny-bootstrap.min.css" />
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/bootstrap/jasny-bootstrap/js/jasny-bootstrap.min.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/js/fileInput.js"
	type="text/javascript"></script>
<!-- End file upload jasny -->

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/myDetails.css">
</head>
<body>
	<%
		int i = 0;
	%>
	<div class="error">${error}</div>
	<hr>
	<div class="container">

		<div class="row">
			<div class="col-sm-3">
				<!--left col-->
				<img title="profile image" class="img-rounded img-responsive"
					src="${pageContext.request.contextPath}/resources/images/avatars/${user.id}.jpg"
					style="display: inline-block; width: 150px; height: 150px; overflow: hidden;">
				<h3>${user.username}</h3>
				<ul class="list-group">
					<li class="list-group-item text-muted">Активность</li>
					<li class="list-group-item text-right"><span class="pull-left"><strong>Участник</strong></span>${joined}</li>
					<li class="list-group-item text-right"><span class="pull-left"><strong>Автор</strong></span>${created}</li>
					<li class="list-group-item text-right"><span class="pull-left"><strong>Общий
								рейтинг</strong></span>${joined+created}</li>

				</ul>

				<ul class="list-group">
					<li class="list-group-item text-muted">Профиль <i
						class="fa fa-dashboard fa-1x"></i></li>
					<li class="list-group-item text-right"><span class="pull-left"><strong>Пол</strong></span>
						<c:if test="${user.gender eq 'male'}"><p>Мужской</p></c:if> <c:if
							test="${user.gender eq 'female'}"><p>Женский</p></c:if><p></p></li>
					<li class="list-group-item text-right"><span class="pull-left"><strong>Возраст</strong></span><p>${user.age}</p> </li>
					<li class="list-group-item text-right"><span class="pull-left"><strong>Email</strong></span><p>${user.email}</p> </li>
					<li class="list-group-item text-right"><span class="pull-left"><strong>Телефон</strong></span><p>${user.phone}</p> </li>
				</ul>

				<div class="panel panel-default">
					<div class="panel-heading">В сетях</div>
					<div class="panel-body">
						<i class="fa fa-facebook fa-2x"></i> <i class="fa fa-github fa-2x"></i>
						<i class="fa fa-twitter fa-2x"></i> <i
							class="fa fa-pinterest fa-2x"></i> <i
							class="fa fa-google-plus fa-2x"></i>
					</div>
				</div>

			</div>
			<!--/col-3-->
			<div class="col-sm-8">
				<ul class="nav nav-tabs" id="myTab">
					<li class="active"><a href="#myEvents" data-toggle="tab">Мои
							мероприятия</a></li>
					<li><a href="#joinedEvents" data-toggle="tab">Участвую в
							мероприятиях</a></li>
					<li><a href="#settings" data-toggle="tab">Профиль</a></li>
				</ul>

				<div class="tab-content">
					<div class="tab-pane active" id="myEvents">

						<table class="table table-striped">
							<thead>
								<tr>
									<th>Название</th>
									<th>Дата и время</th>
									<th>Место</th>
									<th>Участников</th>
									<th>Зарегистрировались</th>
								</tr>
							</thead>
							<tbody id="items">
								<c:forEach var="event" items="${user.userCreatedEvents}">
									<tr>
										<td><a href="${pageContext.request.contextPath}/events/${event.id}">${event.eventName}</a></td>
										<td>${event.dateStarts}</td>
										<td>${event.place}</td>
										<td>${event.eventMembersCount}</td>
										<td><c:forEach var="user"
												items="${event.eventMembersJoined}"><a href="${pageContext.request.contextPath}/${user.id}/userDetails.html">${user.username}</a>
												<%i = i + 1;%><br>
											</c:forEach></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>

						<hr>
						<div class="row">
							<div class="col-md-4 col-md-offset-4 text-center">
								<ul class="pagination" id="myPager"></ul>
							</div>
						</div>
						<!--/table-resp-->

						<hr>

					</div>

					<!--/tab-pane-->
					<div class="tab-pane" id="joinedEvents">

						<h2></h2>

						<ul class="list-group">
							<li class="list-group-item text-muted">Предстоящих
								мероприятий<span class="badge">${activeJoined}</span>
							</li>
							<c:forEach var="joinedEvent" items="${user.userJoinedEvents}">
								<c:if test="${joinedEvent.active}">
									<li class="list-group-item list-group-item-success text-right">
								</c:if>
								<c:if test="${!joinedEvent.active}">
									<li class="list-group-item list-group-item-danger text-right">
								</c:if>
								<a href="events/${joinedEvent.id}" class="pull-left">${joinedEvent.eventName}</a>начало: ${joinedEvent.dateStarts}</li>
							</c:forEach>
						</ul>

					</div>


					<!--/tab-pane-->
					<div class="tab-pane" id="settings">


						<hr>
						<form class="form" action="updateUser.html" method="post"
							id="registrationForm" enctype="multipart/form-data">
							<div class="form-group">

								<div class="col-xs-6">
									<label for="first_name"><h4>Имя</h4></label> <input type="text"
										class="form-control" name="first_name" id="first_name"
										id="disabledInput" placeholder="${user.username}" disabled>
								</div>
							</div>

							<div class="form-group">

								<div class="col-xs-6">
									<label for="phone"><h4>Телефон</h4></label> <input type="text"
										class="form-control" name="phone" id="phone"
										value="${user.phone}" title="enter your phone number if any.">
								</div>
							</div>

							<div class="form-group">

								<div class="col-xs-6">
									<label for="email"><h4>Email</h4></label> <input type="email"
										class="form-control" name="email" id="email"
										value="${user.email}" title="enter your email.">
								</div>
							</div>

							<div class="form-group">

								<div class="col-xs-6">
									<label for="password"><h4>Пароль</h4></label>
									<input type="password" class="form-control" name="password"
										id="password"
										placeholder="Пароль"
										title="enter your password.">
								</div>
							</div>

							<div class="col-md-6">
								<div class="form-group">
									<div class="fileinput fileinput-new" data-provides="fileinput">
										<div class="fileinput-new thumbnail" id="blank-avatar">
											<img
												src="${pageContext.request.contextPath}/resources/images/avatars/template.png" />
										</div>
										<div class="fileinput-preview fileinput-exists thumbnail"
											id="blank-avatar"></div>
										<div>
											<span class="btn btn-default btn-file"><span
												class="fileinput-new">Выберете фото</span><span
												class="fileinput-exists">Изменить</span><input type="file"
												name="file" data-bv-file="true"
												value="${pageContext.request.contextPath}/resources/images/avatars/${user.id}.jpg"
												data-bv-file-extension="jpeg,png"
												data-bv-file-type="image/jpeg,image/png"
												data-bv-file-maxsize="800000"
												data-bv-file-message="Выберете изображение размером не более 800 kB"></span>
											<a href="#" class="btn btn-default fileinput-exists"
												data-dismiss="fileinput">Удалить</a>
										</div>
									</div>
								</div>
							</div>

							<div class="form-group">
								<div class="col-xs-12">
									<br>
									<button class="btn btn-lg btn-success" type="submit">
										<i class="glyphicon glyphicon-ok-sign"></i> Сохранить
									</button>
								</div>
							</div>
						</form>
					</div>

				</div>
				<!--/tab-pane-->
			</div>
			<!--/tab-content-->

		</div>
		<!--/col-9-->
	</div>
	<!--/row-->

	<%-- <div id="content">
		<button id="mybutton"
			onclick="location.href='${pageContext.request.contextPath}/${user.username}/downloadDetails.html'">Выгрузить
			в файл</button>
	</div> --%>
	<script>
		$('.fileinput').fileinput();
		$(document).ready(function() {
			$('.fileinput').bootstrapValidator();
		});
	</script>

	<%@ include file="../templates/footer.jsp"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page
	import="org.springframework.security.core.context.SecurityContextHolder"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="${pageContext.request.contextPath}/resources/js/jquery.js"></script>

<!-- bootstrap -->
<link
	href="${pageContext.request.contextPath}/resources/bootstrap/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="${pageContext.request.contextPath}/resources/bootstrap/bootstrap/js/bootstrap.min.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/bootstrap/bootstrap/js/bootstrap-collapse.js"></script>
<!-- end bootstrap -->

<!-- Bootstrap-validator-->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/bootstrap/bootstrap-validator/css/bootstrapValidator.min.css" />
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/bootstrap/bootstrap-validator/js/bootstrapValidator.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/bootstrap/bootstrap-validator/js/language/ru_RU.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/js/validationUser.js"
	type="text/javascript"></script>
<!-- End bootstrap-validator -->

<script
	src="${pageContext.request.contextPath}/resources/js/validationSignIn.js"></script>

<link href="${pageContext.request.contextPath}/resources/css/global.css"
	rel="stylesheet">

</head>
<body>
	<%
		String aUser = SecurityContextHolder.getContext()
				.getAuthentication().getName();
	%>
	<c:set var="activeUser" value="<%=aUser%>" scope="session" />

	<nav class="navbar navbar-default navbar-fixed-top navbar-custom"
		role="navigation" id="header">
	<div class="container-fluid">
		<!-- Brand and toggle get grouped for better mobile display -->
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
				<span class="sr-only">Toggle navigation</span> <span
					class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand"
				href="${pageContext.request.contextPath}/main.html">me2</a>
		</div>

		<!-- Collect the nav links, forms, and other content for toggling -->
		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
			
				<li>
					<div class="btn-group">
						<button type="button" class="btn btn-primary dropdown-toggle"
							data-toggle="dropdown" aria-expanded="false">
							Все мероприятия <span class="caret"></span>
						</button>
						<ul class="dropdown-menu" role="menu">
							<li><a href="${pageContext.request.contextPath}/active.html">Актуальные</a></li>
							<li><a
								href="${pageContext.request.contextPath}/unactive.html">Прошедшие</a></li>
							<li class="divider"></li>
							<li><a
								href="${pageContext.request.contextPath}/myEvents.html">Мои
									события</a></li>
						</ul>

					</div>
				</li>
				<li>
					<button class="btn btn-primary" type="button"
						onclick="window.location.href='${pageContext.request.contextPath}/newEvent.html'">Добавить мероприятие</button>
				</li>
			</ul>

			<ul class="nav navbar-nav navbar-right">
				<c:if test="${activeUser=='Admin'}">
					<li><a href="${pageContext.request.contextPath}/admin.html">Администрирование</a></li>
				</c:if>
				<sec:authorize access="authenticated" var="authenticated" />
				<c:choose>
					<c:when test="${authenticated}">
						<li><button type="button" class="btn btn-success"
								onclick="window.location.href='${pageContext.request.contextPath}/myDetails.html'"> Личный кабинет ${activeUser}</button></li>
						<li><button type="button" class="btn btn-danger"
								onclick="window.location.href='${pageContext.request.contextPath}/logout.html'">Выход</button></li>
					</c:when>
					<c:otherwise>
						<li><button type="button" class="btn btn-info"
								onclick="window.location.href='${pageContext.request.contextPath}/newUser.html'">Регистрация</button></li>
						<li><button type="button" class="btn btn-success"
								data-toggle="modal" data-target="#myModal">Bход</button></li>
					</c:otherwise>
				</c:choose>

			</ul>
		</div>
	</div>
	<!-- Modal -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<form class="form-signin" role="form" id="login" name="login-form"
			class="login-form" action="<c:url value='j_spring_security_check'/>"
			method="post">
			<div class="modal-dialog modal-sm">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title" id="exampleModalLabel">Добро
							пожаловать!</h4>
					</div>
					<div class="modal-body">
						<div class="form-group">
							<label for="inputUsername" class="control-label">Имя
								пользователя</label> <input name="j_username" id="j_username"
								type="text" id="inputUsername" class="form-control"
								placeholder="Логин" required autofocus>
						</div>
						<div class="form-group">
							<label for="inputPassword" class="control-label">Пароль</label> <input
								name="j_password" id="j_password" type="password"
								id="inputPassword" class="form-control" placeholder="Пароль"
								required>
						</div>

					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">Закрыть</button>
						<button type="submit" class="btn btn-primary">Войти</button>
					</div>
				</div>
			</div>
		</form>
	</div>
	</nav>
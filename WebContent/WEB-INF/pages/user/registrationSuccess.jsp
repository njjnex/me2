<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<title>Регистрация завершена</title>
<%@ include file="../templates/header.jsp"%>
<link href="${pageContext.request.contextPath}/resources/css/login.css"
	rel="stylesheet">
<title>Поздравляем с регистрацией!</title>
</head>
<body>
	<h2>
		<p class="bg-success" align="center">Поздравляем
			Вы успешно зарегистрировались.</p>
	</h2>
	<div class="error">
		<p class="text-center">${error}</p>
	</div>
	<div class="container">
		<form class="form-signin" role="form" id="login" name="login-form"
			class="login-form" action="<c:url value='j_spring_security_check'/>"
			method="post">
			<h3 class="form-signin-heading">Вход для пользователей</h3>
			<div class="form-group">
				<label for="inputUsername" class="sr-only">Имя пользователя</label>
				<input name="j_username" id="j_username" type="text"
					id="inputUsername" class="form-control"
					placeholder="Имя пользователя" required autofocus>
			</div>
			<div class="form-group">
				<label for="inputPassword" class="sr-only">Пароль</label> <input
					name="j_password" id="j_password" type="password"
					id="inputPassword" class="form-control" placeholder="Пароль"
					required>
			</div>
			<div class="form-group">
				<button class="btn btn-lg btn-primary btn-block" type="submit">Войти</button>
			</div>
		</form>
	</div>

</body>
</html>
<%@ include file="../templates/footer.jsp"%>
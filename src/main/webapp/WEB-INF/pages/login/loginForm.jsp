<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<title>Вход</title>
<%@ include file="../templates/header.jsp" %>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/login.css" /> 

	<div id="wrapper">

		<form id="login" name="login-form" class="login-form" action="<c:url value='j_spring_security_check'/>" 
			method="post">

			<div class="header">
				<h1>Здравствуйте</h1>
				<span>Для продолжения авторизируйтесь. </span>
			</div>

			<div class="content">
				<input name="j_username" id="j_username" type="text" class="input username"
					placeholder="Имя пользователя" data-validation="length alphanumeric" 
		 data-validation-length="4-12"
					data-validation-error-msg="Недопустимое имя пользователя" /> <input
					name="j_password" id="j_password" type="password" class="input password"
					placeholder="Пароль" data-validation="length alphanumeric" 
		 data-validation-length="4-12"
					data-validation-error-msg="Недопустимый пароль"
					data-validation-length="4-12" />

			</div>

			<div class="footer">
				<input type="submit" name="submit" value="Вход" class="button" /> <input
					type="button" name="register" value="Регистрация" onclick="location.href='newUser.html'" class="register"/>
			</div>
			<script src="./resources/js/jquery.js"></script>
			<script src="./resources/js/jquery.form-validator.min.js"></script>

			<script>
				$.validate();
			</script>
		</form>

	</div>
	
</body>

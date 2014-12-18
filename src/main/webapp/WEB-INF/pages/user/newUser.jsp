<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<title>Регистрация нового пользовотеля</title>
<%@ include file="../templates/header.jsp"%>

<!-- Bootstrap-validator and file upload-->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/bootstrap-validator/css/bootstrapValidator.min.css" />
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/bootstrap-validator/js/bootstrapValidator.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/bootstrap-validator/js/language/ru_RU.js"></script>

<link
	href="${pageContext.request.contextPath}/resources/bootstrap-upload/css/fileinput.min.css"
	media="all" rel="stylesheet" type="text/css" />
<script
	src="${pageContext.request.contextPath}/resources/bootstrap-upload/js/fileinput.min.js"
	type="text/javascript"></script>
<script
	src="${pageContext.request.contextPath}/resources/js/validationUser.js"
	type="text/javascript"></script>	
<!-- End bootstrap-validator and file upload -->

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/newUser.css" />

<form:form class="form-horizontal" role="form" action="newUser.html"
	method="post" commandName="userForm">
	<form:errors path="*" cssClass="error" element="div" />
	<div class="form-group">
		<form:label for="inputUser" class="col-sm-2 control-label"
			path="username">Имя пользователя</form:label>
		<div class="col-sm-10">
			<form:input path="username" type="text" class="form-control"
				id="inputUser" placeholder="Логин" />
		</div>
	</div>
	<div class="form-group">
		<form:label path="password" for="inputPassword"
			class="col-sm-2 control-label">Пароль</form:label>
		<div class="col-sm-10">
			<form:input type="password" path="password" class="form-control"
				id="inputPassword" placeholder="Пароль" />
		</div>
	</div>
	<div class="form-group">
		<label for="inputPassword" class="col-sm-2 control-label">Повторите
			пароль</label>
		<div class="col-sm-10">
			<input type="password" name="confirmPassword" class="form-control"
				id="confirmPassword" placeholder="Повторите пароль" />
		</div>
	</div>

	<p class="help-block">Личные данные</p>
	<br>

	<div class="form-group">
		<form:label path="email" for="inputEmail"
			class="col-sm-2 control-label">Email</form:label>
		<div class="col-sm-10">
			<form:input path="email" class="form-control" placeholder="Email" />
		</div>
	</div>

	<div class="form-group">
		<form:label path="phone" for="inputEmail"
			class="col-sm-2 control-label">Телефон</form:label>
		<div class="col-sm-10">
			<form:input path="phone" class="form-control" placeholder="Телефон" />
		</div>
	</div>
	<div class="row">
		<div class="col-md-4">
			<div class="form-group">
				<label class="col-sm-5 control-label">Пол</label>
				<div class="col-sm-5">
					<div class="radio">
						<label> <form:radiobutton path="gender" name="gender"
								value="male" /> Мужской
						</label>
					</div>
					<div class="radio">
						<label> <form:radiobutton path="gender" name="gender"
								value="female" /> Женский
						</label>
					</div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-5 control-label">Возраст</label>
				<div class="col-sm-5">
					<form:select path="age" class="form-control" id="age-select">
						<form:option value=""></form:option>
						<%
							for (int i = 11; i < 60; i++) {
						%>
						<form:option value="<%=i%>"></form:option>
						<%
							}
						%>
					</form:select>
				</div>
			</div>
		</div>

		<div class="form-group">
			<label class="col-md-3 control-label">Фото</label>
			<div class="col-md-5">
				<form:input id="input-id" type="file" class="file" path="avatar"
					data-preview-file-type="text" />
			</div>
		</div>
	</div>
	<br>
	<p class="help-block">Для того чтобы присоеденится к мероприятию
		либо создать свое необходимо чтобы личные данные были заполнены. Ваши
		личные данные будут отображаться только авторам мероприятий в которых
		Вы участвуете для связи.</p>
	<br>



	<div class="form-group">
		<div class="col-sm-offset-2 col-sm-10">
			<div class="checkbox">
				<label> <input type="checkbox" name="terms"> Я
					согласен с <a href="terms.html">Правилами и условиями</a> сервиса.
				</label>
			</div>
		</div>
	</div>
	<div class="form-group">
		<div class="col-sm-offset-2 col-sm-10">
			<button type="submit" class="btn btn-default">Регистрация</button>
		</div>
	</div>
</form:form>
<script>
$("#input-id").fileinput({
	showCaption : false
});
</script>
</body>
</html>
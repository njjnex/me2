<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<title>Регистрация нового пользовотеля</title>
<%@ include file="../templates/header.jsp"%>

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

<!-- File upload jasny -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/bootstrap/jasny-bootstrap/css/jasny-bootstrap.min.css" />
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/bootstrap/jasny-bootstrap/js/jasny-bootstrap.min.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/js/fileInput.js"
	type="text/javascript"></script>
<!-- End file upload jasny -->

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/form.css" />

<form:form class="form-horizontal" role="form" action="newUser.html"
	enctype="multipart/form-data" method="post" commandName="userForm">
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
		<div class="col-md-6">
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
							class="fileinput-exists">Изменить</span> <form:label
								path="avatar" for="inputImage" /> <input type="file"
							name="file" data-bv-file="true" data-bv-file-extension="jpeg,png"
							data-bv-file-type="image/jpeg,image/png"
							data-bv-file-maxsize="800000"
							data-bv-file-message="Выберете изображение размером не более 800 kB"></span>
						<a href="#" class="btn btn-default fileinput-exists"
							data-dismiss="fileinput">Удалить</a>
					</div>
				</div>
			</div>
		</div>
	</div>
	<br>
	<p class="help-block">Ваши личные данные будут отображаться только
		авторам мероприятий в которых Вы участвуете, для того чтобы с Вами
		можно было связаться.</p>
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
			<form:button type="submit" class="btn btn btn-primary btn-lg">Регистрация</form:button>
		</div>
	</div>
</form:form>
<script>
	$('.fileinput').fileinput();
	$(document).ready(function() {
		$('.fileinput').bootstrapValidator();
	});
</script>
<%@ include file="../templates/footer.jsp"%>
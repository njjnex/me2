<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<title>Регистрация нового пользовотеля</title>
<%@ include file="../templates/header.jsp"%>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/newUser.css" />
<style>
.error {
	color: #000;
	background-color: #ffEEEE;
	border: 3px solid #ff0000;
	padding: 8px;
	margin: 16px;
}
</style>

<form:form class="form-horizontal" role="form" action="newUser.html"
	method="post" commandName="userForm">
	<div class="form-group">
		<form:label for="inputEmail3" class="col-sm-2 control-label"
			path="username">Имя пользователя*</form:label>
		<div class="col-sm-10">
			<form:input path="username" type="email" class="form-control"
				id="inputEmail3" placeholder="Логин" />
		</div>
	</div>
	<div class="form-group">
		<form:label path="password" for="inputPassword3"
			class="col-sm-2 control-label">Пароль*</form:label>
		<div class="col-sm-10">
			<form:input type="password" path="password" class="form-control"
				id="inputPassword3" placeholder="Пароль" />
		</div>
	</div>
	<div class="form-group">
		<label for="inputPassword3" class="col-sm-2 control-label">Повторите
			пароль*</label>
		<div class="col-sm-10">
			<input type="password" class="form-control" id="inputPassword3"
				placeholder="Повторите пароль" />
		</div>
	</div>
	<p class="help-block">Личные данные</p>

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

	<table>
		<tr>
			<div class="form-group">
				<td>Пол</td>
				<td><label> <form:radiobutton path="gender"
							value="male" name="optionsRadios" id="optionsRadios1" /> Мужской
				</label> <label> <form:radiobutton path="gender" value="female"
							name="optionsRadios" id="optionsRadios2" /> Женский
				</label></td>
			</div>
		</tr>
		<tr>
			<div class="form-group">
				<td>Возраст</td>
				<td><form:select path="age">
						<form:option value=""></form:option>
						<%
							for (int i = 11; i < 60; i++) {
						%>
						<form:option value="<%=i%>"></form:option>
						<%
							}
						%>
					</form:select></td>
			</div>
		</tr>
	</table>

	<p class="help-block">Для того чтобы присоеденится к мероприятию
		либо создать свое необходимо чтобы личные данные были заполнены. Ваши
		личные данные будут отображаться только авторам мероприятий в которых
		Вы участвуете.</p>



	<div class="form-group">
		<div class="col-sm-offset-2 col-sm-10">
			<div class="checkbox">
				<label> <input type="checkbox"> Я согласен с
					правилами и условиями сервиса.
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
</body>
</html>
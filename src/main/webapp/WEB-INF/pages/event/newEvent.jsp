<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>


<title>Новое событие</title>
<%@ include file="../templates/header.jsp"%>
<!-- Bootstrap-validator-->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/bootstrap-validator/css/bootstrapValidator.min.css" />
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/bootstrap-validator/js/bootstrapValidator.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/bootstrap-validator/js/language/ru_RU.js"></script>
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
<!-- File upload jasny -->
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/newUser.css" />

		<form:form id="send" action="newEvent.html" method="post"
			commandName="event" enctype="multipart/form-data">

			<div class="form-group">
				<form:label for="inputName" path="eventName">Название мероприятия *</form:label>
				<form:input type="text" class="form-control" id="inputName"
					placeholder="Введите название" path="eventName" />
			</div>

			<div class="form-group">
				<form:label path="dateStarts" for="inputDate">Дата и время начала *</form:label>
				<form:input type="datetime-local" class="form-control"
					id="inputDate" placeholder="Дата мероприятия" path="dateStarts" />
			</div>

			<div class="form-group">
				<form:label path="eventMembersCount" for="inputMembers">Количество участников *</form:label>
				<form:input type="number" class="form-control" id="inputMembers"
					placeholder="Максимум участников" path="eventMembersCount" />
			</div>

			<div class="form-group">
				<form:label path="place" for="inputPlace">Место проведения *</form:label>
				<form:input type="text" class="form-control" id="inputPlace"
					placeholder="Введите конкретное место - адрес" path="place" />
			</div>

			<div class="form-group">
				<div class="fileinput fileinput-new" data-provides="fileinput">
					<div class="fileinput-new thumbnail" id="blank-avatar" >
						<img src="${pageContext.request.contextPath}/resources/images/avatar_template.png"/>
					</div>
					<div class="fileinput-preview fileinput-exists thumbnail"
						id="blank-avatar"></div>
					<div>
						<span class="btn btn-default btn-file" ><span
							class="fileinput-new">Выберете фото</span><span
							class="fileinput-exists">Изменить</span>
							<form:label path="image" for="inputImage"/>
							<input type="file"
							name="file"></span> <a href="#"
							class="btn btn-default fileinput-exists" data-dismiss="fileinput">Удалить</a>
					</div>
				</div>
			</div>

			<div class="form-group">
				<form:label path="description" for="inputInformation">Информация для участников</form:label>
				<form:textarea path="description" class="form-control" rows="5"></form:textarea>
			</div>

			<button type="submit" class="btn btn-default">Создать
				событие</button>


		</form:form>

		

<script>
	$('.fileinput').fileinput();
</script>

</body>
</html>
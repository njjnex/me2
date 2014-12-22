<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<!-- File upload jasny -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/bootstrap/jasny-bootstrap/css/jasny-bootstrap.min.css" />
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/bootstrap/jasny-bootstrap/js/jasny-bootstrap.min.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/js/fileInput.js"
	type="text/javascript"></script>
<!-- File upload jasny -->

<title>Новое событие</title>
<%@ include file="../templates/header.jsp"%>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/newEventForm.css" />

<!--BEGIN #signup-form -->
<div id="signup-form">

	<!--BEGIN #subscribe-inner -->
	<div id="signup-inner">

		<div class="clearfix" id="header">
			<h1>Создайте свое событие!</h1>
		</div>

		<!-- 	<p>Пожалуйста заполните поля формы для добавления мероприятия.</p> -->

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
					<div class="fileinput-new thumbnail"
						style="width: 200px; height: 150px;"></div>
					<div class="fileinput-preview fileinput-exists thumbnail"
						style="max-width: 200px; max-height: 150px;"></div>
					<div>
						<span class="btn btn-default btn-file"><span
							class="fileinput-new">Выберете фото</span><span
							class="fileinput-exists">Заменить</span> <form:label path="image"
								for="inputImage" /> <input type="file" name="file"></span> <a
							href="#" class="btn btn-default fileinput-exists"
							data-dismiss="fileinput">Удалить</a>
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


		<p class="help-block">* Обязательные поля</p>

	</div>

	<!--END #signup-inner -->
</div>


<script>
	$('.fileinput').fileinput();
</script>

</body>
</html>
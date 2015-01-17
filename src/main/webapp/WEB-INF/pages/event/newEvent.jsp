<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<title>Новое мероприятие.</title>
<%@ include file="../templates/header.jsp"%>

<!-- Bootstrap datetimepicker -->
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/moment.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/bootstrap/bootstrap/js/transition.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/bootstrap/bootstrap/js/collapse.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/bootstrap/bootstrap/js/bootstrap-datetimepicker.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/bootstrap/bootstrap/css/bootstrap-datetimepicker.css" />
<!-- End bootstrap datetimepicker -->

<!-- Bootstrap-validator-->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/bootstrap/bootstrap-validator/css/bootstrapValidator.min.css" />
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/bootstrap/bootstrap-validator/js/bootstrapValidator.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/bootstrap/bootstrap-validator/js/language/ru_RU.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/js/validationEvent.js"
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

<form:form class="form-horizontal" role="form" action="newEvent.html"
	method="post" enctype="multipart/form-data" commandName="event">

	<div class="form-group">
		<form:label for="inputName" class="col-md-3 control-label"
			path="eventName">Название мероприятия *</form:label>
		<div class="col-md-5">
			<form:input type="text" class="form-control" id="inputName"
				placeholder="Введите название" path="eventName" />
		</div>
	</div>
	<div class="form-group">
		<form:label path="dateStarts" for="inputDate"
			class="col-md-3 control-label">Дата и время начала *</form:label>
		<div class="col-md-5">
			<div class='input-group date' id='datetimepicker2'>
				<form:input type='text' class="form-control" path="dateStarts" data-date-format="DD-MM-YYYY в HH:mm" />
				<span class="input-group-addon"><span
					class="glyphicon glyphicon-calendar"></span> </span>
			</div>
			<%-- <form:input type="datetime-local" class="form-control" id="inputDate"
				placeholder="Дата мероприятия" path="dateStarts" /> --%>

		</div>
	</div>
	<div class="form-group">
		<form:label path="eventMembersCount" for="inputMembers"
			class="col-md-3 control-label">Максимум участников *</form:label>
		<div class="col-md-5">
			<form:input type="text" class="form-control" id="inputMembers"
				placeholder="Максимум участников" path="eventMembersCount" />
		</div>
	</div>

	<div class="form-group">
		<form:label path="place" for="inputPlace"
			class="col-md-3 control-label">Место проведения *</form:label>
		<div class="col-md-5">
			<form:input type="text" class="form-control" id="inputPlace"
				placeholder="Введите конкретное место - адрес" path="place" />
		</div>
	</div>

	<div class="form-group" id="avatar">

		<div class="fileinput fileinput-new" data-provides="fileinput"
			class="col-md-3 control-label">
			<div class="col-md-5">
				<div class="fileinput-new thumbnail" id="blank-avatar">
					<img
						src="${pageContext.request.contextPath}/resources/images/events/template.png" />
				</div>
				<div class="fileinput-preview fileinput-exists thumbnail"
					id="blank-avatar"></div>
				<div>
					<span class="btn btn-default btn-file"><span
						class="fileinput-new">Выберете фото</span><span
						class="fileinput-exists">Изменить</span> <form:label path="image"
							for="inputImage" /> <input type="file" name="file"
						data-bv-file="true" data-bv-file-extension="jpeg,png,jpg,bmb"
						data-bv-file-maxsize="800000"
						data-bv-file-message="Выберете изображение размером не более 800 kB"></span>
					<a href="#" class="btn btn-default fileinput-exists"
						data-dismiss="fileinput">Удалить</a>
				</div>
			</div>
		</div>
	</div>

	<div class="form-group">
		<form:label path="description" for="inputInformation"
			class="col-md-3 control-label">Информация для участников</form:label>
		<div class="col-md-5">
			<form:textarea path="description" class="form-control" rows="5"></form:textarea>
		</div>
	</div>
	<div class="form-group">
		<div class="col-sm-offset-3 col-md-5">
			<form:button type="submit" class="btn btn-primary btn-lg">Создать событие</form:button>
		</div>
	</div>

</form:form>
<script>
	$('.fileinput').fileinput();
	$(document).ready(function() {
		$('.fileinput').bootstrapValidator();
	});
	$(function() {
		$('#datetimepicker2').datetimepicker({
			language : 'ru'
		});
	});
</script>
<%@ include file="../templates/footer.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<title>Регистрация нового пользовотеля</title>
<%@ include file="../templates/header.jsp"%>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/newUser.css" />
<style>
.error {
	color: #000;
	background-color: #ffEEEE;
	border: 3px solid #ff0000;
	padding: 8px;
	margin: 16px;
}
</style>
<form:form action="newUser.html" class="register" method="post"
	commandName="userForm">

	<h1>Регистрация</h1>
	<fieldset class="row1">
		<legend>Аккаунт </legend>
		<form:errors path="*" cssClass="error" element="div" />
		<p>
			<label>Имя * </label>
			<form:input path="username" class="input username" />
			
		</p>
		<p>
			<form:label path="password">Пароль *
                    </form:label>
			<form:input path="password" type="password" />
		</p>
		<p>
			<label>Повторите пароль *</label> <input type="password"
				name="passwordRep" />
			

		</p>

		<label class="obinfo">* обязательные поля </label>
		
	</fieldset>

	<fieldset class="row3">

		<legend>Личные данные </legend>
		<p></p>
		<p>
			<label class="optional">Пол</label> <label class="gender">Муж</label>
			<form:radiobutton path="gender" value="male"></form:radiobutton>
			<label class="gender">Жен</label>
			<form:radiobutton path="gender" value="female"></form:radiobutton>

		</p>
		<p>
			<label class="optional">Возраст </label>
			<form:select path="age">
				<form:option value=""></form:option>
				<%
					for (int i = 60; i > 10; i--) {
				%>
				<form:option value="<%=i%>"></form:option>
				<%
					}
				%>
			</form:select>
		</p>
		<p>
			<label class="optional">Email </label>
			<form:input path="email" />
		</p>
		<p>
			<label class="optional">Контактный телефон </label>
			<form:input path="phone" />
		</p>
		<%--  <p>
                    <form:label path="avatar" class="optional">Фото для отображения</form:label>
                   	<form:input path="avatar" class="uploadImage" id="uploadImage" type="file" name="myPhoto" onchange="PreviewImage();" />
                 
                
                    <img id="uploadPreview" class = "image" src="${pageContext.request.contextPath}/resources/images/empty.jpg" style="height:50; border-radius:50px"/>
						
						<script type="text/javascript">
							   function PreviewImage() {
        						var oFReader = new FileReader();
        						oFReader.readAsDataURL(document.getElementById("uploadImage").files[0]);

        						oFReader.onload = function (oFREvent) {
            					document.getElementById("uploadPreview").src = oFREvent.target.result;
        						};
        					};
						</script>
                </p> --%>


		<div class="infobox">
			<h4>Личные данные</h4>
			<p class="info">
				Для того чтобы присоеденится к мероприятию либо создать свое
				необходимо чтобы личные данные были заполнены. <br>
				<br>Ваши личные данные будут отображаться только авторам
				мероприятий в которых Вы участвуете.
			</p>
		</div>

	</fieldset>


	<fieldset class="row4">
		<!--  <legend>Соглашения
                </legend>
                <p class="agreement">
                    <input type="checkbox" data-validation="required" 
		 data-validation-error-msg="Вы должны принять правила пользования услугами "/>
                    <label>*  Я принимаю <a href="terms.html">Правила и условия</a></label><br>
                </p> -->
	</fieldset>

	<div>
		<button class="button">Регистрация &raquo;</button>
	</div>


	<script src="./resources/js/jquery.js"></script>
	<script src="./resources/js/jquery.form-validator.min.js"></script>

</form:form>


</body>
</html>
<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<title>Новое событие</title>
<%@ include file="../templates/header.jsp"%>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/newEventForm.css" />

<!-- bootstrap -->
    <link href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <script src="${pageContext.request.contextPath}/resources/js/jquery.js"></script>
    <script src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap.min.js"></script>
<!-- end bootstrap -->

<!--BEGIN #signup-form -->
    <div id="signup-form">
        
        <!--BEGIN #subscribe-inner -->
        <div id="signup-inner">
        
        	<div class="clearfix" id="header">
        		<h1> Создайте свое событие!</h1>
           </div>

			<!-- 	<p>Пожалуйста заполните поля формы для добавления мероприятия.</p> -->
            
        <form:form  id="send" action="newEvent.html" method="post" commandName="event" enctype="multipart/form-data">
            	
            	<div class="form-group">
   					 <form:label for="inputName" path="eventName">Название мероприятия *</form:label>
   					 <form:input type="text" class="form-control" id="inputName" placeholder="Введите название" path="eventName"/>
 				</div>
 				
 				<div class="form-group">
   					 <form:label path="dateStarts" for="inputDate">Дата и время начала *</form:label>
   					 <form:input type="datetime-local" class="form-control" id="inputDate" placeholder="Дата мероприятия" path="dateStarts"/>
 			    </div>
 			    
 			    <div class="form-group">
   					 <form:label path="eventMembersCount" for="inputMembers">Количество участников *</form:label>
   					 <form:input type="number" class="form-control" id="inputMembers" placeholder="Максимум участников" path="eventMembersCount"/>
 			    </div>
            	
            	<div class="form-group">
   					 <form:label path="place" for="inputPlace">Место проведения *</form:label>
   					 <form:input type="text" class="form-control" id="inputPlace" placeholder="Введите конкретное место - адрес" path="place"/>
 			    </div>
                          
                <div class="form-group">
               		<form:label path="image" for="inputImage">Изображение</form:label>
       			 	<input class="uploadImage" id="uploadImage" type="file" name="file" onchange="PreviewImage();" />
                    <br><img id="uploadPreview" src="${pageContext.request.contextPath}/resources/images/empty.jpg" />

						<script type="text/javascript">
							   function PreviewImage() {
        						var oFReader = new FileReader();
        						oFReader.readAsDataURL(document.getElementById("uploadImage").files[0]);

        						oFReader.onload = function (oFREvent) {
            					document.getElementById("uploadPreview").src = oFREvent.target.result;
        						};
        					};
						</script>
                </div>
             
                <div class="form-group">
   					 <form:label path="description" for="inputInformation">Информация для участников</form:label>
   					 <form:textarea path="description" class="form-control"  rows="5"></form:textarea>
 			    </div>
             
                 <button type="submit" class="btn btn-default">Создать событие</button>
                
                
       </form:form>
            
				
					<p class="help-block">* Обязательные поля</p>
				
    </div>
        
        <!--END #signup-inner -->
  </div>
        
    <!--END #signup-form -->   
 </div>

			
</body>
</html>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="org.springframework.security.core.context.SecurityContextHolder"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
   <head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
	<script src="${pageContext.request.contextPath}/resources/js/jquery.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/jquery.form-validator.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/menu.js"></script>

	<!-- bootstrap -->
    	<link href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    	<script src="${pageContext.request.contextPath}/resources/js/jquery.js"></script>
   		<script src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap.min.js"></script>
    	<script src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap-collapse.js"></script>
	<!-- end bootstrap -->
				
	</head>

<body>
   
  
	<%
		String aUser = SecurityContextHolder.getContext()
				.getAuthentication().getName();
	
	%>
	<c:set var="activeUser" value="<%=aUser%>" scope="session" />
			
<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
  <div class="container-fluid">
    <!-- Brand and toggle get grouped for better mobile display -->
    <div class="navbar-header">
      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <a class="navbar-brand" href="${pageContext.request.contextPath}/main.html" style="width:50px; height:30px;"><img src="${pageContext.request.contextPath}/resources/images/house-logo.png" style="width:30px; height:30px"/></a>
    </div>

    <!-- Collect the nav links, forms, and other content for toggling -->
    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
      <ul class="nav navbar-nav">
             
        <li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Просмотр событий <span class="caret"></span></a>
          <ul class="dropdown-menu" role="menu">
            <li><a href="${pageContext.request.contextPath}/active.html">Актуальные</a></li>
            <li><a href="${pageContext.request.contextPath}/unactive.html">Прошедшие</a></li>
            <li class="divider"></li>
            <li><a href="${pageContext.request.contextPath}/myEvents.html">Мои события</a></li>
          </ul>
        </li>
        <li><a href="${pageContext.request.contextPath}/newEvent.html">Добавить мероприятие</a></li>
      </ul>
      
      <ul class="nav navbar-nav navbar-right">
      <c:if test="${activeUser=='Admin'}">
        <li><a href="${pageContext.request.contextPath}/admin.html">Администрирование</a></li>
      </c:if> 
      <sec:authorize access="authenticated" var="authenticated" />
			<c:choose>
				<c:when test="${authenticated}">
				  <li><a href="${pageContext.request.contextPath}/userdetails.html">${activeUser}</a></li>
				  <li><a href='${pageContext.request.contextPath}/logout.html'>Выход</a></li>
				</c:when>
				<c:otherwise>
					<li><a href='${pageContext.request.contextPath}/newUser.html'>Регистрация</a></li>
					<li><a href='${pageContext.request.contextPath}/user-login.html'>Вход</a></li>
				</c:otherwise>
			</c:choose>
       
      </ul>
    </div><!-- /.navbar-collapse -->
  </div><!-- /.container-fluid -->
</nav>
		
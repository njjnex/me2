<%@ include file="/WEB-INF/pages/templates/header.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<title>Информация о пользователе ${user.username}</title>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/userDetails.css">

<title>Информация о пользователе.</title>
</head>
<body>
<div class="container" id="userDatails">
	<div class="row">
		<div class="col-md-offset-2 col-md-8 col-lg-offset-3 col-lg-6">
    	 <div class="well profile">
            <div class="col-sm-12">
                <div class="col-xs-12 col-sm-8">
                    <h2>${user.username}</h2>
                    <p><strong>Пол: </strong> <c:if test="${user.gender eq 'male'}">Мужской</c:if> <c:if
							test="${user.gender eq 'female'}">Женский</c:if></p>
                    <p><strong>Возраст: </strong> ${user.age} </p>
                    <p><strong>Email </strong>${user.email}   </p>
                </div>             
                <div class="col-xs-12 col-sm-4 text-center">
                    <figure>
                        <img src="/static/avatar${user.id}.jpg" onerror="if (this.src != '${user.id}.jpg') this.src = '${pageContext.request.contextPath}/resources/images/avatars/template.png';" class="img-circle img-responsive">
                    </figure>
                </div>
            </div>            
            <div class="col-xs-12 divider text-center">
                <div class="col-xs-12 col-sm-4 emphasis">
                    <h2><strong>${joinedU}</strong></h2>                    
                    <p><small>Участвовал</small></p>
                    <button class="btn btn-success btn-block" onclick="window.location.href='${pageContext.request.contextPath}/${user.id}/joinedEvent.html'"><span class="fa fa-plus-circle"></span>Посмотреть</button>
                </div>
                <div class="col-xs-12 col-sm-4 emphasis">
                    <h2><strong>${createdU}</strong></h2>                    
                    <p><small>Создал</small></p>
                    <button class="btn btn-info btn-block" onclick="window.location.href='${pageContext.request.contextPath}/${user.id}/createdEvent.html'"><span class="fa fa-user"></span>Посмотреть</button>
                </div>
                <div class="col-xs-12 col-sm-4 emphasis">
                    <h2><strong>${createdU + joinedU}</strong></h2>                    
                    <p><small>Рейтинг</small></p>
                    <!-- <div class="btn-group dropup btn-block">
                      <button type="button" class="btn btn-primary"><span class="fa fa-gear"></span> Options </button>
                      <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown">
                        <span class="caret"></span>
                        <span class="sr-only">Toggle Dropdown</span>
                      </button>
                      <ul class="dropdown-menu text-left" role="menu">
                        <li><a href="#"><span class="fa fa-envelope pull-right"></span> Send an email </a></li>
                        <li><a href="#"><span class="fa fa-list pull-right"></span> Add or remove from a list  </a></li>
                        <li class="divider"></li>
                        <li><a href="#"><span class="fa fa-warning pull-right"></span>Report this user for spam</a></li>
                        <li class="divider"></li>
                        <li><a href="#" class="btn disabled" role="button"> Unfollow </a></li>
                      </ul>
                    </div> -->
                </div>
            </div>
    	 </div>                 
		</div>
	</div>
</div>
 <%@ include file="../templates/footer.jsp" %>
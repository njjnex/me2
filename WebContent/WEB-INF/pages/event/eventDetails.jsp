<%@ include file="../templates/header.jsp"%>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/eventDetails.css" />

<!-- bootstrap -->
<link
	href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">
<script src="${pageContext.request.contextPath}/resources/js/jquery.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap.min.js"></script>
<!-- end bootstrap -->

</head>
<body>

	<div class="container">
		<div class="resume">
			
			<div class="row">
				<div
					class="col-xs-12 col-sm-12 col-md-offset-1 col-md-10 col-lg-offset-2 col-lg-8">
					<div class="panel panel-default" >
						<div class="panel-heading resume-heading " >
							<div class="row" >
								<div class="col-lg-12">
									<div class="col-xs-12 col-sm-4">
										<figure>
											<img class="img-circle img-responsive" alt=""
												src="${pageContext.request.contextPath}/resources/images/events/${event.id}.jpg">
										</figure>

										<div class="text-center"><h2><strong>${event.eventName}</strong></h2> 
    
  </div>

									</div>

									<div class="col-xs-12 col-sm-8">
										<ul class="list-group">
										
											<li class="list-group-item list-group-item-warning"><strong> Дата
													мероприятия:</strong> ${event.dateStarts}</li>
											<li class="list-group-item list-group-item-warning"><strong>Необходимо
													участников:</strong> ${event.eventMembersCount}</li>
											<li class="list-group-item list-group-item-warning"><strong>Зарегистрировались:</strong><c:forEach var="userJ"
													items="${event.eventMembersJoined}">
													
						${userJ.username},    
					</c:forEach></li>
											<li class="list-group-item list-group-item-warning"><strong>Автор
													мероприятия:</strong> ${event.createdBy.username}</li>
											<li class="list-group-item list-group-item-warning"><i class="fa fa-envelope"></i> <i class="fa fa-phone"></i> <strong>Контакты:</strong>
												${event.createdBy.phone}</li>
										
										</ul>
									</div>
								</div>
							</div>
						</div>


<div class="bs-callout bs-callout-danger">
        <h4>Описание</h4>
        <p>
         Lorem ipsum dolor sit amet, ea vel prima adhuc, scripta liberavisse ea quo, te vel vidit mollis complectitur. Quis verear mel ne. Munere vituperata vis cu, 
         te pri duis timeam scaevola, nam postea diceret ne. Cum ex quod aliquip mediocritatem, mei habemus persecuti mediocritatem ei.
        </p>
        <p>
            Odio recteque expetenda eum ea, cu atqui maiestatis cum. Te eum nibh laoreet, case nostrud nusquam an vis. 
            Clita debitis apeirian et sit, integre iudicabit elaboraret duo ex. Nihil causae adipisci id eos.

        </p>
      </div>
      
<div class="bs-callout bs-callout-danger">
        <h4>Дополнительно</h4>
       
        <p>
          Software Engineering, Machine Learning, Image Processing,
          Computer Vision, Artificial Neural Networks, Data Science,
          Evolutionary Algorithms.
        </p>
         <p>
<button class="btn btn-info" type="button">Large button</button>

<button class="btn btn-success" type="button">Участвовать</button>
</p>
      </div>



					</div>
				</div>
			</div>
		</div>
	</div>

</body>
</html>
$(document).ready(function() {
	$('.form-horizontal').bootstrapValidator({
		// To use feedback icons, ensure that you use Bootstrap v3.1.0 or later
		feedbackIcons : {
			valid : 'glyphicon glyphicon-ok',
			invalid : 'glyphicon glyphicon-remove',
			validating : 'glyphicon glyphicon-refresh'
		},
		fields : {
			eventName : {
				message : 'The username is not valid',
				validators : {
					notEmpty : {
						message : 'Введите название мероприятия.'
					},
					stringLength : {
						min : 4,
						max : 14,
						message : 'Название должно содержать от 4 до 14 сиволов.'
					},
					regexp : {
						regexp : /^[a-zA-Z0-9-а-яА-Я\s]+$/,
						message : 'Недопустимые символы в названии.'
					},
				}
			},
			dateStarts : {
				validators : {
					notEmpty : {
						message : 'Укажите дату начала.'
					},
				}
			},
			eventMembersCount : {
				validators : {
					notEmpty : {
						message : 'Укажите максимальное количество участников'
					},
					between : {
						min : 0,
						max : 1000,
						message : 'Число участников от 1 до 1000'
					},
				}
			},
			place : {
				validators : {
					notEmpty : {
						message : 'Укажите место где пройдет событие.'
					}
				}
			}
		}
	});
});


function scroll_to_class(element_class, removed_height) {
	var scroll_to = $(element_class).offset().top - removed_height;
	if($(window).scrollTop() != scroll_to) {
		$('html, body').stop().animate({scrollTop: scroll_to}, 0);
	}
}

function bar_progress(progress_line_object, direction) {
	var number_of_steps = progress_line_object.data('number-of-steps');
	var now_value = progress_line_object.data('now-value');
	var new_value = 0;
	if(direction == 'right') {
		new_value = now_value + ( 100 / number_of_steps );
	}
	else if(direction == 'left') {
		new_value = now_value - ( 100 / number_of_steps );
	}
	progress_line_object.attr('style', 'width: ' + new_value + '%;').data('now-value', new_value);
}

jQuery(document).ready(function() {
	
    /*
        Fullscreen background
    */
    // $.backstretch("assets/img/backgrounds/1.jpg");
    
    $('#top-navbar-1').on('shown.bs.collapse', function(){
    	$.backstretch("resize");
    });
    $('#top-navbar-1').on('hidden.bs.collapse', function(){
    	$.backstretch("resize");
    });
    
    /*
        Form
    */
    $('.wizard fieldset:first').fadeIn('slow');
    
    $('.wizard input[type="text"], .wizard input[type="password"], .wizard textarea').on('focus', function() {
    	$(this).removeClass('input-error');
    });
	$('.bootstrap-select > .btn-default').on('focus',function () {
		$(this).css('border','solid 1px #ccc')
	});
    // next step
    $('.wizard .btn-next').on('click', function() {
    	var parent_fieldset = $(this).parents('fieldset');
    	var next_step = true;
    	// navigation steps / progress steps
    	var current_active_step = $(this).parents('.wizard').find('.wizard-step.active');
    	var progress_line = $(this).parents('.wizard').find('.wizard-progress-line');

    	parent_fieldset.find('input[type="text"]').each(function() {
			if($(this).val().toString().trim() == "" && $(this).prop('required')) {
    			$(this).addClass('input-error');
    			next_step = false;
			} else {
    			$(this).removeClass('input-error');
    		}
    	});

		parent_fieldset.find('input[type="date"]').each(function() {
			if ($(this).val().toString().trim() == "" && $(this).prop('required')) {
				$(this).addClass('input-error');
				next_step = false;
			} else {
				$(this).removeClass('input-error');
			}
		});


		parent_fieldset.find('select').each(function() {
			if($(this).val() == "" && $(this).prop('required')) {
				id = $(this).attr('id');
				$('[data-id = "'+id+'"]').css('border','solid 1px red');
				next_step = false;
			}
		});

		parent_fieldset.find('textarea').each(function() {
			if ($(this).val().toString().trim() == "" && $(this).prop('required')) {
				$(this).addClass('input-error');
				next_step = false;
			} else {
				$(this).removeClass('input-error');
			}
		});

		if( next_step ) {
    		parent_fieldset.fadeOut(400, function() {
    			// change icons
    			current_active_step.removeClass('active').addClass('activated').next().addClass('active');
    			// progress bar
    			bar_progress(progress_line, 'right');
    			// show next step
	    		$(this).next().fadeIn();
	    		// scroll window to beginning of the form
    			scroll_to_class( $('.wizard'), 20 );
	    	});
    	}
    	
    });
    
    // previous step
    $('.wizard .btn-previous').on('click', function() {
    	// navigation steps / progress steps
    	var current_active_step = $(this).parents('.wizard').find('.wizard-step.active');
    	var progress_line = $(this).parents('.wizard').find('.wizard-progress-line');
    	
    	$(this).parents('fieldset').fadeOut(400, function() {
    		// change icons
    		current_active_step.removeClass('active').prev().removeClass('activated').addClass('active');
    		// progress bar
    		bar_progress(progress_line, 'left');
    		// show previous step
    		$(this).prev().fadeIn();
    		// scroll window to beginning of the form
			scroll_to_class( $('.wizard'), 20 );
    	});
    	// alert(current_active_step.index())
    });
    
    // // // submit
    // $('.wizard').on('submit', function(e) {
    // 	// // fields validation
    // 	$(this).find('input[type="text"], input[type="password"], textarea').each(function() {
    // 		if( $(this).val() == "" && $(this).prop('required')) {
    // 			e.preventDefault();
    // 			alert('maluco');
    // 			$(this).addClass('input-error');
    // 		}
    // 		else {
    // 			$(this).removeClass('input-error');
    // 		}
    // 	});
    // });


});
$.fn.datepicker.dates['pt'] = {
	days: ["Domingo", "Segunda", "Terça", "Quarta", "Quinta", "Sexta", "Sábado"],
	daysShort: ["Dom", "Seg", "Ter", "Qua", "Qui", "Sex", "Sáb"],
	daysMin: ["Do", "Se", "Te", "Qu", "Qu", "Se", "Sa"],
	months: ["Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho", "Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro"],
	monthsShort: ["Jan", "Fev", "Mar", "Abr", "Mai", "Jun", "Jul", "Ago", "Set", "Out", "Nov", "Dez"],
	today: "Hoje",
	monthsTitle: "Meses",
	clear: "Limpar",
	format: "dd/mm/yyyy"
};
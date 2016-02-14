// Para fijar el menú en la parte superior
$(window).scroll(function(){
	//Número de px para que se aplique
	if ($(this).scrollTop()>200){
		// Coge ('...') y ponle la clase ('...')
		$('.topbar').addClass('topbarscroll');
	} else {
		// si no hay scroll, quitale a ('...') la clase ('...')
		$('.topbar').removeClass('topbarscroll');
	}
});

// Scroll suave entre enlaces
$(document).ready(function(){
	$('a[href^="#"]').on('click',function (e){
		e.preventDefault();

		var target = this.hash;
		var $target = $(target);

		$('html, body').stop().animate({
			'scrollTop': $target.offset().top
		//tiempo que dura el scroll
		}, 900, 'swing', function(){
			window.location.hash = target;
		});
	});
});
$(document).ready(function() {

	$('.user-input').focus(function() {
		$('.user-input').css('border','1px solid rgba(68,153,233,1)');
		$(this).animate({width:'70%'}, 1000);
	});

	$('.search-field').on('submit',function(e){
		e.preventDefault();
		$('.loader').html("<img src='ajax-loader.gif'>");
		$.ajax({
			type: 'get',
			url: '/:username',
			data: $(this).serialize()			
		}).done(function(data){
			$('.loader').hide();
			$('.results').html(data);
		});
	});


	// $('.post_tweet').on('submit', function(e){
	// 	e.preventDefault();
	// 	$.ajax({
	// 		type: 'post',
	// 		url: '/post_tweet',
	// 		data: $(this).serialize()
	// 	}).done(function(){
	// 		alert("Thanks for successfully tweeting!");		
	// 	}).fail(function(){
	// 		alert("Your tweet has failed! Sorry!");
	// 	});
	// });
});

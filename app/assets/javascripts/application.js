// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require_tree .
$(function(){
	$("a.vote_up").click(function(){
	//get the id
	the_id = $(this).attr('id');

	$(this).parent().html("<img src='/assets/loader.gif>");

	$("span#votes_count"+the_id).fadeOut("fast");

		$.ajax({
			type: "POST",
			url: '/posts/' + $(this).attr("id") + '/vote_up',
      dataType: "json",
			success: function(msg)
			{
				$("span#votes_count"+the_id).html(msg.count);

				$("span#votes_count"+the_id).fadeIn();

				$("span#vote_buttons"+the_id).remove();
			}
		});
	});

	$("a.vote_down").click(function(){
	//get the id
	the_id = $(this).attr('id');

	// show the spinner
	$(this).parent().html("<img src='/assets/loader.gif'/>");

	//the main ajax request
		$.ajax({
			type: "POST",
			url: '/posts/' + $(this).attr("id") + '/vote_down',
      dataType: "json",
			success: function(msg)
			{
				$("span#votes_count"+the_id).fadeOut();
				$("span#votes_count"+the_id).html(msg.count);
				$("span#votes_count"+the_id).fadeIn();
				$("span#vote_buttons"+the_id).remove();
			}
		});
	});
	// for quick del.
	// $("a.destroy").click(function(e){
	// e.preventDefault();
	// 
	// the_id = $(this).attr('id');
	// 
	// 	$.ajax({
	// 		type: "delete",
	// 		url: '/posts/' + $(this).attr("id"),
	//       dataType: "json",
	// 		success: function(msg)
	// 		{
	// 			$('tr#delete_button'+the_id).remove();
	// 		}
	// 	});
	// });
});
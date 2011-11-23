// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

// Make checkboxes auto-update form
$('.submittable').live('change', function() {
	$(this).parents('form:first').submit();
});


// Add hot keys! So hot!!
function domo() {
	// Add new project
	jQuery(document).bind('keydown', 'p', function (evt) {
		$('#project_name').focus();
		return false;
	});

	// Add new step
	jQuery(document).bind('keydown', 's', function (evt) {
		$('#step_content').focus();
		return false;
	});

	// Select project#index page
	jQuery(document).bind('keydown', 'shift+p', function (evt) {
		$(location).attr('href', '/projects');
		return false;
	});

	// Select todo page
	jQuery(document).bind('keydown', 'shift+t', function (evt) {
		$(location).attr('href', '/todo');
		return false;
	});


	// Select specific project's page

	// TODO: Clean up ugly copy paste
	if(window.location.pathname === '/projects') {
		jQuery(document).bind('keydown', 'shift+1', function (evt) {
			$(location).attr('href', '/projects/' + $('#1').attr('project_id') + '/steps');
			return false;
		});

		jQuery(document).bind('keydown', 'shift+2', function (evt) {
			$(location).attr('href', '/projects/' + $('#2').attr('project_id') + '/steps');
			return false;
		}); 

		jQuery(document).bind('keydown', 'shift+3', function (evt) {
			$(location).attr('href', '/projects/' + $('#3').attr('project_id') + '/steps');
			return false;
		});      

		jQuery(document).bind('keydown', 'shift+4', function (evt) {
			$(location).attr('href', '/projects/' + $('#4').attr('project_id') + '/steps');
			return false;
		});

		jQuery(document).bind('keydown', 'shift+5', function (evt) {
			$(location).attr('href', '/projects/' + $('#5').attr('project_id') + '/steps');
			return false;
		});
	}
}

jQuery(document).ready(domo);     



// Make the project steps sortable
$(document).ready(function() {
	$("#stepTable tbody.content").sortable({
		update: function(){
			$.ajax({
				type: 'post',
				data: $('#stepTable tbody.content').sortable('serialize'),
				dataType: 'script',
				url: '/steps/sort'
			})
		}
	})
});

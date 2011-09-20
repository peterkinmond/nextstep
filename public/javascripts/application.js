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
}


jQuery(document).ready(domo);     
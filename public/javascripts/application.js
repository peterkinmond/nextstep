// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

// Make checkboxes auto-update form
$('.submittable').live('change', function() {
    $(this).parents('form:first').submit();
});


// Add hot keys! So hot!!
function domo() {
    // Add new project
    if (window.location.pathname === '/projects') {
        jQuery(document).bind('keydown', 'p', function (evt) {
            $('#project_name').focus();
            return false;
        });
    }

    // Add new step
    if (window.location.pathname.indexOf("/steps") != -1) {
        jQuery(document).bind('keydown', 's', function (evt) {
            $('#step_content').focus();
            return false;
        });
    }

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

    // Select specific project's page('shift + 1' takes you to first listed project, etc)
    if (window.location.pathname === '/projects') {
        for (i = 1; i <= 9; i++) {
            (function(i) {
                jQuery(document).bind('keydown', 'shift+' + i, function (evt) {
                    if ($('#' + i).attr('project_id')) {
                        $(location).attr('href', '/projects/' + $('#' + i).attr('project_id') + '/steps');
                        return false;
                    }
                });
            })(i);
        };
    }
}

jQuery(document).ready(domo);


// Make the project steps sortable
$(document).ready(function() {
    $("#stepTable tbody.content").sortable({
        update: function() {
            $.ajax({
                type: 'post',
                data: $('#stepTable tbody.content').sortable('serialize'),
                dataType: 'script',
                url: 'steps/sort'
            })
        }
    })
});

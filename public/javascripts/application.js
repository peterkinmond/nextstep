// This file is automatically included by javascript_include_tag :defaults

// Make checkboxes auto-update form
$('.submittable').live('change', function() {
    $(this).parents('form:first').submit();
});

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

// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
                                            
// Make checkboxes auto-update form
$('.submittable').live('change', function() {
  $(this).parents('form:first').submit();
});
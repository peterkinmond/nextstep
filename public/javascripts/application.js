// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
                                            
// Make checkboxes auto-update form
$('.submittable').live('change', function() {
  $(this).parents('form:first').submit();
});   


// Add hot keys! So hot!!
function domo(){
    jQuery('#platform-details').html('<code>' + navigator.userAgent + '</code>');
    jQuery(document).bind('keydown', '/', function (evt){
        alert("Hello Slash"); 
        return false; 
    });
    jQuery(document).bind('keydown', 'ctrl+p meta+p', function (evt){
        alert("think green-don't print"); 
        return false; 
    });
}


jQuery(document).ready(domo);     
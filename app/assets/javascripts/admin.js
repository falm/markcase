// 
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap/alert
//= require hideshow
//= require jquery.equalHeight
//= require jquery.tablesorter
//= require jquery.ui.all
//= require tag-it
//= require_self
//= require_directory ./admin

$(document).ready(function(){ 
    $(".tablesorter").tablesorter(); 
});

$(document).ready(function() {

  //When page loads...
  $(".tab_content").hide(); //Hide all content
  $("ul.tabs li:first").addClass("active").show(); //Activate first tab
  $(".tab_content:first").show(); //Show first tab content

  //On Click Event
  $("ul.tabs li").click(function() {

    $("ul.tabs li").removeClass("active"); //Remove any "active" class
    $(this).addClass("active"); //Add "active" class to selected tab
    $(".tab_content").hide(); //Hide all tab content

    var activeTab = $(this).find("a").attr("href"); //Find the href attribute value to identify the active tab + content
    $(activeTab).fadeIn(); //Fade in the active ID content
    return false;
  });

});

$(function(){
  $('.column').equalHeight();
});


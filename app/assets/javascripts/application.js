// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
// require jquery.ui.core
//= require jquery.ui.all
//= require twitter/bootstrap/modal
//= require twitter/bootstrap/dropdown
//= require twitter/bootstrap/alert
//= require twitter/bootstrap/transition
// require jqBootstrapValidation
//= require jqBootstrapValidation.1.3.4
//= require cycle
//= require tag-it
//= require users
//= require bookmarks
//= require sessions
//= require settings
//= require_self



  $(function(){
    $("input").not("[type='submit']").not("[type='hidden']").jqBootstrapValidation({

      submitSuccess: function($form,event){
      }
    });
    $("form").submit(submitHandler);
  });
  

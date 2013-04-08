# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
###
jQuery ->
  $("#users").dataTable
    bJqueryUI: true
###
$(document).ready ->
  $("#bookmarkTags").tagit
    availableTags: ["rails", "ruby"]
 
  $("#bookmarkTags input").blur ->
    tags_string = $("#bookmarkTags").tagit("assignedTags").toString()
    $("#bookmark_tag_list").val(tags_string)

  $("#bookmarkTags").tagit
    afterTagRemoved: (event,ui)->
      tags_string = $("#bookmarkTags").tagit("assignedTags").toString()
      $("#bookmark_tag_list").val(tags_string)   sPaginationiType: "full_number"

  $("#users-item").change ->
    alert $(this).val()
  ###
  $("#users-item:checked").each do
    alert "item checked"
  end
  ###

  $("a[data-method='delete']").on "ajax:success", (e,data, textStatus, jqXHR) ->
    #alert data.message
    $(this).parents("tr").remove()

    

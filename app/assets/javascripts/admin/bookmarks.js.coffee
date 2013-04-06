# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


 $(document).ready ->
  $("#bookmarkTags").tagit
    availableTags: ["rails", "ruby"]

 
  $("#bookmarkTags input").blur ->
    tags_string = $("#bookmarkTags").tagit("assignedTags").toString()
    $("#bookmark_tag_list").val(tags_string)

  $("#bookmarkTags").tagit
    afterTagRemoved: (event,ui)->
      tags_string = $("#bookmarkTags").tagit("assignedTags").toString()
      $("#bookmark_tag_list").val(tags_string)

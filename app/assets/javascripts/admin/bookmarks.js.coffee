# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->

  change_tags = (data) ->
    id = $("#bookmarkTags").attr("data-id")
    $.getJSON "/admin/bookmarks/tag.json", { id: id, tags: data.toString()}, (data) ->

  $("#bookmarkTags").tagit
    availableTags: ["rails", "ruby"],
    afterTagRemoved: (e,ui) ->
      tags = $(this).tagit("assignedTags")
      change_tags(tags)
    ,afterTagAdded: (e,ui) ->
      tags = $(this).tagit("assignedTags")
      change_tags(tags)



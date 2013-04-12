  $(".bookmark-list").html("<%= escape_javascript(render "bookmarks")%>")
###
  # bookmarks change method
  bookmarks_change = (data,id) ->
    $.post "/bookmarks/#{id}", { bookmark: { tag_list:  data.toString() }, _method: 'PUT'}, (data) ->
      element = $(".has_tags[data-id='#{id}']")
      #alert data.message
      html = ""
      for tag in data.taglist
        html+="
          <li>
            <a href='#' class='tag-background'>#{tag}</a>
          </li>
        "
      element.html html
    ,"json"
  # tags data binding
  $(".add-tags").tagit
    availableTags: ['ruby','rails'],
    afterTagRemoved: (event, ui) ->
      id = $(this).attr('name')
      tags = $(this).tagit("assignedTags")
      bookmarks_change(tags,id)
    , afterTagAdded: (event, ui) ->
      id = $(this).attr('name')
      tags = $(this).tagit("assignedTags")
      bookmarks_change(tags,id)
###


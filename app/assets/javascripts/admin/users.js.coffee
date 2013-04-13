
$(document).ready ->
  
  exports = this #global variable
  exports.user_ids = new Array #user id collection array

  #loading bookmarks data to ajax method
  ###
  load_bookmark = (id)->
    $.get "/admin/users/get_bookmarks/#{id}.json",  (data) ->
      tbody = $("#bookmarks-list > tbody")
      html = ""
      for bookmark in data
        html += "
        <tr>
          <td><a href='/admin/bookmarks/#{bookmark.id}'>#{bookmark.link}</a></td>
          <td>#{bookmark.title}</td>
          <td><a title='编辑' href='/admin/bookmarks/#{bookmark.id}/edit'><img src='/assets/admin/icn_edit.png' /></a>
              <a title='删除' data-method='delete' href='/admin/bookmarks/#{bookmark.id}'>
                <img src='/assets/admin/icn_trash.png' />
              </a>
          </td>
        </tr>"
      tbody.html(html)
    ,"json"
  ###
  load_bookmark = (id) ->
    uid = exports.user_id
    $.getScript "/admin/bookmarks.js?user_id=#{uid}"
      
  #loading categories data to ajax method
  load_categories = (id) ->
    $.getScript "/admin/users/#{id}/categories.js"
  ###
  load_categories = (id)->
    $.get "/admin/users/get_categories/#{id}.json",  (data) ->
      tbody = $("#categories-list > tbody")
      html = ""
      for category in data
        html += "
        <tr>
          <td><a href='/admin/categories/#{category.id}'>#{category.title}</a></td>
          <td><a title='编辑' href='/admin/categories/#{category.id}/edit'><img src='/assets/admin/icn_edit.png' /></a>
              <a title='删除' data-method='delete' href='/admin/categories/#{category.id}'>
                <img src='/assets/admin/icn_trash.png' />
              </a>
          </td>
        </tr>"
      tbody.html(html)
    ,"json"
  ###
  #set available data
  $("#bookmarkTags").tagit
    availableTags: ["rails", "ruby"]

  # add tag list to #bookmark_tag_list 
  $("#bookmarkTags input").blur ->
    tags_string = $("#bookmarkTags").tagit("assignedTags").toString()
    $("#bookmark_tag_list").val(tags_string)

  # banding afterTagRemove event to bookmark tag list
  $("#bookmarkTags").tagit
    afterTagRemoved: (event,ui)->
      tags_string = $("#bookmarkTags").tagit("assignedTags").toString()
      $("#bookmark_tag_list").val(tags_string) #  sPaginationiType: "full_number"
  
  # add user id to exports.user_ids array when it checked
  $(document).on 'change', "#users-item", ->
    exports.user_ids.push $(this).val()

  # change table item background color and add current user id to exports.uses_id when event click be true
  #$("#users tr").click ->
  $(document).on "click","#users tr", ->
    $("#users tr").not(this).removeClass "selected"
    $(this).addClass "selected"
    exports.user_id = $(this).children().children().val()
  

  # delete user ajax method
  $("a[data-method='delete']").on "ajax:success", (e,data, textStatus, jqXHR) ->
    $(this).parents("tr").remove()

  #加载 bookmarks 数据到 ajax方法
  $(".tabs li a[href='#tab2']").click ->
  #$(document).on 'click', ".tabs li a[href='#tab2']", ->
    #$("#bookmarks-list").empty()
    load_bookmark(exports.user_id)

  $(".tabs li a[href='#tab3']").click ->
    #$("#categories-list > tbody").empty()
    load_categories(exports.user_id)

  #$(".pagination a").attr("data-remote",'true')
  #$(".users .pagination a").on "click", ->
  $(document).on "click",".users .pagination a", ->
    $.getScript(this.href)
    false


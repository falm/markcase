#encoding: utf-8
module BookmarksHelper
  include ActionView::Helpers::TagHelper
  include ActionView::Helpers::FormTagHelper
  include ActionView::Context

  def builder_bookmark_list_html(bookmarks)
    bookmarks.each do |bookmark|
      content_tag :li, class: 'media bookmark-item' do
        hidden_field_tag bookmark.id   
        content_tag :div, class: 'media-body' do
          content_tag(:h4, bookmark.title, class: "media-heading" )
          link_to bookmark.link, "http://#{bookmark.link}"
          link_to "#", class: "star", title: "喜欢" do
            content_tag(:i,class: "icon-star icon-white",id: "star-icon")
          end
          link_to "#", title: "添加标签", class: "tag-button" do
            content_tag(:i,class: "icon-tags")
          end
          content_tag :ul, class: "has_tags pull-right", "data-id" => bookmark.id do
            content_tag(:li, '标签')
            bookmark.tag_list.each do |tag|
              content_tag :li  do 
                link_to tag, '/home', class: 'tag-background'
              end
            end
          end
          content_tag :ul, id: 'myTags', class: 'add-tags pull-right'  do
            bookmark.tag_list.each  do |tag|
              content_tag(:li,tag) 
            end
          end
        end
      end
    end
  end
end

# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def javascript(*files)
    content_for(:head) { javascript_include_tag(*files) }
  end

  def stylesheet(*files)
    content_for(:head) { stylesheet_link_tag(*files) }
  end


  def title
    base_title= " Book a Doc App"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{h(@title)}"
    end
 end
 def logo
     image_tag("logo.png", :alt =>"DocBook", :class => "round")
 end
 
end

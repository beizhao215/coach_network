module ApplicationHelper

# Returns the full title on a per-page basis.

   def full_title(page_title)
      base_title = "The Coach Network"
      if page_title.empty?
         base_title
      else
         "#{base_title} | #{page_title}"
      end
   end
   
   def posts_tree_for(posts)
     posts.map do |post, nested_posts|
       render(post) +
           (nested_posts.size > 0 ? content_tag(:div, posts_tree_for(nested_posts), class: "replies") : nil)
     end.join.html_safe
   end
   
 
end

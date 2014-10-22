module ApplicationHelper
  def full_title(title)
    base_title = "Twitter"
    if title
     return base_title
    else
       return "#{title} | #{base_title}"
   end
  end
end

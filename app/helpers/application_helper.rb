module ApplicationHelper
  
  def title
    base_title = "Wit CMS"
    if @title.nil?
      return base_title
    else
      "#{base_title} | #{@title}"
    end
  end
  
end

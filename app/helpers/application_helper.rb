module ApplicationHelper

  def logo
    image_tag 'logo.png', :alt => "Doomker", :class => 'round', :title => 'Doomker'
  end

  def title
    base_title = "Doomker"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end

end

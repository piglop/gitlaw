module ApplicationHelper
  def link_to_text(text, *target_and_options)
    options = target_and_options.extract_options!
    target = target_and_options[0] || text
    
    capture_haml do
      unless options[:without_user]
        user = text.user
        if user
          haml_tag("span.user", link_to(user.display_name, user))
          haml_tag("span.separator", "/")
        end
      end
      haml_tag("span.text", link_to(text.title, target, options))
    end
  end
  
  def link_to_user(user)
    if user
      link_to user.display_name, user
    end
  end
end

module ApplicationHelper
  def link_to_text(text, target = text, *options)
    user = text.user
    capture_haml do
      if user
        haml_tag("span.user", link_to(user.display_name, user))
        haml_tag("span.separator", "/")
      end
      haml_tag("span.text", link_to(text.title, target, *options))
    end
  end
end

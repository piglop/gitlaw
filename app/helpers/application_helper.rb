module ApplicationHelper
  def link_to_constitution(constitution, target = constitution, *options)
    user = constitution.user
    capture_haml do
      if user
        haml_tag("span.user", link_to(user.display_name, user))
        haml_tag("span.separator", "/")
      end
      haml_tag("span.constitution", link_to(constitution.title, target, *options))
    end
  end
end

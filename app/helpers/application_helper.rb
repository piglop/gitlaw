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
  
  def expanded_modification_path(modification)
    if modification.master?
      full_text_path(user_id: modification.user.to_param, id: modification.repository.to_param)
    else
      full_modification_path(user_id: modification.user.to_param, text_id: modification.repository.to_param, id: modification.to_param)
    end
  end
  
  def expanded_text_path(text)
    full_text_path(user_id: text.user.to_param, id: text.to_param)
  end
  
  def link_to_modification(modification)
    link_to modification.title.presence || I18n.t(:without_title), expanded_modification_path(modification)
  end
  
  def diff_lines(old, new)
    dmp = DiffMatchPatch.new
    lines = []
    Diff::LCS.sdiff(old.split(/\r\n|\r|\n/), new.split(/\r\n|\r|\n/)).each do |data|
      state, left, right = *data
      left = left[1].to_s
      right = right[1].to_s
      if state == "="
        lines << [:same, left, right]
      else
        diffs = dmp.diff_main(left, right)
        dmp.diff_cleanupSemantic(diffs)
        old_text = ""
        new_text = ""
        diffs.each do |state, text|
          case state
          when :delete
            old_text << "<strong>#{h text}</strong>"
          when :insert
            new_text << "<strong>#{h text}</strong>"
          when :equal
            old_text << "#{h text}"
            new_text << "#{h text}"
          end
        end
        lines << [:diff, old_text, new_text]
      end
    end
    lines
  end
end

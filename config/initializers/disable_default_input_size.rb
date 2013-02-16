# http://stackoverflow.com/a/9970090/188760
# Remove when commit 3384ee2 is integrated in Rails, see https://github.com/rails/rails/issues/5324
class ActionView::Helpers::InstanceTag
  silence_warnings do
    DEFAULT_FIELD_OPTIONS = {}
    DEFAULT_TEXT_AREA_OPTIONS = {}
  end
end

ActionView::Base.field_error_proc = Proc.new do |html_tag, instance_tag|
  "<span class=\"field-with-error\">#{html_tag}</span>".html_safe
end


module ApplicationHelper

  def sort_link(field, link_options={})
    sort = (session[:sort].blank? || session[:sort].match(/desc/)) ? "#{field} asc" : "#{field} desc"
    link_to field.to_s.titleize, root_path(sort: sort), link_options.merge!(remote: true)
  end

end
module ApplicationHelper
  def add_trailing_slash(path)
    if path.end_with?('/')
      path
    else
      "#{path}/"
    end
  end
end
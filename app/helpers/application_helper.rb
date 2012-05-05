module ApplicationHelper
  def add_trailing_slash(path)
    if path.end_with?('/')
      path
    else
      "#{path}/"
    end
  end

  def atom_feed_links
    notebook_links = CONFIG['header_links'].filter{ |link| link['resource']['type'] == 'notebook' }
  end
end
module ApplicationHelper
  def add_trailing_slash(path)
    if path.end_with?('/')
      path
    else
      "#{path}/"
    end
  end

  def atom_feed_links
    CONFIG['header_links'].select do |link|
      link['resource']['type'] == 'notebook'
    end.map do |link|
      auto_discovery_link_tag(:atom, File.join(link['path'], 'feed.atom'), { title: "#{CONFIG['site_name']} #{link['text']}" })
    end.join("\n")
  end
end
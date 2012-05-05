atom_feed(url: request.url) do |feed|
  feed.title("#{CONFIG['site_name']} #{@title}")
  feed.updated(DateTime.strptime((@notes.max_by{ |note| note.updated }.updated / 1000).to_s, '%s').to_time)
  feed.author do |author|
    author.name(CONFIG['site_name'])
    author.uri("http://#{request.host_with_port}")
  end
  feed.rights("Copyright (c) #{1.second.ago.year}, #{CONFIG['site_name']}")
  @notes.each do |note|
    note.id = note.url = "http://#{request.host_with_port}/#{note.created/1000}/"
    note.updated = DateTime.strptime((note.updated / 1000).to_s, '%s').to_time
    note.published = DateTime.strptime((note.created / 1000).to_s, '%s').to_time
    feed.entry(note, note) do |entry|
      entry.title(note['title'])
      entry.content(note.snippet, type: 'text')
      entry.author do |author|
        author.name(CONFIG['site_name'])
        author.uri("http://#{request.host_with_port}")
      end
    end
  end
end
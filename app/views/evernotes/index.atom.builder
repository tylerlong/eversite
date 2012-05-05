atom_feed(url: request.url, id: request.url, author: CONFIG['site_name']) do |feed|
  feed.title("#{CONFIG['site_name']} #{@title}")
  feed.updated(DateTime.strptime((@notes.first[:created] / 1000).to_s, '%s').to_time)
  @notes.each do |note|
    note.id = note.created/1000
    note.url = "http://#{request.host_with_port}/#{note.id}/"
    note.author = CONFIG['site_name']
    feed.entry(note, note) do |entry|
      entry.title(note['title'])
      entry.content(note.snippet, type: 'text')
    end
  end
end
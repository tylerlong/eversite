atom_feed(url: request.url) do |feed|
  feed.title("#{CONFIG['site_name']} #{@title}")
  feed.updated(DateTime.strptime((@notes.first[:created] / 1000).to_s, '%s').to_time)
  @notes.each do |note|
    feed.entry(note) do |entry|
      entry.title(note['title'])
      entry.content(note['content'], type: 'html')
    end
  end
end
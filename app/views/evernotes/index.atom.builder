atom_feed(:url => request.url) do |feed|
  feed.title(@title)
  feed.updated(Time.now.utc)
end
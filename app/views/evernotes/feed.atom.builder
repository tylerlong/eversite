atom_feed(:url => request.url) do |feed|
  feed.title("Address book")
  feed.updated(Time.now.utc)
end
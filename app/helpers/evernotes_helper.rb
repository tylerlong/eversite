module EvernotesHelper
  def format_timestamp(timestamp)
    dt = DateTime.strptime((timestamp / 1000).to_s, '%s')
    dt = (dt.to_time + CONFIG['time_zone'].hours).to_datetime
    dt.strftime('%Y-%m-%d<br/>%H:%M:%S').html_safe
  end
end
module ApplicationHelper
  def fix_url(url)
    url.starts_with?('http://') ? url : "http://#{url}"
  end

  def format_time(time)  # 2014-05-08 06:52:32 => 05/08/2014 6:52am UTC
    time.strftime("%m/%d/%Y %l:%M%P %Z")          
  end
end

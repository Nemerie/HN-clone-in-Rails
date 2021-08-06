module ApplicationHelper
  def host_of_url(url)
    host = URI(url).host
    if host.start_with?("www.")
      host[4..-1]
    else
      host
    end
  end
end

# Shows new articles from current build with comparing
# RSS feed from the current build and
# public RSS feed from the previous build.
#
# supply `--read URL` command line option to show paths for itmes
# rather than showing new articles.
#
require "rss"
require "uri"

feed_path = "/feed-articles.xml"
default_base_url = "https://magazine.rubyist.net"
default_latest_rss = "./_site" + feed_path
default_public_rss = default_base_url + feed_path

def paths_in_feed(rss)
  RSS::Parser.parse(rss, validate: false).items.map { |item|
    url = item.respond_to?(:link) ? item.link : item
    url = url.respond_to?(:href) ? url.href : url
    # Ignore hostname when finding new articles to allow `jekyll serve`
    URI.parse(url).path
  }
end

def new_paths(current_rss, previous_rss)
  paths_in_feed(current_rss) - paths_in_feed(previous_rss)
end

def show_new_pages(current_rss, previous_rss, base_url)
  begin
    x = new_paths(current_rss, previous_rss)
    if x.empty?
      puts "No new pages."
    else
      puts "New pages:\n#{x.map { |path| base_url + path}.join("\n") }"
    end
  rescue => e
    # Exit successfully and let build continue even failed checking new pages
    puts "#{e.message}\n\tfrom #{e.backtrace.last}"
  end
end

require "optparse"
base_url = default_base_url
latest_rss = default_latest_rss
public_rss = default_public_rss
opt = OptionParser.new
opt.on("-r", "--read URL", "show paths for items in RSS from URL/path") do |x|
  puts paths_in_feed(x).join("\n")
  exit
end
opt.on("-p", "--public URL", "use URL for public RSS [#{public_rss}]") do |x|
  public_rss = x
end
opt.on("-l", "--latest URL", "use URL for latest RSS [#{latest_rss}]") do |x|
  latest_rss = x
end
opt.on("-b", "--base URL", "set base URL [#{base_url}]") do |x|
  base_url = x
end
opt.parse!(ARGV)

show_new_pages(latest_rss, public_rss, base_url)

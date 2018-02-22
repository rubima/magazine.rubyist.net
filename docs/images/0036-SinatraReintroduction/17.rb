  # encoding: utf-8
  require 'kconv'
  require 'open-uri'
  require 'rack'
  require 'zalgo'

  class Rack::Glitch
    def initialize(app)
      @app = app
    end

    def call(env)
      orig_res = @app.call(env)
      res = Rack::Response.new orig_res[2]
      res.body = res.body.map do |txt|
        txt.gsub!(/EUC-JP/i, "UTF-8")
        txt.gsub!(/Ruby(?:ist)?/i){|matched| Zalgo.he_comes(matched, :size => :mini)}
        txt.gsub!(/<head.*>/, %q{<head><base href="http://jp.rubyist.net/magazine/?0035-ForeWord" />})
      end
      res["Content-Length"] = res.body.map(&:bytesize).inject(:+).to_s
      res.finish
    end
  end

  target = "http://jp.rubyist.net/magazine/?0035-ForeWord"

  use Rack::Lint
  use Rack::Glitch
  run lambda {|env|
    [200, {"Content-Type" => "text/html"}, [open(target).read.toutf8]]
  }

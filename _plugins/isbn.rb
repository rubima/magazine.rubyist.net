require 'net/http'
require 'uri'
require 'timeout'
require 'rexml/document'

module Jekyll

  AMAZON_ECS_URL='http://rpaproxy.tdiary.org/rpaproxy/jp/'
  SUBSCRIPTION_ID='1CVA98NEF1G753PFESR2'
  API_VERSION='2007-01-17'

  # def isbn_convert(org_isbn)
  #   return org_isbn if org_isbn.length == 13
  #
  #   isbn = "978" + org_isbn.gsub(/\d$/,'')
  #   r = isbn.split(//).map(&:to_i).zip([1,3].cycle).map{|e|
  #     e[0] * e[1]
  #   }.reduce(:+) % 10
  #   isbn + ((10 - r) % 10).to_s
  # end

  def amazon_fetch(url:, limit: 10)
    raise ArgumentError, 'HTTP redirect too deep' if limit == 0

    res = Net::HTTP.get_response(URI::parse(url))
    case res
    when Net::HTTPSuccess
      res.body
    when Net::HTTPRedirection
      Jekyll.amazon_fetch(url: res['location'].untaint, limit: limit - 1)
    when Net::HTTPServiceUnavailable
      sleep(2)
      Jekyll.amazon_fetch(url: url, limit: limit - 1)
    else
      raise ArgumentError, res.error!
    end
  end

  def amazon_call(asin:, id_type:)
    if File.exist?("data/amazon/#{asin}.xml")
      return File.open("data/amazon/#{asin}.xml").read
    end
    aid = 'cshs-22'

    url = "#{AMAZON_ECS_URL}?Service=AWSECommerceService"
    url << "&SubscriptionId=#{SUBSCRIPTION_ID}"
    url << "&AssociateTag=#{aid}"
    url << "&Operation=ItemLookup"
    url << "&ItemId=#{asin}"
    url << "&IdType=#{id_type}"
    url << "&SearchIndex=Books" if id_type == 'ISBN'
    url << "&ResponseGroup=Medium"
    # url << "&Version=#{API_VERSION}"
    begin
      Timeout.timeout(100) do
        xml = Jekyll.amazon_fetch(url: url)
        File.open("data/amazon/#{asin}.xml", 'w') { |f| f.write(xml) }
        xml
      end
    rescue ArgumentError
    end
  end

  def book_link(isbn, text)
    xml = Jekyll.amazon_call(asin: isbn, id_type: 'ISBN')
    doc = REXML::Document.new(xml)
    url = doc.elements['ItemLookupResponse/Items/Item/DetailPageURL']
    if url.nil?
      "#{text}"
    else
      "<a href='#{url.text}'>#{text}</a>"
    end
  end

  def image_link(isbn, klass)
    xml = amazon_call(asin: isbn, id_type: 'ISBN')
    doc = REXML::Document.new(xml)
    url = doc.elements['ItemLookupResponse/Items/Item/MediumImage/URL']
    if url.nil?
      "Image not found. ISBN = #{isbn}"
    else
      "<img class='#{klass}' src='#{url.text}'>"
    end
  end

  def method_args(arg_str)
    arg_str.scan(/['"](?:[^'\"])*['"]/)
  end

  module_function :book_link, :image_link, :method_args, :amazon_call, :amazon_fetch

  class RenderIsbnImageRightTag < Liquid::Tag
    def initialize(tag_name, tag_arg, tokens)
      super
      @isbn = Jekyll.method_args(tag_arg)[0].gsub(/'/, '').gsub(/\"/, '')
    end

    def render(context)
      Jekyll.image_link(@isbn, 'right')
    end
  end

  class RenderIsbnImageLeftTag < Liquid::Tag
    def initialize(tag_name, tag_arg, tokens)
      super
      @isbn = Jekyll.method_args(tag_arg)[0].gsub(/'/, '').gsub(/\"/, '')
    end

    def render(context)
      Jekyll.image_link(@isbn, 'left')
    end
  end

  class RenderIsbnImageTag < Liquid::Tag
    def initialize(tag_name, tag_arg, tokens)
      super
      @isbn = Jekyll.method_args(tag_arg)[0].gsub(/'/, '').gsub(/\"/, '')
    end

    def render(context)
      Jekyll.image_link(@isbn, '')
    end
  end

  class RenderIsbnTag < Liquid::Tag
    def initialize(tag_name, tag_arg, tokens)
      super
      args = Jekyll.method_args(tag_arg)
      @isbn = args[0].gsub(/'/, '').gsub(/\"/, '')
      @text = args[1]
    end

    def render(context)
      Jekyll.book_link(@isbn, @text)
    end
  end
end

Liquid::Template.register_tag('isbn_image_right', Jekyll::RenderIsbnImageRightTag)
Liquid::Template.register_tag('isbn_image_left', Jekyll::RenderIsbnImageLeftTag)
Liquid::Template.register_tag('isbn_image', Jekyll::RenderIsbnImageTag)
Liquid::Template.register_tag('isbn', Jekyll::RenderIsbnTag)

require 'erb'
require 'pathname'

class Article
  attr_reader :path

  def initialize(file_path)
    @file_path = file_path
    pn = Pathname.new(@file_path.gsub('_posts', ''))
    @path = (pn.dirname + pn.basename('.md')).to_s
    @meta_data = fetch_meta_data!
  end

  def title
    @meta_data['title']
  end

  def author
    @meta_data['post_author']
  end

  private

  def fetch_meta_data!
    meta_data = File.readlines(@file_path).slice_after { |l| l.chomp == '---' }.to_a[1][0..-2]
    meta_data.map! { |m| m.chomp.split(': ') }.to_h
  end
end


release_no = ARGV[0]
release_date = ARGV[1]
release_dir = "articles/#{release_no}/_posts"
files = Dir.glob("#{release_dir}/*.md")
forword_regexp = /ForeWord$/
foreword, articles = files.map { |f| Article.new(f) }.partition { |a| forword_regexp.match? a.path }

index_template_path = "#{__dir__}/template/index.md.erb"

variables = {
  release_no: release_no,
  release_month: release_date.split('-')[0..1].join('-'),
  foreword: foreword[0],
  articles: articles
}
index_content = ERB.new(File.read(index_template_path)).result_with_hash(variables)
File.write("#{release_dir}/#{release_date}-index.md", index_content)

editors_note_template_path = "#{__dir__}/template/EditorsNote.md.erb"
editors_note_content = ERB.new(File.read(editors_note_template_path)).result_with_hash(release_no: release_no)
File.write("#{release_dir}/#{release_date}-EditorsNote.md", editors_note_content)

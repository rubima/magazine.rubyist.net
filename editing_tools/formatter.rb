require 'tempfile'
require 'pathname'
require 'fileutils'
require 'readline'
require_relative 'rubima-lint'

class RubimaFomatter
  class BaseFormatter
    include RubimaLint::Rules
    
    def initialize(line_no, line)
      @line_no = line_no
      @line = line
    end

    def apply
      pre_checked_line = pre_check
      return @line if @line == pre_checked_line

      puts "#{formatted_message}: line [#{@line_no}]:"
      puts pre_checked_line

      loop do
        y_or_n = Readline.readline("appry? [y(es)<default>|n(o)|e(dit)|i(gnore)]> ")
        case y_or_n.chomp
        when ?y, 'yes', ''
          return convert_line
        when ?n, 'no'
          return @line
        when ?e, 'edit'
          return edit_line
        end
      end
    end

    def edit_line
      editor = ENV['EDITOR'] || 'vim'
      tempfile = Tempfile.open { |fp| fp.print @line; fp }
      system [editor, tempfile.path].join(' ')
      File.read(tempfile.path)
    end
  end

  class WhiteSpaceFormatter < BaseFormatter
    def formatted_message
      "半角文字列の前後に空白を挿入しました"
    end

    def pre_check
      convert_line("\e[7m \e[m")
    end

    def convert_line(blank = ' ')
      @line.gsub(MISSING_BLANK, blank)
    end
  end

  class TrimUnnecessarySpaceFormatter < BaseFormatter
    def formatted_message
      "不要な空白を削除しました"
    end

    def pre_check
      convert_line("\e[32m#{$&}\e[m")
    end

    def convert_line(trimmed = '')
      @line.gsub(INVALID_BLANK, trimmed)
    end
  end

  def initialize(src_file_path)
    @src_file_path = Pathname.new(src_file_path)
    @file_name = @src_file_path.basename
    @dir_name = @src_file_path.dirname
  end

  def run!
    formatted_file = execute_format!

    backup_path = @dir_name + (@file_name.to_s + '.bak')
    FileUtils.mv @src_file_path, backup_path
    FileUtils.copy_file formatted_file.path, @src_file_path
  end

  def execute_format!
    Tempfile.open(@file_name.to_s) do |fp|
      @src_file_path.each_line.with_index(1) do |line, no|
        fp.print apply_format(no, line)
      end
      fp
    end
  end

  def apply_format(no, line)
    [WhiteSpaceFormatter, TrimUnnecessarySpaceFormatter].inject(line) do |l, fc|
      fc.new(no, l).apply
    end
  end
end

RubimaFomatter.new(ARGV[0]).run!

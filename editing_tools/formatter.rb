require 'tempfile'
require 'pathname'
require 'fileutils'
require 'readline'

class RubimaFormatter
  def initialize(src_file_path, lint_rules)
    @src_file_path = Pathname.new(src_file_path)
    @file_name = @src_file_path.basename
    @dir_name = @src_file_path.dirname
    @lint_rules = lint_rules
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

  def apply_format(line_no, line)
    @lint_rules.inject(line) do |current_line, rule|
      next current_line unless rule.correctable
      next current_line unless rule.check(current_line)

      corrected_line = rule.correct(current_line)

      puts "#{rule.warning_description}(L#{line_no}):"
      puts "Before: #{current_line.chomp}"
      puts "After:  #{corrected_line.chomp}"

      loop do
        y_or_n = Readline.readline('apply? [y(es)<default>|n(o)|e(dit)|i(gnore)]> ')
        case y_or_n.chomp
        when 'y', 'yes', ''
          break corrected_line
        when 'n', 'no'
          break current_line
        when 'e', 'edit'
          break edit_line(current_line)
        when 'i', 'ignore'
          break current_line
        end
      end
    end
  end

  def edit_line(line)
    editor = ENV['EDITOR'] || 'vim'
    tempfile = Tempfile.open do |fp|
      fp.print line
      fp
    end
    system "#{editor} #{tempfile.path}"
    File.read(tempfile.path)
  end
end

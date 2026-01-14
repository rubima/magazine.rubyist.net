#!/usr/bin/env ruby

require 'optparse'

class RubimaLint
  module Patterns
    NOT_ASCII  = '[^[:ascii:]]' # 非ASCII
    ASCII_CHAR = '[\w&&[:ascii:]]' # ASCII
    OPEN_PARENTHESES  = '[(]' # 開き丸括弧
    CLOSE_PARENTHESES = '[)]' # 閉じ丸括弧
    QUESTION_EXCLAMATION = '[？！]' # 疑問符・感嘆符
    PUNCTUATION = "[、。#{QUESTION_EXCLAMATION}]" # 句読点
    OPEN_BRACKETS  = '[「『]' # 開き括弧類
    CLOSE_BRACKETS = '[』」]' # 閉じ括弧類
    THREE_POINT_LEADER = '[…]' # 三点リーダー
    OTHER_OK_LETTER = "[#{THREE_POINT_LEADER}〜：　]" # その他OKな文字
    OK_BEFORE_ASCII = "[#{PUNCTUATION}#{OPEN_BRACKETS}#{OTHER_OK_LETTER}]" # ASCII直前のOKな文字
    OK_AFTER_ASCII = "[#{PUNCTUATION}#{CLOSE_BRACKETS}#{OTHER_OK_LETTER}]" # ASCII直後のOKな文字
    HEAD_CHAR = "'''　" # 発言頭

    ASCII_AFTER_NOT_ASCII = /(?<=#{NOT_ASCII})(?=#{ASCII_CHAR})(?<!#{OK_BEFORE_ASCII})(?<!#{HEAD_CHAR})/o # 非ASCIIの直後にASCII
    NOT_ASCII_AFTER_ASCII = /(?<=#{ASCII_CHAR})(?=#{NOT_ASCII})(?!#{OK_AFTER_ASCII})/o # ASCIIの直後に非ASCII
    MISSING_BLANK = /#{ASCII_AFTER_NOT_ASCII}|#{NOT_ASCII_AFTER_ASCII}/o # 空白抜け

    # 円括弧前後OK文字
    OK_AROUND_PARENTHESES = "[ [[:ascii:]&&[:graph:]]#{PUNCTUATION}#{OPEN_BRACKETS}#{CLOSE_BRACKETS}#{THREE_POINT_LEADER}]"

    # 不要な空白
    CHAR_AROUND_NOT_PERMIT_BLANK = "[#{PUNCTUATION}#{OPEN_BRACKETS}#{CLOSE_BRACKETS}]"
    # 編集指針に反する空白パターン
    INVALID_BLANK_PARTS = [
      /#{THREE_POINT_LEADER} #{OPEN_PARENTHESES}/o,
      /#{CHAR_AROUND_NOT_PERMIT_BLANK} #{OPEN_PARENTHESES}/o,
      /#{CLOSE_PARENTHESES} #{CHAR_AROUND_NOT_PERMIT_BLANK}/o
    ]
    INVALID_BLANK = Regexp.union(*INVALID_BLANK_PARTS)

    FULL_WIDTH_PARENTHESES = /[（）]/o # 全角括弧
    TODO_PATTERN = /TODO/ # TODO
    TOC_PATTERN = /\{\{toc\}\}/ # {{toc}}
    LINK_PATTERN = /(?<left>\[\[(.*?\|)?)(?<link>.*)(?<right>\]\])/ # [[リンク]]
    FOOTNOTE_PATTERN = /\{\{fn/ # {{fn
    HRULE_PATTERN = /^----$/ # ----
    NON_WHITESPACE = /\S/ # 空白以外
  end

  class Rule
    attr_reader :name, :correctable

    def initialize(name, correctable:, color_code: 31)
      @name = name
      @correctable = correctable
      @color_code = color_code
    end

    def check(line)
      raise NotImplementedError, "#{self.class}#check must be implemented in subclasses"
    end

    def correct(line)
      raise NotImplementedError, "#{self.class}#correct must be implemented for correctable rules"
    end

    def highlight(line)
      line
    end

    def warning_description
      raise NotImplementedError, "#{self.class}#warning_description must be implemented in subclasses"
    end

    def warning_message(lineno, line)
      prefix = @correctable ? '[Correctable]' : '[Uncorrectable]'
      highlighted = highlight(line)
      "#{prefix} #{warning_description} : #{lineno}行目 : #{highlighted.chomp}"
    end
  end

  class LineRule < Rule
    def initialize(name, pattern, correctable:, color_code: 31)
      super(name, correctable: correctable, color_code: color_code)
      @pattern = pattern
    end

    def check(line)
      line.match?(@pattern)
    end

    def highlight(line)
      line.gsub(@pattern) { "\e[#{@color_code}m#{::Regexp.last_match(0)}\e[m" }
    end
  end

  class FileRule < Rule
    def initialize(name)
      super(name, correctable: false, color_code: 7)
    end

    def track(line)
      raise NotImplementedError, "#{self.class}#track must be implemented in subclasses"
    end

    def check
      raise NotImplementedError, "#{self.class}#check must be implemented in subclasses"
    end

    def warning_message
      "[Uncorrectable] \e[7m#{warning_description}\e[m"
    end
  end

  class MissingBlankRule < LineRule
    def initialize
      super('missing_blank', Patterns::MISSING_BLANK, correctable: true, color_code: 7)
    end

    def correct(line)
      line.gsub(@pattern, ' ')
    end

    def warning_description
      '半角英数字の前後には空白が必要です。'
    end
  end

  class FullWidthParenthesesRule < LineRule
    def initialize
      super('full_width_parentheses', Patterns::FULL_WIDTH_PARENTHESES, correctable: true, color_code: 31)
    end

    def correct(line)
      line.gsub(/[（）]/, '（' => '(', '）' => ')')
    end

    def warning_description
      '全角括弧が使用されています。'
    end
  end

  class InvalidOpenParenthesesRule < LineRule
    def initialize
      pattern = /(?<!^)(?<!#{Patterns::HEAD_CHAR})(?<!#{Patterns::OK_AROUND_PARENTHESES})#{Patterns::OPEN_PARENTHESES}/o
      super('invalid_open_parentheses', pattern, correctable: true, color_code: 31)
    end

    def correct(line)
      line.gsub(@pattern) { " #{::Regexp.last_match(0)}" }
    end

    def warning_description
      '開き括弧の前に空白が必要です。'
    end
  end

  class InvalidCloseParenthesesRule < LineRule
    def initialize
      pattern = /#{Patterns::CLOSE_PARENTHESES}(?!#{Patterns::OK_AROUND_PARENTHESES})(?!$)/o
      super('invalid_close_parentheses', pattern, correctable: true, color_code: 31)
    end

    def correct(line)
      line.gsub(@pattern) { "#{::Regexp.last_match(0)} " }
    end

    def warning_description
      '閉じ括弧の後に空白が必要です。'
    end
  end

  class PeriodAroundParenthesesRule < LineRule
    def initialize
      pattern = /。#{Patterns::CLOSE_PARENTHESES}。/o
      super('period_around_parentheses', pattern, correctable: false, color_code: 31)
    end

    def warning_description
      '丸括弧の前後に句点があります。どちらか一方を削除してください。'
    end
  end

  class LaughterPeriodRule < LineRule
    def initialize
      pattern = /笑#{Patterns::CLOSE_PARENTHESES}。$/o
      super('laughter_period', pattern, correctable: true, color_code: 31)
    end

    def correct(line)
      line.gsub(@pattern) { "笑#{::Regexp.last_match(0)[1]}" }
    end

    def warning_description
      '括弧笑の後ろに句点は不要です。'
    end
  end

  class SingleThreePointLeaderRule < LineRule
    def initialize
      pattern = /(?<!#{Patterns::THREE_POINT_LEADER})#{Patterns::THREE_POINT_LEADER}(?!#{Patterns::THREE_POINT_LEADER})/o
      super('single_three_point_leader', pattern, correctable: true, color_code: 31)
    end

    def correct(line)
      line.gsub(@pattern, '……')
    end

    def warning_description
      '三点リーダーは2つ連続で使用してください。'
    end
  end

  class ThreePointLeaderAtEndRule < LineRule
    def initialize
      pattern = /#{Patterns::THREE_POINT_LEADER}$/o
      super('three_point_leader_at_end', pattern, correctable: false, color_code: 31)
    end

    def warning_description
      '文末に三点リーダーがあります。適切な句読点で終えてください。'
    end
  end

  class QuestionExclamationInParagraphRule < LineRule
    def initialize
      pattern = /#{Patterns::QUESTION_EXCLAMATION}(?!$)(?!\])(?![　#{Patterns::QUESTION_EXCLAMATION}#{Patterns::CLOSE_BRACKETS}])/o
      super('question_exclamation_in_paragraph', pattern, correctable: true, color_code: 31)
    end

    def correct(line)
      line.gsub(@pattern) { "#{::Regexp.last_match(0)}　" }
    end

    def warning_description
      '疑問符・感嘆符の後には全角空白が必要です。'
    end
  end

  class InvalidBlankRule < LineRule
    def initialize
      super('invalid_blank', Patterns::INVALID_BLANK, correctable: true, color_code: 32)
    end

    def correct(line)
      line.gsub(@pattern) { |match| match.delete(' ') }
    end

    def warning_description
      '不要な空白が含まれています。'
    end
  end

  class TodoRule < LineRule
    def initialize
      super('todo', Patterns::TODO_PATTERN, correctable: false, color_code: 33)
    end

    def warning_description
      'TODOが含まれています。'
    end
  end

  class TocRule < LineRule
    def initialize
      super('toc', Patterns::TOC_PATTERN, correctable: true, color_code: 35)
    end

    def correct(line)
      line.gsub(@pattern, '{{toc_here}}')
    end

    def warning_description
      '{{toc}}ではなく、{{toc_here}}を使ってください。'
    end
  end

  class LinkRule < LineRule
    def initialize
      super('link', Patterns::LINK_PATTERN, correctable: false, color_code: 34)
    end

    def check(line)
      return false unless line.match?(@pattern)

      m = line.match(@pattern)
      m[:link] !~ %r{\Ahttps?://} && m[:link] =~ /[^0-9A-Za-z\-_]/
    end

    def warning_description
      'リンクの設定漏れと思われる部分があります。'
    end

    def warning_message(lineno, line)
      m = line.match(@pattern)
      highlighted = "#{m[:left]}\e[#{@color_code}m#{m[:link]}\e[m#{m[:right]}"
      "[Uncorrectable] #{warning_description} : #{lineno}行目 : #{line.chomp.gsub(m[0], highlighted)}"
    end
  end

  class FootnoteConsistencyRule < FileRule
    def initialize
      super('footnote_consistency')
      @has_footnote = false
      @has_last_hrule = false
    end

    def track(line)
      @has_footnote = true if line.match?(Patterns::FOOTNOTE_PATTERN)

      if line.match?(Patterns::HRULE_PATTERN)
        @has_last_hrule = true
      elsif line.match?(Patterns::NON_WHITESPACE)
        @has_last_hrule = false
      end
    end

    def check
      @has_footnote && !@has_last_hrule || !@has_footnote && @has_last_hrule
    end

    def warning_description
      if @has_footnote && !@has_last_hrule
        '脚注があるのに末尾に「----」がありません。'
      else
        '脚注がないのに末尾に「----」があります。'
      end
    end
  end

  attr_reader :warning_count, :line_rules

  def initialize(file_io, autocorrect: false)
    @file_io = file_io
    @autocorrect = autocorrect
    @warning_count = 0
    @warning_messages = []
    @line_rules = build_line_rules
    @file_rules = build_file_rules
  end

  def run!
    if @autocorrect
      run_with_formatter!
    else
      run_check_only!
    end
  end

  def run_check_only!
    @file_io.each_line do |line|
      lineno = @file_io.lineno
      check_line(lineno, line)
      track_file_rules(line)
    end

    check_file_rules
    nil
  end

  def run_with_formatter!
    require_relative 'formatter'

    file_path = @file_io.path
    formatter = RubimaFormatter.new(file_path, @line_rules)
    formatter.run!

    File.open(file_path, 'r') do |f|
      f.each_line do |line|
        lineno = f.lineno
        check_line(lineno, line)
        track_file_rules(line)
      end
    end

    check_file_rules
  end

  def print_messages(io = $stdout)
    return if @warning_count.zero?

    io.puts "#{@warning_count} warning(s)"
    @warning_messages.each { |msg| io.puts msg }
  end

  private

  def build_line_rules
    [
      MissingBlankRule.new,
      InvalidBlankRule.new,
      TocRule.new,
      FullWidthParenthesesRule.new,
      InvalidOpenParenthesesRule.new,
      InvalidCloseParenthesesRule.new,
      PeriodAroundParenthesesRule.new,
      LaughterPeriodRule.new,
      SingleThreePointLeaderRule.new,
      ThreePointLeaderAtEndRule.new,
      QuestionExclamationInParagraphRule.new,
      TodoRule.new,
      LinkRule.new
    ]
  end

  def build_file_rules
    [
      FootnoteConsistencyRule.new
    ]
  end

  def check_line(lineno, line)
    @line_rules.each do |rule|
      next unless rule.check(line)

      add_message(rule.warning_message(lineno, line))
      break if rule.is_a?(FullWidthParenthesesRule)
    end
  end

  def track_file_rules(line)
    @file_rules.each { |rule| rule.track(line) }
  end

  def check_file_rules
    @file_rules.each do |rule|
      next unless rule.check

      add_message(rule.warning_message)
    end
  end

  def add_message(msg)
    @warning_messages << msg
    @warning_count += 1
  end
end

if $0 == __FILE__
  options = { autocorrect: false }
  OptionParser.new do |opts|
    opts.banner = "Usage: #{$0} [-a] [file...]"
    opts.on('-a', '--autocorrect', 'Enable auto-correction') do
      options[:autocorrect] = true
    end
  end.parse!

  checker = RubimaLint.new(ARGF, autocorrect: options[:autocorrect])
  checker.run!

  checker.print_messages(options[:autocorrect] ? $stderr : $stdout)

  exit(checker.warning_count > 0 ? 1 : 0)
end

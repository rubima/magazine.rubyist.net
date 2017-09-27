class Time
  def succ_with_warning(*args)
    $stderr.puts "[WARN] Time#succ is obsolete; use time + 1 at #{caller[0]}"
    succ_without_warning(*args)
  end
  alias succ_without_warning succ
  alias succ succ_with_warning
end

class Range
  def include_with_warn?(obj)
    if Time === self.begin
      caller.tap do |callstack|
        repository_root = File.expand_path('../../../../../../../', __FILE__) + '/'
        offending_line = callstack.find {|line|
          File.expand_path(line.split(':').first).start_with?(repository_root)
        } || callstack.first
        $stderr.puts "[WARN] can't iterate from Time since 1.9 at #{offending_line}"
      end
    end
    include_without_warn?(obj)
  end
  alias include_without_warn? include?
  alias include? include_with_warn?
end

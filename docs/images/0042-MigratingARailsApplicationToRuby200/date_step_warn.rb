require 'date'

class Date
  def step_with_warn(*args)
    unless Numeric === args[1] || args[1].nil?
      $stderr.puts "[WARN] non-Numeric object is given for the 2nd argument of step at #{caller[0]}"
    end
    step_without_warn(*args, &block)
  end
  alias step_without_warn step
  alias step step_with_warn
end

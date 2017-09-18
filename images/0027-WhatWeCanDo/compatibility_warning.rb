def add_warning(method)
  owner = method.owner
  name = method.name
  orig_name = "orig_#{name}"
  str = <<-SRC
    #{owner.class.to_s.downcase} #{owner}
      alias :#{orig_name} :#{name}
      def #{name}(*args)
        log_warning "#{method.receiver.class}##{name}"
        #{orig_name}(*args)
      end
    end
    SRC
  eval str
end

$log_warning_hash = {}

def log_warning(method_name)
  log_msg = %Q!(compatibility warning) #{method_name} used in #{caller[1]} !
  return if $log_warning_hash.has_key?(log_msg)
  $log_warning_hash[log_msg] = true
  $stderr.puts log_msg
end

# String#size has a different behaviour on Ruby-1.9
add_warning "".method(:size)

# String#length has a different behaviour on Ruby-1.9
add_warning "".method(:length)

# String#slice has a different behaviour on Ruby-1.9
add_warning "".method(:slice)

# String#slice! has a different behaviour on Ruby-1.9
add_warning "".method(:slice!)

# Array#to_s has a different behaviour on Ruby-1.9
add_warning [].method(:to_s)

# String#to_a is not defined on Ruby-1.9
add_warning "".method(:to_a) rescue nil

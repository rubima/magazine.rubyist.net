if Rails.application.config.whiny_nils
  require 'active_support/whiny_nil'
end

if RUBY_VERSION < '1.9'
  class NilClass
    def id_with_warn(*args)
      return 4 unless File.expand_path(caller[0]).starts_with?(Rails.root)
      message = "nil.id was called at #{caller[0]}"
      if defined? Logger
        Logger.error.post('nil.id', message)
      else
        $stderr.puts message
      end
      4
    end

    alias id_without_warn id
    alias id id_with_warn
  end
end

module RI2Reference
  
  class MethodPage < CGIKit::Component
    
    attr_reader :entry, :full_name
    
    def setup(entry)
      @full_name = entry.full_name
      @entry = entry
    end
    
    
    
    def parameter
      s = @entry.params
      if /^\s*\(/ =~ s
        s = @full_name + s.strip
      end
      s
    end
    
    def method_comment
      s = ''      
      if @entry.comment
        s = RI2Reference::Utils.struct2html(@entry)
      end
      s
    end
    
    def aliases
      s = ''
      @entry.aliases.each do |i|
        s << i.name
      end
      s
    end
    
  end
  
end
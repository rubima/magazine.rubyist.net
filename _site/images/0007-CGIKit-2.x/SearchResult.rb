module RI2Reference

  class SearchResult < CGIKit::Component
    
    attr_accessor :class_list, :method_list, :i
    
    def query
      {'n' => CGIKit::Utilities.escape_url(@i)}
    end
    
  end
  
end

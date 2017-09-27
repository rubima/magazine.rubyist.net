module RI2Reference
  
  class ClassListPage < CGIKit::Component
  
    attr_accessor :i, :list
    
    def query
      {'n' => CGIKit::Utilities.escape_url(@i) }
    end
  
  end
  
end

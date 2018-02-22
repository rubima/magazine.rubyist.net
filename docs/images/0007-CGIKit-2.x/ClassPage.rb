module RI2Reference
  
  class ClassPage < CGIKit::Component
  
    attr_accessor :full_name, :i, :mod, :con
    attr_reader :superclasses, :constants, :included_modules, :class_methods, :instance_methods, :attributes
    
    def setup(entry)
      @full_name = entry.full_name
      @entry = entry
      util = RI2Reference::Utils
      
      cur = @entry
      @superclasses = []      
      while (cur and cur.superclass)
        @superclasses << cur.superclass
        cur = util.get_class_entry(cur.superclass)
      end
      @superclasses = @superclasses.reverse
      
      @included_modules = @entry.includes.collect{|inc| inc.name}
      
      @constants = []
      unless @entry.constants.empty?
        @entry.constants.each do |c|
          a = []
          a << c.name
          if c.comment
            a << c.comment
          else
            a << []
          end
          a << c.value
          @constants << a 
        end
        @constants = @constants.sort{|i,j| i[0] <=> j[0]}
      end
      
      @class_methods = @entry.class_methods.collect{|m| m.name}.sort    
      @instance_methods = @entry.instance_methods.collect{|m| m.name}.sort
      @attributes = @entry.attributes.collect{|a| a.name}.sort
    end
    
    
    
    def class_page?
      (not(@superclasses.empty?) or @full_name == 'Object')
    end
    
    def class_comment
      s = ''
      
      if @entry.comment
        s = RI2Reference::Utils.struct2html(@entry)
      end      

      s
    end
    
    def module_query
      {'n' => CGIKit::Utilities.escape_url(@mod) }
    end
    
    def module_name
      @mod
    end
    
    def constant_name
      @con[0]
    end
    
    
    
    def method_name
      @i
    end
    
    def method_query
      {'n' => CGIKit::Utilities.escape_url(@full_name + '#' + @i) }
    end
    
    def class_method_query
      {'n' => CGIKit::Utilities.escape_url(@full_name + '::' + @i) }
    end
    
  end

end
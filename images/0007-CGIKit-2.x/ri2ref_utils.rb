require 'rdoc/ri/ri_driver'

module RI2Reference
  
  module Utils
    
    def self.refresh_ridata(paths = nil)
      paths = paths || RI::Paths::PATH
      
      old = Thread.critical
      begin
        Thread.critical= true
        @@cache = RI::RiCache.new(paths)
        @@reader = RI::RiReader.new(@@cache)
      ensure
        Thread.critical = old
      end
    end
    
    def self.cache_expired?
      false
    end
        
    def self.get_class_entry(full_name, plural = false)
      r = @@reader
      if plural
        arr = self.get_all_class_names.select{|i| i.index(full_name) }
        arr.collect{|i| self.get_class(i)}
      else
        r.find_class_by_name(full_name)
      end
    end
    
    # method_name must be fullname
    def self.get_method_entry(full_name, plural = false)
      r = @@reader
      namespaces = nil
      
      # copied from ri_driver.rb      
      desc = NameDescriptor.new(full_name)
      namespaces = r.top_level_namespace
      for class_name in desc.class_names
        namespaces = r.lookup_namespace_in(class_name, namespaces)
        if namespaces.empty?
          return nil
        end
      end
      full_class_name = desc.full_class_name
      entries = namespaces.find_all {|m| m.full_name == full_class_name}
      if entries.size == 1
        namespaces = entries 
      else
        return nil
      end      
      methods = r.find_methods(desc.method_name, desc.is_class_method, namespaces)
      
      
      if plural
        return methods.collect{|i| r.get_method(i)}
      else
        # Array#reverse matches Array#reverse, Array#reverse!, Array#reverse_each 
        # Here, choose the item whose name is the same as `full_name`.        
        full_method_name = full_name
        methods = methods.find_all{|m| m.full_name == full_method_name}        
        
        if methods.size == 1
          return r.get_method(methods[0])
        else          
          return nil
        end
      end
    end
    
    def self.get_all_class_names
      r = @@reader
      r.full_class_names
    end
    
    def self.get_all_names
      r = @@reader
      r.all_names
    end
    
    def self.search_name(str)
      self.get_all_names.select{|i| i.index(str) }
    end
    
    
        
    def self.struct2html(entry)
      s = ''
      if entry.comment
        self.__struct2html(entry.comment, s)
      end
      s.gsub("\n", "\r\n")
    end
    
    def self.__struct2html(arr, s)
      arr.each do |i|
        case i
        when SM::Flow::P
          s << '<p>'
          s << i.body
          s << '</p>'
        when SM::Flow::VERB
          s << '<pre>'
          s << i.body
          s << '</pre>'
        when SM::Flow::LI
          s << '<li>'
          s << i.body
          s << '</li>'
        when SM::Flow::LIST
          s << '<ul>'
          __struct2html(i.contents, s)
          s << '</ul>'
        when SM::Flow::H
          s << "<h#{i.level}>"
          s << i.text.to_s
          s << "</h#{i.level}>"
        end
      end      
    end
    
    #
    # initialize
    #
    self.refresh_ridata
    
  end
    
end


if $0 == __FILE__
  require 'pp'
  
  #pp RI2Reference::Utils.get_class_entry('Abbrev').comment[0].class
  #pp RI2Reference::Utils.get_method_entry('Array#push')
  #pp RI2Reference::Utils.get_all_class_names
  a = RI2Reference::Utils.get_all_names
  
  #a = RI2Reference::Utils.get_class_entry(ARGV[0])
  #a = RI2Reference::Utils.get_method_entry(ARGV[0])
  
  a = RI2Reference::Utils.search_name(ARGV[0])
  
  pp a
end

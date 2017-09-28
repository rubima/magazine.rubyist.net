require 'ri2ref_utils'

module RI2Reference

  class DirectAction < CGIKit::DirectAction
    
    def list_action
      pg = page(ClassListPage)
      pg.list = RI2Reference::Utils.get_all_class_names
      
      pg
    end
    
    def class_action
      pg = page(ClassPage)
      full_name = CGIKit::Utilities.unescape_url( request.form_value('n') )
      pg.setup( RI2Reference::Utils.get_class_description(full_name) )
      
      pg 
    end
    
    def method_action
      pg = page(MethodPage)
      full_name = CGIKit::Utilities.unescape_url( request.form_value('n') )
      pg.setup( RI2Reference::Utils.get_method_description(full_name) )
      
      pg
    end
    
    # gorgeous implementation
    def search_action      
      keys = request.form_values.keys
      if keys.empty?
        list_action
      else
        keyword = CGIKit::Utilities.unescape_url( keys[0].to_s ) 
        results = RI2Reference::Utils.search_name(keyword)        
        all_classes = RI2Reference::Utils.get_all_class_names
        
        methods = results - all_classes
        classes = results & all_classes
        
        pg = page(SearchResult)
        pg.method_list = methods
        pg.class_list = classes
        pg
      end
    end
    
    alias default_action list_action
        
  end

end

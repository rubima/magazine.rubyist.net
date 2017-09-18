module Registration
  
  class ConfirmPage < CGIKit::Component
    
    include UserInfo
    
    def next_page
      to_utf8
            
      p1 = page(ThanksPage)
      p1.name = self.name
      p1
    end
    
    def prev_page
      to_utf8
      
      p1 = page(RegisterPage)
      Registration.copy_info(self, p1)
      
      p1
    end
    
  end
  
end

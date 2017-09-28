require 'date'

module Registration
    
  class RegisterPage < CGIKit::Component
    
    include UserInfo
    
    def next_page
      to_utf8
      
      @error_name = (@name.to_s == "")
      @error_age = (/\A\d+\z/ !~ @age.to_s )
      @error_sex = (/\A[MF]\z/ !~ @sex.to_s)      
      @error_address = (@address.to_s == '')
      @error_phone = (/\A[0-9-]+\z/ !~ @phone.to_s )
      
      y = @year.to_i
      m = @month.to_i
      d = @day.to_i
      @error_date = false
      begin
        Date.new(y,m,d)
      rescue ArgumentError
        @error_date = true
      end
      
      error = @error_name || @error_age || @error_sex || @error_address || @error_phone || @error_date      
      unless error
        p1 = page(ConfirmPage)
        Registration.copy_info(self, p1)
        p1
      end
    end
    
  end
  
end


 def action_cancel()
   @form.set_values( session[:values] )
   AlTemplate.run( 'index.rhtml' )
   session.delete( :values )
 end
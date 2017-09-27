 def action_commit()
   @form.set_values( session[:values] )
   AlTemplate.run( 'commit.rhtml' )
 end
require 'al_template'
class AlController
  def action_index()	# デフォルトアクション
    @my_message = "Hello world."
    AlTemplate.run( 'index.rhtml' )
  end
end
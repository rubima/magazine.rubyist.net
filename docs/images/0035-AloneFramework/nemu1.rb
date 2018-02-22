 def initialize()
   @form = AlForm.new( ...省略 )
   @persist = AlPersistSh.connect( "/etc/my_settings.conf" )
 end

 # 入力フォームsubmit時の処理
 def action_commit()
   if @form.validate() then
     # バリデーション成功
     # 全てのフォーム入力値を /etc/my_settings.confへsh変数形式で保存する。
     @result = @persist.entry( @form.values )
     AlTemplate.run( "commit_view.rhtml" )
   else
     # バリデーション失敗
     # 入力フォームへ戻し、再入力を促す。
     AlTemplate.run( "form.rhtml" )
   end
 end
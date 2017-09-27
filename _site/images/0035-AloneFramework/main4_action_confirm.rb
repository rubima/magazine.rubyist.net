 ##
 # 確認画面
 #
 #@note
 # フォームから送られた値を確認し、
 # OKならセッションに保存した上で、確認画面を表示する。
 # NGならデフォルトフォームに戻す。
 #
 def action_confirm()
   if @form.validate()
     session[:values] = @form.values
     AlTemplate.run( 'confirm.rhtml' )
   else
     AlTemplate.run( 'index.rhtml' )
   end
 end
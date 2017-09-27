 ##
 # デフォルト動作
 #
 #@note
 # 念のためセッション変数を全て消去してから、デフォルト画面を表示
 #
 def action_index()
   session.delete_all()
   AlTemplate.run( 'index.rhtml' )
 end
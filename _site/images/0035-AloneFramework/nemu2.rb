 def action_graph_packets()
   # 変数ydata へ、パケット数のトレンドデータを用意する
   ydata0 = []
   ydata1 = []
   File.open( DATAFILE, "r" ) do |file|
     while text = file.gets
       pcnt0, pcnt1 = text.split()
       ydata0 << pcnt0.to_i
       ydata1 << pcnt1.to_i
     end
   end

   # グラフを描く
   graph = AlGraph.new( 600, 240 )
   graph.add_data_line( ydata0, "0 to 1" )
   graph.add_data_line( ydata1, "1 to 0" )
   graph.y_axis.min = 0
   graph.draw()
 end
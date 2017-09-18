 def draw_sample_01
   ydata1 = [ 5, 3, 6, 3, 2, 5, 6 ]

   graph = AlGraph.new
   graph.add_data_line(ydata1)

   graph.draw
 end
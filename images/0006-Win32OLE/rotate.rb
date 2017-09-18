require 'win32ole'

class WIN32OLE
  # We rotate an item upon the given pivot point
  def rotate_upon(degree, pivot=[0,0])
    theta = degree * Math::PI / 180
    left, top, right, bottom = self.GeometricBounds
    center = [(left+right)/2.0, (top+bottom)/2.0]
    
    v, pivot_to, transl = [], [], []
    v[0], v[1] = pivot[0] - center[0], pivot[1] - center[1]
    pivot_to[0] = center[0] + Math::cos(theta)*v[0] - Math::sin(theta)*v[1] 
    pivot_to[1] = center[1] + Math::sin(theta)*v[0] + Math::cos(theta)*v[1] 
    transl[0], transl[1] = pivot[0] - pivot_to[0], pivot[1] - pivot_to[1]

    self.Rotate(degree)
    self.Translate(*transl)
    self
  end # def rotate_upon(deg, pivot=[0,0])
end # class WIN32OLE

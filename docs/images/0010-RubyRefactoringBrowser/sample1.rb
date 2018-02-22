  # 複素数クラス
  class XComplex
    attr_reader :im, :re
    
    def initialize(im, re)
      @im = im
      @re = re
    end

    def +(o)
      XComplex.new(@im+o.im, @re+o.re)
    end

    def to_s
      "#{@re}+#{@im}i"
    end
  end

  if __FILE__ == $0
    x = XComplex.new(2, 3)
    y = x + XComplex.new(1, 10)
    puts y.to_s
  end

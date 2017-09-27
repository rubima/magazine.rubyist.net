require 'csv'

module AlbumUtility
  
  IMAGE = 'image'
  
  MONTH2DAY = {
    1 => 31,
    2 => 28,
    3 => 31,
    4 => 30,
    5 => 31,
    6 => 30,
    7 => 31,
    8 => 31,
    9 => 30,
    10 => 31,
    11 => 30,
    12 => 31,
  }
  
  attr_accessor :year, :month, :day
    
  def reap_year?(y)
    if  y % 4 == 0
      if y % 100 == 0
        if y % 400 == 0
          true
        else
          false
        end
      else
        true
      end
    else
      false
    end
  end
  
  def init_ymd
    unless valid_date?
      set_current_ymd
    end
  end
  
  def init_utility(dir = AlbumUtility::IMAGE)
    @dir = dir
    init_ymd
  end
  
  def valid_date?
    y = @year.to_i
    m = @month.to_i
    d = @day.to_i
    
    if m == 2 and reap_year?(y)
      max = 29
    else
      max = MONTH2DAY[m]
    end
    
    ((d > 0) and (d <= max))
  end
  
  def set_current_ymd
    t = Time.now
    @year = t.year.to_s
    @month = '%02d' % t.month
    @day = '%02d' % t.day
  end
  
  def next_month
    y = @year.to_i
    m = @month.to_i
    d = @day.to_i

    if (m == 2) and reap_year?(@year.to_i)
      Time.local(@year.to_i, @month.to_i, @day.to_i) + 86400 * 29
    else
      Time.local(@year.to_i, @month.to_i, @day.to_i) + 86400 * MONTH2DAY[m]
    end
  end
  
  def next_day
    Time.local(@year.to_i, @month.to_i, @day.to_i) + 86400
  end
  
  def prev_month
    y = @year.to_i
    m = @month.to_i
    d = @day.to_i
    
    if (m == 3) and reap_year?(@year.to_i)
      Time.local(@year.to_i, @month.to_i, @day.to_i) - 86400 * 29
    elsif m == 1
      Time.local(@year.to_i, @month.to_i, @day.to_i) - 86400 * 31
    else
      Time.local(@year.to_i, @month.to_i, @day.to_i) - 86400 * MONTH2DAY[m-1]
    end
  end
  
  def prev_day
    Time.local(@year.to_i, @month.to_i, @day.to_i) - 86400
  end
  
  
  
  def ymd2csvpath
    File.join(@dir, "#{@year}#{@month}#{@day}.csv")
  end
  
  def ymd2imagedir
    File.join(@dir, "#{@year}#{@month}#{@day}")
  end
  
  def add_entry(filename, comment, csvpath)
    s = ''
    CSV::Writer.generate(s){|w|
      w << [filename, comment]
    }
    
    #CGIKit::FileLock.exclusive_lock(csvpath, 'a') do |f|
    File.open(csvpath, 'a') do |f|
      f.write(s)
    end
  end
  
  def get_entries(filename)
    arr = []
    
    CGIKit::FileLock.shared_lock(filename) do |f|
      CSV::Reader.parse(f) do |row|
        arr << row
      end
    end
    
    arr
  end
  
end


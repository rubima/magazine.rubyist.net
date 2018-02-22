require "date"
 
def create_feb_first_day(year=Date.today.year)
  Date.new year, 2, 1
end
alias feb create_feb_first_day
 
def rectangle_february? (feb)
  feb.sunday? && !feb.leap?
end
alias rect_feb? rectangle_february?

def convert_febs year_range
  year_range.map {|y| feb y}
end
alias conv convert_febs

def weekday feb
  feb.strftime("%a")
end

def febs_detail febs
  febs.map {|feb| puts "#{feb.year}:#{weekday (feb)}:#{rect_feb?(feb)}:#{'leap' if feb.leap?}"}
end

def select_rect_febs febs
  febs.select {|feb| rect_feb? feb}
end

def febs_distance rect_febs
  prev = nil
  rect_febs.map do |feb|
    y = feb.year
    year_distance =  "#{y}"
    year_distance += ":#{(y - prev)}" if prev
    prev = y
    year_distance
  end
end

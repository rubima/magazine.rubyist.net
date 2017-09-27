Option = Struct.new(
  # オプションの種類
  :aaa,
  :bbb,
  :ccc,
)
o = Option.new(
  # オプションのデフォルト値
  false, # aaa
  1,     # bbb
  'ccc', # ccc
)
OptionParser.new do |opt|
  # オプションの設定
  opt.on("--aaa AAA", "set aaa") do |arg|
    o.aaa = arg
  end
end.parse!(ARGV)

CLI.run(o)

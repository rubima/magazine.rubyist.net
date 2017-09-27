require("luacom")

local ie = luacom.CreateObject("InternetExplorer.Application")
local events_handler = {}
function events_handler:DownloadComplete()
  print "Download Complete"
end
local cookie = luacom.Connect(ie,events_handler)

ie.Visible = 1
ie:gohome()
while ie.ReadyState ~= 4 do
end

ie:Navigate("http://www.ruby-lang.org/")

while ie.ReadyState ~= 4 do
end
count = 0
for index,element in luacom.pairs(ie.Document.all) do
  count = count + 1
end
print(string.format("complete \n%d elements found",count))

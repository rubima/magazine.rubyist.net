package require tcom

proc sink {method args} {
    if {$method eq "DownloadComplete"} then {
        puts "event $method $args"
    }
}

set ie [::tcom::ref createobject "InternetExplorer.Application"]
::tcom::bind $ie sink
$ie Visible 1
$ie GoHome
while {[$ie ReadyState] != 4} {
}

$ie Navigate "http://www.ruby-lang.org/"

while {[$ie ReadyState] != 4} {
}

set count 0
set elements [[$ie Document] all]
::tcom::foreach element $elements {
    incr count
}
puts "complete\n $count elements found"
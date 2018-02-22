use Win32::OLE qw(EVENTS in);
use Win32::OLE::Const ('Microsoft Internet Controls');

$| = 1;
my $ie = Win32::OLE->new('InternetExplorer.Application');
Win32::OLE->WithEvents($ie,"WebBrowserEvents","DWebBrowserEvents2");
$ie->{Visible} = 1;
$ie->GoHome();
Win32::OLE->MessageLoop();
while($ie->ReadyState() != READYSTATE_COMPLETE){
}

$ie->Navigate('http://www.ruby-lang.org/');

Win32::OLE->MessageLoop();
while($ie->ReadyState() != READYSTATE_COMPLETE){
}

my $count = 0;
foreach my $element (in $ie->Document->all){
    $count++;
}
print "complete\n ${count} elements found\n";

package WebBrowserEvents;
sub DownloadComplete {
    my ($obj,@args) = @_;
    print "Download Complete\n";
}
sub NavigateComplete2 {
    my ($obj,@args) = @_;
    Win32::OLE->QuitMessageLoop();
}

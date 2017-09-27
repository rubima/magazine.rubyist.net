require 'racknga'

notifier_options = {
  "host" => 127.0.0.1,
  "from" => "rurema@example.com",
  "to" => "developer@example.com",
  "charset" => "iso-2022-jp",
  "subject_label" => "[るりまサーチ] ",
}
notifiers = [Racknga::ExceptionMailNotifier.new(notifier_options)]
use Racknga::Middleware::ExceptionNotifier, :notifiers => notifiers
# ...
run your_application

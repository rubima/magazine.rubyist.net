  require 'sinatra/base'
  require 'padrino-mailer'

  class Application < Sinatra::Base
    register Padrino::Mailer

    mailer :sample do
      email :birthday do |name, age|
        subject 'Happy Birthday!'
        to      'john@fake.com'
        from    'noreply@birthday.com'
        locals  :name => name, :age => age
        render  'sample/birthday'
      end
    end
  end

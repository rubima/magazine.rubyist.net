  module Padrino
    module Helpers
      class << self
        def registered(app)
          app.set :default_builder, 'StandardFormBuilder'
          app.helpers Padrino::Helpers::OutputHelpers
          app.helpers Padrino::Helpers::TagHelpers
          app.helpers Padrino::Helpers::AssetTagHelpers
          app.helpers Padrino::Helpers::FormHelpers
          app.helpers Padrino::Helpers::FormatHelpers
          app.helpers Padrino::Helpers::RenderHelpers
          app.helpers Padrino::Helpers::NumberHelpers
          app.helpers Padrino::Helpers::TranslationHelpers
        end
        alias :included :registered
      end
    end # Helpers
  end # Padrino

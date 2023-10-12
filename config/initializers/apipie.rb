# frozen_string_literal: true

Apipie.configure do |config|
  config.app_name                = 'Inline Chat App'
  config.app_info                = ''
  config.api_base_url            = ''
  config.doc_base_url            = '/apipie'
  config.api_controllers_matcher = Rails.root.join('app/controllers/**/*.rb').to_s
end

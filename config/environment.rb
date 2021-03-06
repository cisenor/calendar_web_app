require 'bundler/setup'
require 'hanami/setup'
require 'hanami/model'
require_relative '../lib/calendar'
require_relative '../apps/web/application'

Hanami.configure do
  mount Web::Application, at: '/'

  model do
    ##
    # Database adapter
    #
    # Available options:
    #
    #  * SQL adapter
    #    adapter :sql, 'sqlite://db/calendar_development.sqlite3'
    #    adapter :sql, 'postgresql://localhost/calendar_development'
    #    adapter :sql, 'mysql://localhost/calendar_development'
    #
    adapter :sql, ENV['DATABASE_URL']

    ##
    # Migrations
    #
    migrations 'db/migrations'
    schema     'db/schema.sql'
  end

  mailer do
    root 'lib/calendar/mailers'

    # See http://hanamirb.org/guides/mailers/delivery
    delivery :test
  end

  environment :development do
    # See: http://hanamirb.org/guides/projects/logging
    logger level: :debug, stream: 'logs/hanami.log'
  end

  environment :production do
    logger level: :info, formatter: :json, filter: [], stream: 'logs/hanami.log'

    mailer do
      delivery :smtp, address: ENV['SMTP_HOST'], port: ENV['SMTP_PORT']
    end
  end
end

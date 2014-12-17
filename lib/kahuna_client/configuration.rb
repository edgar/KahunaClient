require 'faraday'
require 'kahuna_client/version'

module KahunaClient
  # Defines constants and methods related to configuration
  module Configuration
    # An array of valid keys in the options hash when configuring a {NYCGeoClient::API}
    VALID_OPTIONS_KEYS = [
      :adapter,
      :api_key, #password BasicAuthentication
      :secret_key, #username BasicAuthentication
      :endpoint,
      :environment, # (s = sandbox, p = production)
      :user_agent,
      :proxy,
      :debug
    ].freeze

    # The adapter that will be used to connect if none is set
    #
    # @note The default faraday adapter is Net::HTTP.
    DEFAULT_ADAPTER = Faraday.default_adapter

    # By default, don't set an API Key
    DEFAULT_API_KEY = nil

    # By default, don't set a Secret Key
    DEFAULT_SECRET_KEY = nil

    # The endpoint that will be used to connect if none is set
    #
    # @note There is no reason to use any other endpoint at this time
    DEFAULT_ENDPOINT = 'https://tap-nexus.appspot.com/'.freeze

    # By default, don't use a proxy server
    DEFAULT_PROXY = nil

    # By default, dont' log the request/response
    DEFAULT_DEBUG = false

    # The user agent that will be sent to the API endpoint if none is set
    DEFAULT_USER_AGENT = "KahunaClient #{KahunaClient::VERSION}".freeze

    # By default, use sandbox as environment
    DEFAULT_ENVIRONMENT = 's'
    # @private
    attr_accessor *VALID_OPTIONS_KEYS

    # When this module is extended, set all configuration options to their default values
    def self.extended(base)
      base.reset
    end

    # Convenience method to allow configuration options to be set in a block
    def configure
      yield self
    end

    # Create a hash of options and their values
    def options
      VALID_OPTIONS_KEYS.inject({}) do |option, key|
        option.merge!(key => send(key))
      end
    end

    # Reset all configuration options to defaults
    def reset
      self.adapter        = DEFAULT_ADAPTER
      self.api_key        = DEFAULT_API_KEY
      self.secret_key     = DEFAULT_SECRET_KEY
      self.endpoint       = DEFAULT_ENDPOINT
      self.environment    = DEFAULT_ENVIRONMENT
      self.user_agent     = DEFAULT_USER_AGENT
      self.proxy          = DEFAULT_PROXY
      self.debug          = DEFAULT_DEBUG
    end
  end
end
require 'kahuna_client/error'
require 'kahuna_client/configuration'
require 'kahuna_client/api'
require 'kahuna_client/client'

module KahunaClient
  extend Configuration

  # Alias for KahunaClient::Client.new
  #
  # @return [KahunaClient::Client]
  def self.client(options={})
    KahunaClient::Client.new(options)
  end

  # Delegate to KahunaClient::Client
  def self.method_missing(method, *args, &block)
    return super unless client.respond_to?(method)
    client.send(method, *args, &block)
  end

  # Delegate to KahunaClient::Client
  def self.respond_to?(method)
    return client.respond_to?(method) || super
  end
end

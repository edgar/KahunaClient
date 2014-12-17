require 'faraday'

# @private
module FaradayMiddleware
  # @private
  class RaiseHttpException < Faraday::Middleware
    def call(env)
      @app.call(env).on_complete do |response|
        if [400, 401, 404, 409, 500].include? response[:status].to_i
          raise KahunaClient::Error.new(error_message(response), response[:status].to_i, response[:body])
        end
      end
    end

    def initialize(app)
      super app
      @parser = nil
    end

    private

    def error_message(response)
      "#{response[:method].to_s.upcase} #{response[:url].to_s}: #{[response[:status].to_s, response[:body]].compact.join(': ')}"
    end
  end
end
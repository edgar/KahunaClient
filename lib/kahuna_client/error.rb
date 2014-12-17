require 'multi_json'

module KahunaClient
  # Custom error class for rescuing from all KahunaClient errors
  class Error < StandardError
    attr_reader :status, :error_code, :error_message

    def initialize(message, status=nil, data=nil)
      super(message)
      @status = status
      if data
        begin
          json_hash = MultiJson.load(data, symbolize_keys: true)
          @error_code = json_hash[:error_code] # should be the same as the HTTP status
          @error_message = json_hash[:error]
        rescue MultiJson::ParseError => exception
          # nothing to do
        end
      end
    end
  end

end
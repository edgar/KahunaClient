module KahunaClient
  # Defines HTTP request methods
  module Request
    # Perform an HTTP GET request
    def get(path, options={}, raw=false)
      request(:get, path, options, raw)
    end

    # Perform an HTTP POST request
    def post(path, options={}, raw=false)
      request(:post, path, options, raw)
    end

    # Perform an HTTP PUT request
    def put(path, options={}, raw=false)
      request(:put, path, options, raw)
    end

    # Perform an HTTP DELETE request
    def delete(path, options={}, raw=false)
      request(:delete, path, options, raw)
    end

    private

    # Perform an HTTP request
    def request(method, path, options, raw=false)
      new_options = options.dup
      response = connection(raw).send(method) do |request|
        case method
        when :get, :delete
          request.url(path, new_options)
        when :post, :put
          request.path = path
          request.params = {:env => environment}
          request.body = new_options.to_json unless new_options.empty?
        end
      end
      if raw
        response
      else
        response.body
      end
    end

  end
end
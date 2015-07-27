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
      only_params = new_options.delete :only_params

      post_params = {:env => environment}
      if only_params
        post_params = post_params.merge new_options
      end

      response = connection(raw).send(method) do |request|
        case method
        when :get, :delete
          request.url(path, new_options)
        when :post, :put
          request.path = path
          if !only_params
            request.body = new_options.to_json unless new_options.empty?
          end
          request.params = post_params
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

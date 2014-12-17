module KahunaClient
  class Client
    module Push

      # Send a Push notification to specific users.
      #
      # Params:
      # push_array: Array of one or more Push Objects to target for Push messages
      # default_params: (Optional) Dictionary of key/value pairs to send down with the Push that can be
      #                 extracted with the Kahuna SDK from deep-linking
      # default_config: (Optional) Dictionary of key/value configuration parameters that should be the default
      #                 values for all pushes in the push array
      #
      #
      def push(push_array, default_params = {}, default_config = {})
        options = {
          :default_params => default_params,
          :default_config => default_config,
          :push_array => push_array
        }
        post(push_path, options)
      end

      protected

      def push_path
        "api/push"
      end
    end
  end
end
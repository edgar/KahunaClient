module KahunaClient
  class Client
    module UserAttribute

      #
      # Send attributes data update to specific target user.
      # @params
      #   user_attributes_array: Array of one or more user's attributes.
      #
      def update(attr_array)
        request_object = {
          :user_attributes_array => attr_array
        }
        post(userattributes_path, request_object)
      end

      protected
        def userattributes_path
          "api/userattributes"
        end
    end
  end
end

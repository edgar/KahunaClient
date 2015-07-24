module KahunaClient
  class Client
    module Server

      # Sends user related events to Kahuna via Server API
      #
      #
      #
      def send_event(key:key, dev_id:dev_id, env:env, username:username, user_email:user_email, event:event)
        params = {
            :key => key,
            :dev_id => dev_id,
            :env => env,
            :username => username,
            :user_email => user_email,
            :event => event
        }

        post(send_path, params)
      end

      protected

      def send_path
        "log"
      end
    end
  end
end

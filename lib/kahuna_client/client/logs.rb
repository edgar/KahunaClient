module KahunaClient
  class Client
    module Logs

      # Fetch push logs
      #
      # Params:
      # timestamp: Timestamp from which to fetch logs
      # cursor: Cursor string from previous response
      # number_of_records: (Optional) Number of entries in log. Max 1000
      #
      def logs(options = {})
        timestamp = options[:timestamp] || Time.now.utc
        time_formatted = timestamp.strftime('%m/%d/%y %H:%M:%S %p')
        cursor = options[:cursor]
        number_of_records = options[:number_of_records] || 1000
        params = {
          :categories_to_return => [:push],
          :number_of_records => number_of_records          
        }
        # Cursor gets priority
        if cursor
          params.merge!({:cursor => cursor})
        else
          params.merge!({:timestamp => time_formatted})
        end
        # Do the post
        post(logs_path, params)
      end

      protected

      def logs_path
        "api/kahunalogs"
      end
    end
  end
end

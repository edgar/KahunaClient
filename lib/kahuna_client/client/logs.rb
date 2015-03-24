module KahunaClient
  class Client
    module Logs

      # Fetch push logs with timestamp
      #
      # Params:
      # timestamp: Timestamp from which to fetch logs
      # number_of_records: (Optional) Number of entries in log. Max 1000
      #
      def logs_with_timestamp(timestamp, number_of_records = 1000)
        time_formatted = timestamp.strftime('%m/%d/%y %H:%M:%S %p')
        options = {
          :categories_to_return => [:push],
          :number_of_records => number_of_records,
          :timestamp => time_formatted
        }
        post(logs_path, options)
      end

      # Fetch push logs with cursor
      #
      # Params:
      # cursor: Cursor string from previous response
      # number_of_records: (Optional) Number of entries in log. Max 1000
      #
      def logs_with_cursor(cursor, number_of_records = 1000)
        options = {
          :categories_to_return => [:push],
          :number_of_records => number_of_records,
          :cursor => cursor
        }
        post(logs_path, options)
      end

      protected

      def logs_path
        "api/kahunalogs"
      end
    end
  end
end

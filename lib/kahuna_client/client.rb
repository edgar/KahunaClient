module KahunaClient
  class Client < API

    Dir[File.expand_path('../client/*.rb', __FILE__)].each{|f| require f}

    include KahunaClient::Client::Push
    include KahunaClient::Client::Logs
    include KahunaClient::Client::UserAttribute
  end
end

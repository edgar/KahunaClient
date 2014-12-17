require File.expand_path('../../spec_helper', __FILE__)

describe KahunaClient::Client do
  it "should connect using the endpoint configuration" do
    client = KahunaClient::Client.new
    endpoint = URI.parse(client.endpoint)
    connection = client.send(:connection).build_url(nil).to_s
    expect(connection).to eq(endpoint.to_s)
  end

end
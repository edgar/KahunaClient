require File.expand_path('../../../spec_helper', __FILE__)

describe KahunaClient::Client do

  before do
    @client = KahunaClient::Client.new(app_id: 'ID', app_key: 'KEY', environment: 'p')
  end

  describe ".logs_with_timestamp" do

    before do
      # note here the env param
      stub_post("api/kahunalogs?env=p").
        with(body: {}).
        to_return(body: fixture("success.json"))
    end

    it "should get the correct resource" do
      @client.logs_with_timestamp(Time.now, 1)
      expect(a_post("api/kahunalogs?env=p").with(body: {})).to have_been_made
    end

  end
end

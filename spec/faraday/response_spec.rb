require File.expand_path('../../spec_helper', __FILE__)

describe Faraday::Response do
  let(:dummy_payload) {
    {
      default_params: {},
      default_config: {},
      push_array: [],
    }
  }

  before do
    @client = KahunaClient::Client.new
  end

  context "Authentication Failed - HTTP status 401" do
    before do
      stub_post("api/push?env=s").
        with(body: dummy_payload).
        to_return(body: fixture("authentication_failed.json"), status: 401)
    end

    it "should raise a KahunaClient error" do
      expect {
        @client.push([])
      }.to raise_error(KahunaClient::Error)
    end

    it "should raise a KahunaClient error with the proper attributes" do
      begin
        @client.push([])
      rescue KahunaClient::Error => exception
        expect(exception.status).to eq(401)
        expect(exception.error_code).to eq(401)
        expect(exception.error_message).to eq("Authentication failed")
      end
    end
  end

  context "User Not Found - HTTP status 404" do
    before do
      stub_post("api/push?env=s").
        with(body: dummy_payload).
        to_return(body: fixture("user_not_found.json"), status: 404)
    end

    it "should raise a KahunaClient error" do
      expect {
        @client.push([])
      }.to raise_error(KahunaClient::Error)
    end

    it "should raise a KahunaClient error with the proper attributes" do
      begin
        @client.push([])
      rescue KahunaClient::Error => exception
        expect(exception.status).to eq(404)
        expect(exception.error_code).to eq(404)
        expect(exception.error_message).to eq("User not found")
      end
    end
  end

  context "User Not Enabled For Push - HTTP status 409" do
    before do
      stub_post("api/push?env=s").
        with(body: dummy_payload).
        to_return(body: fixture("user_not_enabled_for_push.json"), status: 409)
    end

    it "should raise a KahunaClient error" do
      expect {
        @client.push([])
      }.to raise_error(KahunaClient::Error)
    end

    it "should raise a KahunaClient error with the proper attributes" do
      begin
        @client.push([])
      rescue KahunaClient::Error => exception
        expect(exception.status).to eq(409)
        expect(exception.error_code).to eq(409)
        expect(exception.error_message).to eq("User not enabled for push")
      end
    end
  end

  [400, 500].each do |status|
    context "when HTTP status is #{status}" do
      before do
        stub_post("api/push?env=s").
          with(body: dummy_payload).
          to_return(body: "", status: status) # test with an empty response
      end

      it "should raise a KahunaClient error" do
        expect {
          @client.push([])
        }.to raise_error(KahunaClient::Error)
      end

      it "should raise a KahunaClient error with the proper attributes" do
        begin
          @client.push([])
        rescue KahunaClient::Error => exception
          expect(exception.status).to eq(status)
          expect(exception.error_code).to be_nil
          expect(exception.error_message).to be_nil
        end
      end
    end
  end
end

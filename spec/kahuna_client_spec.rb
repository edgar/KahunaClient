require 'spec_helper'

describe KahunaClient do
  after do
    KahunaClient.reset
  end

  context "when delegating to a client" do

    let(:push_object) {
      {
        target: {
            username: "iamawesome1989",
            email: "awesome@mail.com",
            fbid: "42",
            user_id: "789"
        },
        notification: {
            alert: "Look at this Push!"
        },
        params: {
            sale_id: "1234",
            landing_page: "share_page"
        },
        config: {
            start_time: 1382652322,
            optimal_hours: 8,
            influence_rate_limiting: true,
            observe_rate_limiting: true
        }
      }
    }
    let(:payload) {
      {
        default_config:{},
        default_params:{},
        push_array: [push_object]
      }
    }
    before do
      stub_post("api/push?env=s").
        with(body: payload).
        to_return(body: fixture("success.json"))
      end

    it "should get the correct resource" do
      KahunaClient.push([push_object], {}, {})
      expect(a_post("api/push?env=s").
        with(body: payload)).to have_been_made
    end

    it "should return the same results as a client" do
      expect(KahunaClient.push([push_object])).to eq(KahunaClient::Client.new.push([push_object]))
    end

   end

  describe ".client" do
    it "should be a KahunaClient::Client" do
      expect(KahunaClient.client).to be_a(KahunaClient::Client)
    end
  end

  describe ".adapter" do
    it "should return the default adapter" do
      expect(KahunaClient.adapter).to be(KahunaClient::Configuration::DEFAULT_ADAPTER)
    end
  end

  describe ".adapter=" do
    it "should set the adapter" do
      KahunaClient.adapter = :typhoeus
      expect(KahunaClient.adapter).to be(:typhoeus)
    end
  end

  describe ".endpoint" do
    it "should return the default endpoint" do
      expect(KahunaClient.endpoint).to eq(KahunaClient::Configuration::DEFAULT_ENDPOINT)
    end
  end

  describe ".endpoint=" do
    it "should set the endpoint" do
      KahunaClient.endpoint = 'http://tumblr.com'
      expect(KahunaClient.endpoint).to eq('http://tumblr.com')
    end
  end

  describe ".user_agent" do
    it "should return the default user agent" do
      expect(KahunaClient.user_agent).to eq(KahunaClient::Configuration::DEFAULT_USER_AGENT)
    end
  end

  describe ".user_agent=" do
    it "should set the user_agent" do
      KahunaClient.user_agent = 'Custom User Agent'
      expect(KahunaClient.user_agent).to eq('Custom User Agent')
    end
  end

  describe ".environment" do
    it "should return the default environment" do
      expect(KahunaClient.environment).to eq(KahunaClient::Configuration::DEFAULT_ENVIRONMENT)
    end
  end

  describe ".environment=" do
    it "should set the environment" do
      KahunaClient.environment = 'p'
      expect(KahunaClient.environment).to eq('p')
    end
  end

  describe ".configure" do

    KahunaClient::Configuration::VALID_OPTIONS_KEYS.each do |key|

      it "should set the #{key}" do
        KahunaClient.configure do |config|
          config.send("#{key}=", key)
          expect(KahunaClient.send(key)).to eq(key)
        end
      end
    end
  end

end
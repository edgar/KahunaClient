require File.expand_path('../../spec_helper', __FILE__)

describe KahunaClient::API do
  before do
    @keys = KahunaClient::Configuration::VALID_OPTIONS_KEYS
  end

  context "with module configuration" do
    before do
      KahunaClient.configure do |config|
        @keys.each do |key|
          config.send("#{key}=", key)
        end
      end
    end

    after do
      KahunaClient.reset
    end

    it "should inherit module configuration" do
      api = KahunaClient::API.new
      @keys.each do |key|
        expect(api.send(key)).to be(key)
      end
    end
  end

  context "with class configuration" do
    before do
      @configuration = {
        :api_key => 'api key',
        :secret_key => 'secret key',
        :adapter => :typhoeus,
        :endpoint => 'http://tumblr.com/',
        :environment => 'p',
        :proxy => 'http://shayne:sekret@proxy.example.com:8080',
        :user_agent => 'Custom User Agent',
        :debug => true
      }
    end

    context "during initialization"

      it "should override module configuration" do
        api = KahunaClient::API.new(@configuration)
        @keys.each do |key|
          expect(api.send(key)).to be(@configuration[key])
        end
      end

    context "after initilization" do

      it "should override module configuration after initialization" do
        api = KahunaClient::API.new
        @configuration.each do |key, value|
          api.send("#{key}=", value)
        end
        @keys.each do |key|
          expect(api.send(key)).to be(@configuration[key])
        end
      end
    end
  end
end
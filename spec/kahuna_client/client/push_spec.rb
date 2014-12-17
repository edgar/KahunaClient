require File.expand_path('../../../spec_helper', __FILE__)

describe KahunaClient::Client do

  before do
    @client = KahunaClient::Client.new(app_id: 'ID', app_key: 'KEY', environment: 'p')
  end

  describe ".push" do
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
    let(:default_config) {
      {
        start_time: 1382652322,
        optimal_hours: 4,
        influence_rate_limiting: false,
        observe_rate_limiting: false,
        campaign_name: "New user campaign"
      }
    }
    let(:default_params) {
      {
        sale_id: "1234",
        landing_page: "share_page"
      }
    }
    let(:payload) {
      {
        default_config: default_config,
        default_params: default_params,
        push_array: [push_object]
      }
    }
    before do
      # note here the env param
      stub_post("api/push?env=p").
        with(body: payload).
        to_return(body: fixture("success.json"))
    end

    it "should get the correct resource" do
      @client.push([push_object], default_params, default_config)
      expect(a_post("api/push?env=p").with(body: payload)).to have_been_made
    end

  end
end

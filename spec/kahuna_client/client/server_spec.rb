require "spec_helper"

describe KahunaClient::Client do
  describe "#send_event" do

    subject {
      client.send_event key:  app_key,
                              dev_id: dev_id,
                              env: environment,
                              username: username,
                              user_email: user_email,
                              event: event
    }

    let(:client) {
      KahunaClient::Client.new app_id:  app_id,
                                        app_key: app_key,
                                        environment: environment
    }

    let(:app_id) { "id" }
    let(:app_key) { "key" }
    let(:environment) { "s" }
    let(:dev_id) { "12345678" }
    let(:username) { "test@email.com" }
    let(:user_email) { "test@email.com" }
    let(:event) { "signup" }

    let(:params) {
      {
          key: app_key,
          dev_id: app_id,
          env: environment,
          username: username,
          user_email: user_email,
          event: event
      }
    }

    before do
      stub_post("log?dev_id=12345678&env=s&event=signup&key=key&user_email=test@email.com&username=test@email.com")
          .to_return(:body => fixture('success.json'))
    end

    it "get the correct resource" do
      subject
      expect(a_post("log?dev_id=12345678&env=s&event=signup&key=key&user_email=test@email.com&username=test@email.com")).to have_been_made.once
    end
  end
end

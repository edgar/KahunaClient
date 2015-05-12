require File.expand_path('../../../spec_helper', __FILE__)

describe KahunaClient::Client do
  before do
    @client = KahunaClient::Client.new(app_id: 'ID', app_key: 'KEY', environment: 'p')
  end

  describe ".update" do
    let(:user_attribute) do
        {
          :target =>  {
            :username => "iamawesome1989",
            :email => "awesome@mail.com",
            :fbid => "42",
            :user_id => "789"
          },
          :attributes => {
            :first_name => "I Am",
            :last_name => "Awesome",
            :date_updated => "2015-05-12 15:11:51 +0700"
          }
        }
    end

    let(:request_object) do
      { :user_attributes_array => [user_attribute] }
    end

    before do
      stub_post('api/userattributes?env=p')
        .with(:body => request_object)
        .to_return(:body => fixture('success.json'))
    end

    it "should get the correct resource" do
      @client.update([user_attribute])
      expect(a_post("api/userattributes?env=p").with(:body => request_object)).to have_been_made.once
    end
  end
end

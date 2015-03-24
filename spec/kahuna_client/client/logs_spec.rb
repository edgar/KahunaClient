require File.expand_path('../../../spec_helper', __FILE__)

describe KahunaClient::Client do

  before do
    @client = KahunaClient::Client.new(app_id: 'ID', app_key: 'KEY', environment: 'p')
  end

  describe ".logs with timestamp" do

    let!(:timestamp) { Time.now }

    let(:payload) {
      {
        categories_to_return: ['push'], 
        number_of_records: 1, 
        timestamp: timestamp.strftime('%m/%d/%y %H:%M:%S %p')
      }
    }
    
    before do
      # note here the env param
      stub_post("api/kahunalogs?env=p").
        with(body: payload).
        to_return(body: fixture("success.json"))
    end

    it "should get the correct resource" do
      @client.logs({timestamp:timestamp, number_of_records:1})
      expect(a_post("api/kahunalogs?env=p").with(body: payload)).to have_been_made
    end
  end

  describe ".logs with cursor" do

    let!(:cursor) { 'TestCursor' }

    let(:payload) {
      {
        categories_to_return: ['push'], 
        number_of_records: 1, 
        cursor: cursor
      }
    }
    
    before do
      # note here the env param
      stub_post("api/kahunalogs?env=p").
        with(body: payload).
        to_return(body: fixture("success.json"))
    end

    it "should get the correct resource" do
      @client.logs({cursor:cursor, number_of_records:1})
      expect(a_post("api/kahunalogs?env=p").with(body: payload)).to have_been_made
    end
  end

  


end

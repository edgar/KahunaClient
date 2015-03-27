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
        number_of_records: 5,
        timestamp: timestamp.strftime('%m/%d/%y %H:%M:%S %p')
      }
    }

    before do
      # note here the env param
      stub_post("api/kahunalogs?env=p").
        with(body: payload).
        to_return(body: fixture("logs.json"))
    end

    it "should get the correct resource" do
      @client.logs({timestamp:timestamp, number_of_records:5})
      expect(a_post("api/kahunalogs?env=p").with(body: payload)).to have_been_made
    end

    it "should parse the response in a proper way" do
      logs = @client.logs({timestamp:timestamp, number_of_records:5})

      # should have the proper fields
      [:cursor, :more_records, :push].each do |key|
        expect(logs.has_key?(key)).to be true
      end

      # push array should have the proper size
      expect(logs.push.size).to be 5
    end
  end

  describe ".logs with cursor" do

    let!(:cursor) { 'TestCursor' }

    let(:payload) {
      {
        categories_to_return: ['push'],
        number_of_records: 5,
        cursor: cursor
      }
    }

    before do
      # note here the env param
      stub_post("api/kahunalogs?env=p").
        with(body: payload).
        to_return(body: fixture("logs.json"))
    end

    it "should get the correct resource" do
      @client.logs({cursor:cursor, number_of_records:5})
      expect(a_post("api/kahunalogs?env=p").with(body: payload)).to have_been_made
    end
  end




end

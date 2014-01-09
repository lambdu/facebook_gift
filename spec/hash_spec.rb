require File.join(File.dirname(__FILE__), '..', 'fb_gift_parser')

describe "#sheet_to_hash" do

  TEST_EMAIL = ''

  it "hashes are correct" do
    parser = FbGiftParser.new
    subscriptions = parser.sheet_to_hash("#{File.dirname(__FILE__)}/fixtures/shipments_test_spec.xls")
    subscriptions.should eq([
      {
        first_name: "Alex",
        last_name: "Ron",
        street_address: "66 Willimson st",
        extended_address: "404",
        locality: "Tahoe City",
        region: "CO",
        postal_code: "90203",
        recipient_email: "#{TEST_EMAIL}",
        message_to_recipient: "Wouldn't be a Mother's Day without you.",
        price: "36.00"
      }, 
      {
        first_name: "Alicia",
        last_name: "Marie Valoti",
        street_address: "220 Warrington Ave",
        extended_address: nil,
        locality: "Tacoma",
        region: "AK",
        postal_code: "14545",
        recipient_email: "#{TEST_EMAIL}",
        message_to_recipient: "Because Mom needs a break every now and then!",
        price: "120.00"
      }
    ])
  end
end


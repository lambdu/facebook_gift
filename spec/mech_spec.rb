require 'rubygems'
require "mechanize"
require "nokogiri"
require File.join(File.dirname(__FILE__), '..', 'fb_gift_parser')
require File.join(File.dirname(__FILE__), '..', 'fb_gift_creator')
require File.join(File.dirname(__FILE__), 'vcr_setup')

STAGING_SERVER_NAME = ''
TEST_PASSWORD = ''
TEST_EMAIL = ''

describe "#create" do
  it "goes to right website and enters correct info" do
    parser = FbGiftParser.new
    array = parser.sheet_to_hash("#{File.dirname(__FILE__)}/fixtures/shipments_test_spec.xls")
    OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
    I_KNOW_THAT_OPENSSL_VERIFY_PEER_EQUALS_VERIFY_NONE_IS_WRONG = nil
    VCR.use_cassette('mech_spec_web') do
    creator = FbGiftCreator.new('#{TEST_EMAIL}', '#{TEST_PASSWORD}', '#{STAGING_SERVER_NAME}')
    print "testing "
      array.each do |subscription|
        expect(creator.create(subscription) == true)
        print "."
      end

      # The test file checks to make sure information is updated on the subscriptions page
      agent = Mechanize.new
      page = agent.get 'https://#{STAGING_SERVER_NAME}/sign_in'
      form = page.forms.first
      form.field_with(name: 'user[email]').value = '#{TEST_EMAIL}'
      form.field_with(name: 'user[password]').value = '#{TEST_PASSWORD}'
      form.submit
      page = agent.get 'https://#{STAGING_SERVER_NAME}/subscriptions/my'
      expect(page.links_with(href: /canceling/).length) == 3
      print '.'
    end
  end
end

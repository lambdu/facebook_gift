require 'rubygems'
require 'spreadsheet'

class FbGiftParser
  def sheet_to_hash(spreadsheet)
    # Initializes array that holds the hashes
    subscriptions = []

    # Initializes spreadsheet reader
    book = Spreadsheet.open spreadsheet
    sheet1 = book.worksheet 0

    # Creates a hash out of important information in each row
    sheet1.each 1 do |row|
      user_info = {first_name: row[2], last_name: row[3], street_address: row[4], extended_address: row[5], locality: row[6], 
        region: row[7], postal_code: row[8], recipient_email: row[10], message_to_recipient: row[14], price: row[17]}
      subscriptions.push(user_info)
    end

    subscriptions
  end
end

require 'rubygems'
require 'mechanize'
require 'openssl'

class FbGiftCreator
  def initialize(username, password, url)
    @login = false
    @agent = Mechanize.new
    @username = username
    @password = password
    @url = url
  end

  def price_to_url(price)
    coupon_code = 'FB' + (price.to_i/10).to_s + 'MTH'
    strings = [
      ["36.00", "Three"],
      ["66.00", "Six"],
      ["120.00", "Twelve"]
    ]
    plan_id =  ""
    strings.each do |string|
      if string[0] == price
        plan_id = "#{string[1]}Months"
      end
    end
    return "https://#{@url}/subscriptions/new?coupon_code=#{coupon_code}&plan_id=#{plan_id}&gift=1"
  end

  def create(subscription)

    #logs in
    if @login == false
      page = @agent.get "https://#{@url}/sign_in"
      form = page.forms.first
      form.field_with(:name => "user[email]").value = @username
      form.field_with(:name => "user[password]").value = @password
      form.submit
      @login = true
    end

    #generates correct url from price
    price = subscription.delete(:price)
    page = @agent.get price_to_url(price)
    form = page.forms.first
    subscription.each do |key, value|
      form.field_with(name: "address[#{key}]").value = value
    end
    form.submit
    return true
  end
end

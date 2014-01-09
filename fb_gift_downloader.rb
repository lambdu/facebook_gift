require 'mechanize'

class FbGiftDownloader
  def initialize
    @username = 'username'
    @password = 'password'

  def login(agent)
    page = agent.get("PUT URL HERE")
    form = page.forms.first
    form.field_with(:name => "username").value = @username
    form.field_with(:name => "password").value = @password
    form.submit

  def download
    agent =Mechanize.new
    login(agent)
    file = agent.get("PUT DOWNLOAD URL HERE")

  def work
    

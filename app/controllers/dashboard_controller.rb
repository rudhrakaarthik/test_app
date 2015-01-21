class DashboardController < ApplicationController


  def index
  end

  def show
    if params["user_name"].present?
      @client_details = client.user_timeline("#{params["user_name"]}").first(10).map { |tweet| tweet.text } rescue nil
      request_git = Typhoeus::Request.get("https://api.github.com/users/#{params["user_name"]}")
      request_repo = Typhoeus::Request.get("https://api.github.com/users/#{params["user_name"]}/repos")
      @github = JSON.parse request_git.body
      repos = JSON.parse request_repo.body
      @repo_names = repos.collect { |i| i["name"] } if repos.kind_of?(Array)
      request_gems = Typhoeus::Request.get("https://rubygems.org/api/v1/owners/#{params["user_name"]}/gems.json")
      @gems = JSON.parse request_gems.body if request_gems.response_code.eql?(200)
    end
    respond_to do |format|
      format.html
      format.pdf do
        render :pdf => "Twitter-Github-Gem-Details",
               :disposition => 'attachment'
      end
    end
  end

  private

  #
  def client
    @client ||= Twitter::REST::Client.new do |config|
      config.consumer_key = Rails.application.secrets.CONSUMER_KEY
      config.consumer_secret = Rails.application.secrets.CONSUMER_SECRET
      config.access_token = Rails.application.secrets.ACCESS_TOKEN
      config.access_token_secret = Rails.application.secrets.ACCESS_SECRET
    end
  end
end

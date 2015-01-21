class DashboardController < ApplicationController

  def index
  end

  def show
    @client_details = client.user_timeline("#{params["user_name"]}").first(10).map{|tweet| tweet.text} rescue nil
=begin
  rescue => e
    @error = "Error while fetching tweets for: #{params["user_name"]}, #{e.message} "
    Rails.logger.error {@error}
    nil
=end

    request_git = Typhoeus::Request.get("https://api.github.com/users/#{params["user_name"]}")
    request_repo = Typhoeus::Request.get("https://api.github.com/users/#{params["user_name"]}/repos")
    @github = JSON.parse request_git.body
    repos = JSON.parse request_repo.body
    @repo_names = repos.kind_of?(Array) ? repos.collect {|i| i["name"]} : []

  end

  private

  def client
    @client ||= Twitter::REST::Client.new do |config|
      config.consumer_key = Rails.application.secrets.CONSUMER_KEY
      config.consumer_secret = Rails.application.secrets.CONSUMER_SECRET
      config.access_token = Rails.application.secrets.ACCESS_TOKEN
      config.access_token_secret = Rails.application.secrets.ACCESS_SECRET
    end
  end
end

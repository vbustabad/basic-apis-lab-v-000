class RepositoriesController < ApplicationController

  def search

  end

  def github_search
    @resp = Faraday.get 'https://api.github.com/search/repositories' do |req|
       req.params['client_id'] = CLIENT_ID
       req.params['client_secret'] = CLIENT_SECRET
       req.params['name'] = params[:name]
       req.params['html_url'] = params[:html_url]
       req.params['description'] = params[:description]
     end

     body = JSON.parse(@resp.body)
     if @resp.success?
       @items = body["response"]["items"]
     else
       @error = body["meta"]["errorDetail"]
     end

     rescue Faraday::ConnectionFailed
      @error = "There was a timeout. Please try again."
     end
     render :search
  end

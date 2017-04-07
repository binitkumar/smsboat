class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_url_shortener

  def set_url_shortener
    authorize = UrlShortener::Authorize.new 'binitkumar', 'R_32e0ad74a16043179a1ac1602e8bf737'
    @url_shortener_client = UrlShortener::Client.new authorize
  end
end

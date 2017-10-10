class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception

  def verify_from_slack
    head :forbidden unless params[:token] == Rails.application.secrets.slack_api_key
  end
end

class PullRequestsController < ApplicationController
  def create
    @pull_request = PullRequest.new({ url: params[:text] })
    respond_to do |format|
      if @pull_request.save
        format.json
      else
        format.json { render json: @pull_request.errors, status: :unprocessable_entity }
      end
    end
  end
end

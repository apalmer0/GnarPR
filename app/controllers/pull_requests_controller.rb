class PullRequestsController < ApplicationController
  def create
    @pull_request = PullRequest.new(pull_request_params)
    respond_to do |format|
      if @pull_request.save
        format.json
      else
        format.json { render json: @pull_request.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def pull_request_params
    params.require(:pull_request).permit(
      :url,
      :comments_count,
      :approved,
      :review_requested,
      :files_changed_count,
      :commits_count,
    )
  end
end

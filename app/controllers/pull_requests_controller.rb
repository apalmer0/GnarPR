class PullRequestsController < ApplicationController
  before_action :verify_from_slack

  def create
    @pull_request = PullRequest.new({ url: params[:text] })

    if @pull_request.save
      render json: successful_response(@pull_request).to_json, status: :ok
    else
      render json: failed_response(@pull_request.errors).to_json, status: :ok
    end
  end

  private

  def successful_response(pr)
    {
      response_type: "in_channel",
      text: "uh oh look at this hotshot making a new PR",
      attachments: [
        {
          text: "check it out at #{pr.url}"
        }
      ]
    }
  end

  def failed_response(errors)
    {
      response_type: "ephemeral",
      text: "woof. that did not work.",
      attachments: collected_error_messages(errors.messages),
    }
  end

  def collected_error_messages(error_messages)
    keys = error_messages.keys

    attachments = []

    keys.each do |error_type|
      attachments.push({ text: "#{error_type}: #{error_messages[error_type].first}" })
    end

    return attachments
  end
end

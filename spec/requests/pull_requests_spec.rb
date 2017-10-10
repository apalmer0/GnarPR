require "rails_helper"

describe "Pull Requests", type: :request do
  describe "POST /pull_requests" do
    describe "A valid request" do
      let(:params) do
        {
          token: Rails.application.secrets.slack_api_key,
          team_id: "T0001",
          team_domain: "example",
          enterprise_id: "E0001",
          enterprise_name: "Globular%20Construct%20Inc",
          channel_id: "C2147483705",
          channel_name: "test",
          user_id: "U2147483697",
          user_name: "Steve",
          command: "/weather",
          text: "https://github.com/TheGnarCo/gladlydo-client/pull/742",
          response_url: "https://hooks.slack.com/commands/1234/5678",
          trigger_id: "13345224609.738474920.8088930838d88f008e0",
        }
      end

      it "is successful" do
        post pull_requests_path, params: params.to_json, headers: json_headers

        expect(response.status).to eq 200
      end

      it "creates a new PullRequest" do
        expect do
          post pull_requests_path, params: params.to_json, headers: json_headers
        end.to change { PullRequest.count }
          .from(0).to(1)
      end

      it "correctly serializes the response" do
        post pull_requests_path, params: params.to_json, headers: json_headers

        expect(json_response(response)["pull_request"].keys).to match_array([
          "url",
          "comments_count",
          "approved",
          "review_requested",
          "files_changed_count",
          "commits_count",
        ])
      end
    end

    describe "An invalid request" do
      context "when a url is not provided" do
        let(:params) do
          {
            token: Rails.application.secrets.slack_api_key,
            team_id: "T0001",
            team_domain: "example",
            enterprise_id: "E0001",
            enterprise_name: "Globular%20Construct%20Inc",
            channel_id: "C2147483705",
            channel_name: "test",
            user_id: "U2147483697",
            user_name: "Steve",
            command: "/weather",
            text: "",
            response_url: "https://hooks.slack.com/commands/1234/5678",
            trigger_id: "13345224609.738474920.8088930838d88f008e0",
          }
        end

        it "returns 422 - unprocessable entity" do
          post pull_requests_path, params: params.to_json, headers: json_headers

          expect(response.status).to eq 422
        end

        it "returns the correct errors" do
          post pull_requests_path, params: params.to_json, headers: json_headers

          expect(json_response(response)["url"]).to be_present
          expect(json_response(response)["url"].first).to eq "can't be blank"
        end
      end
    end
  end
end

require 'rails_helper'

describe PullRequest, type: :model do
  it { should validate_presence_of :url }
  it { should validate_numericality_of :comments_count }
  it { should validate_numericality_of :files_changed_count }
  it { should validate_numericality_of :commits_count }

  describe "callbacks" do
    describe ".set_defaults" do
      before do
        Timecop.freeze(DateTime.current)
      end

      after { Timecop.return }

      let(:pull_request) { PullRequest.new(url: "https://github.com/TheGnarCo/gladlydo-client/pull/742") }

      it "saves with defaults" do
        expect(pull_request.approved).to be false
        expect(pull_request.comments_count).to eq 0
        expect(pull_request.commits_count).to eq 0
        expect(pull_request.files_changed_count).to eq 0
        expect(pull_request.review_requested).to eq DateTime.current
      end
    end
  end
end

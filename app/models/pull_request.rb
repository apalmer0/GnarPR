class PullRequest < ActiveRecord::Base
  validates :url, presence: true
  validates :comments_count, numericality: true
  validates :files_changed_count, numericality: true
  validates :commits_count, numericality: true

  after_initialize :set_defaults

  def set_defaults
    self.approved ||= false
    self.comments_count ||= 0
    self.commits_count ||= 0
    self.files_changed_count ||= 0
    self.review_requested ||= DateTime.current
  end
end

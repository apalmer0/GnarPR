class CreatePullRequest < ActiveRecord::Migration[5.1]
  def change
    create_table :pull_requests do |t|
      t.string :url, null: false
      t.integer :comments_count, null: false
      t.boolean :approved, null: false, default: false
      t.datetime :review_requested, null: false
      t.integer :files_changed_count, null: false
      t.integer :commits_count, null: false
    end
  end
end

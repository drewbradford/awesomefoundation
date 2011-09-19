class AddChapterSubmissionUrl < ActiveRecord::Migration
  def self.up
    add_column "chapters", "submission_form_url", :text
  end

  def self.down
    remove_column "chapters", "submission_form_url"
  end
end

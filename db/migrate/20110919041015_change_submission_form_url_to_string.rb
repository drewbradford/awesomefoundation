class ChangeSubmissionFormUrlToString < ActiveRecord::Migration
  def self.up
    change_column "chapters", "submission_form_url", :string
  end

  def self.down
    change_column "chapters", "submission_form_url", :text
  end
end

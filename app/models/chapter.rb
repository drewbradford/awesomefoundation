class Chapter < ActiveRecord::Base

  has_many :trustees, :class_name => User.name

  has_many :projects

  named_scope :alphabetical, :order => :name

  def self.submission_form_urls
    connection.select_all("SELECT id, submission_form_url AS url FROM #{table_name} WHERE submission_form_url IS NOT NULL AND submission_form_url != ''").inject(Hash.new()) { |urls, chapter| urls[chapter["id"]] = chapter["url"]; urls }
  end

  def to_param
    slug
  end

end

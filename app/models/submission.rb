class Submission < ActiveRecord::Base
  belongs_to :chapter

  [:name, :email, :title, :description, :use].each do |field|
    validates_presence_of field, :message => "^#{field.to_s.humanize} is required"
  end

  before_validation :cleanup_newlines

  validates_length_of :name,        :maximum => 75,   :message => "^Name must be {{count}} characters or fewer"
  validates_length_of :email,       :maximum => 100,  :message => "^Email must be {{count}} characters or fewer"
  validates_length_of :url,         :maximum => 250,  :message => "^URL must be {{count}} characters or fewer", :allow_blank => true
  validates_length_of :phone,       :maximum => 20,   :message => "^Phone must be {{count}} characters or fewer", :allow_blank => true
  validates_length_of :title,       :maximum => 50,   :message => "^Title must be {{count}} characters or fewer"
  validates_length_of :description, :maximum => 2500, :message => "^Description must be {{count}} characters or fewer"
  validates_length_of :use,         :maximum => 500,  :message => "^Use must be {{count}} characters or fewer"

  validates_format_of :email, :with => Authlogic::Regex.email, :allow_blank => true
  validates_url_format_of :url, :message => "^URL is invalid", :allow_blank => true
  validates_inclusion_of :chapter_id, :in => Chapter.all.map(&:id), :allow_nil => true

  #CSV support
  comma do
    chapter :name => 'Chapter'
    name
    title
    description
    use
    url 'URL'
    email
    phone
  end

  class << self
    def valid_periods
      first_month   = Awesome::Month.new self.minimum('created_at')
      current_month = Awesome::Month.new Date.today

      (first_month..current_month).map { |m| [m.to_s, m.iso] }.reverse
    end

    def earliest_date
      self.minimum('created_at') || Time.zone.now
    end

    def search params
      conditions = []

      # Search for submission by chapter_id
      # and possibly exclude unspecified chapters
      if params[:chapter_id].to_i > 0
        unless params[:exclude_unspecified].blank?
          conditions << ['chapter_id = ?', params[:chapter_id]]
        else
          conditions << ['(chapter_id = ? OR chapter_id IS NULL)', params[:chapter_id]]
        end
      elsif !params[:exclude_unspecified].blank?
        conditions << ['chapter_id IS NOT NULL']
      end

      conditions << ['created_at >= ? AND created_at < ?', Awesome::Month.parse(params[:period]).iso, Awesome::Month.parse(params[:period]).next.iso] unless params[:period].blank?


      self.scoped(:conditions => conditions.map { |c| send(:sanitize_sql_array, c)}.join(' AND '), :order => 'created_at DESC')
    end
  end

  def title
    the_title = read_attribute(:title)
    the_title ||= name
  end

  protected

  # When submissions come in from the web, often newlines are \r\n
  # which messes up our maximum length. This should clean that up.
  def cleanup_newlines
    [:description, :use].each do |field|
      self[field].gsub!(/\r\n/, "\n") if self[field]
    end
  end
end
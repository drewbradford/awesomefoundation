class SubmissionsController < ApplicationController

  COLUMNS = [
    ["Chapter", proc { |row| row.chapter.name rescue "" }],
    ["Name", proc { |row| row.name }],
    ["Title", proc { |row| row.title }],
    ["Description", proc { |row| row.description }],
    ["Use", proc { |row| row.use }],
    ["URL", proc { |row| row.url }],
    ["Email", proc { |row| row.email }],
    ["Phone", proc { |row| row.phone }],
    ["Date", proc { |row| row.created_at }]
  ]

  # before_filter :require_user, :only => :index
  before_filter :authenticate, :only => :index

  def index
    @chapters        = Chapter.alphabetical
    @period_options  = Submission.valid_periods
    @all_submissions = Submission.search(params)
    @submissions     = @all_submissions.paginate(:page => params[:page], :per_page => 50)

    respond_to do |format|
      format.html

      format.json { render :json => @all_submissions }

      format.csv do
        csv_file = FasterCSV.generate(:col_sep => ",") do |csv|
          csv << COLUMNS.map { |column| column[0] }
          submissions.each do |row|
            csv_row = []
            COLUMNS.each do |column|
              csv_row << column[1].call(row)
            end
            csv << csv_row
          end
        end
        send_data csv_file, :filename => "submissions.csv"
      end
    end
  end

  def new
    @chapters = Chapter.all(:order => "name asc")
    @submission = Submission.new
    @submission.chapter = Chapter.find_by_slug(params[:chapter]) if params[:chapter]
  end

  def create
    @chapters = Chapter.all
    @submission = Submission.new(params[:submission])
    if @submission.save
      flash[:notice] = "Thanks! We've received your submission and will review it shortly. Hopefully you'll hear from us soon. But if not, don't fret. You can always submit more awesome ideas!"
      redirect_to new_submission_path
    else
      render :action => "new"
    end
  end

end

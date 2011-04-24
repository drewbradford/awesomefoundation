class SubmissionsController < ApplicationController
  # before_filter :require_user, :only => :index
  before_filter :authenticate, :only => :index

  def index
    @chapters         = Chapter.alphabetical
    @period_options   = Submission.valid_periods

    params[:period] ||= Awesome::Month.new.iso
    @all_submissions  = Submission.search(params)

    @submissions     = @all_submissions.paginate(:page => params[:page], :per_page => 50)

    respond_to do |format|
      format.html
      format.json { render :json => @all_submissions }
      format.csv  { render :csv  => @all_submissions }
    end
  end

  def new
    @chapters   = Chapter.alphabetical
    @submission = Submission.new
    @submission.chapter = Chapter.find_by_slug(params[:chapter]) if params[:chapter]
  end

  def create
    @chapters   = Chapter.alphabetical
    @submission = Submission.new(params[:submission])
    if @submission.save
      flash[:notice] = "Thanks! We've received your submission and will review it shortly. Hopefully you'll hear from us soon. But if not, don't fret. You can always submit more awesome ideas!"
      redirect_to new_submission_path
    else
      render :action => "new"
    end
  end

end

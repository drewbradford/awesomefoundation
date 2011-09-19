class SubmissionsController < ApplicationController
  # before_filter :require_user, :only => :index
  before_filter :authenticate, :only => :index

  def index
    # Ensure that we are searching over some date range
    params[:period_start] ||= Awesome::Month.this_month.iso
    params[:period_end]   ||= params[:period_end]

    @chapters         = Chapter.alphabetical
    @period_options   = Submission.valid_periods
    @all_submissions  = Submission.search(params)

    @submissions     = @all_submissions.paginate(:page => params[:page], :per_page => 50)

    respond_to do |format|
      format.html
      format.json { render :json => @all_submissions }
      format.csv  { render :csv  => @all_submissions }
    end
  end

  def new
    setup_edit_data

    @submission = Submission.new

    @submission.chapter = Chapter.find_by_slug(params[:chapter]) if params[:chapter]
  end

  def create
    @submission = Submission.new(params[:submission])

    if @submission.save
      # Send the confirmation email
      Notifier.deliver_submission_notification(@submission)

      flash[:notice] = "Thanks! We've received your submission and will review it shortly. Hopefully you'll hear from us soon. But if not, don't fret. You can always submit more awesome ideas!"
      redirect_to new_submission_path

    else
      setup_edit_data

      render :action => "new"
    end
  end

  protected

  def setup_edit_data
    @chapters        = Chapter.alphabetical
    @submission_urls = Chapter.submission_form_urls    
  end

end

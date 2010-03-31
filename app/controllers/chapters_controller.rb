class ChaptersController < ApplicationController
  
  before_filter :require_admin, :except => :show

  def index
    @chapters = Chapter.all(:order => "name asc")
  end
  
  def show
    @chapter = Chapter.find_by_slug(params[:id]) or raise ActiveRecord::RecordNotFound
  end
  
  def new
    @chapter = Chapter.new
  end
  
  def create
    @chapter = Chapter.new(params[:chapter])
    if @chapter.save
      redirect_to chapters_path
    else
      render :action => "new"
    end
  end
  
  def edit
    @chapter = Chapter.find_by_slug(params[:id])
  end
  
  def update
    @chapter = Chapter.find_by_slug(params[:id])
    if @chapter.update_attributes(params[:chapter])
      redirect_to chapters_path
    else
      render :action => "edit"
    end
  end
  
end
class PagesController < ApplicationController
  before_filter :check_administrator_role, :except => [:show]
  layout 'application_wide' 

    in_place_edit_for :page, :keywords
    in_place_edit_for :page, :description

  
  def index
   	 @pages = Page.find_all_by_parent_id('0',:order=>'position')
  end
	def positions
	  @homepage=Page.find(1)
	  @parent_id=params[:parent_id]
	  @pages = Page.find_all_by_parent_id(@parent_id, :conditions=>"id>1",:order=>'position')
	end
	
	def update_positions
	  @parent_id=params[:parent_id]
    params[:pages_container].each_index do |i|
      item = Page.find(params[:pages_container][i])
      item.position = i+1
      item.save
    end
    @pages = Page.find_all_by_parent_id(@parent_id, :conditions=>"id>1",:order=>'position')
    render :layout => false, :action => :positions
  end
  
  def show
    @page = Page.find(params[:id].to_i)
     render :layout=>'application' 
  end
  def test
    
  end
  def new
    @page = Page.new
  end
  
  def update_ajax
    @page = Page.find(params[:id].to_i)
    @page.body = params[:value]
    @page.save!
    flash.now[:notice] = "Page updated"
    render :text => params[:value]
  end

  def create
    @page = Page.new(params[:page])
    @parent_id=0
    if @page.parent
      @parent_id=@page.parent.id
    end
    @page.save!
    flash.now[:notice] = 'Page saved'
    respond_to do |format|
      format.html {  redirect_to :action => 'index' }
      format.js  
    end
  rescue ActiveRecord::RecordInvalid
    render :action => 'new'
  end

  def edit
    @page = Page.find(params[:id].to_i)
  end

  def update
    @page = Page.find(params[:id].to_i)
    @page.attributes = params[:page]
    @page.save!
    flash[:notice] = "Page updated"
    redirect_to :action => 'index'
  rescue
    render :action => 'edit'
  end
  

  
  def destroy
    @page = Page.find(params[:id].to_i)
    @parent_id=0
    if @page.parent
      @parent_id=@page.parent.id
    end
    if @page.destroy
      flash[:notice] = "Page deleted"
    else
      flash[:error] = "There was a problem deleting the page"
    end
    respond_to do |format|
      format.html {  redirect_to :action => 'index' }
      format.js  
    end
   
  end
end

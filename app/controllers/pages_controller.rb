
class PagesController < ApplicationController
  layout 'admin'

  before_action :confirm_login
  def update
    @page = Page.find(params[:id])
    @page_count = Page.count 
    @subjects = Subject.order("position ASC")
  end

  def delete
    @page = Page.find(params[:id])
    @subject_id = Subject.find(params[:subject_id])
  end

  def show
    @page = Page.find(params[:id])
    @subject_id = Subject.find(params[:subject_id])
  end

  def edit
    @page = Page.find(params[:id])
    @page_count = Page.count
    @subject_id = Subject.find(params[:subject_id])
    @subjects = Subject.where(:id=>@subject_id.id).order("position ASC")
  end

  def index
    @subject_id = Subject.find(params[:subject_id])
    @pages = Page.where(:subject_id => @subject_id).order("position ASC")  
  end

  def new
    @page = Page.new
    @subject_id = Subject.find(params[:subject_id])
    @page_count = Page.count + 1
    @subjects = Subject.where(:id=>@subject_id.id).order("position ASC")
  end

  def create
    @subject_id = Subject.find(params[:subject_id])
    @page = Page.new(post_params)
    if @page.save
      flash[:notice] = "Add Operation '#{@page.name}' is Successful"
      redirect_to(:action=>'show',:id => @page.id,:subject_id=>@subject_id)
    else
      flash[:notice] = "Error Occur during Adding Page"
      redirect_to(:action=>'index',:subject_id=>@subject_id.id)
    end
  end

  def destroy
    @page = Page.find(params[:id])
    @subject_id = Subject.find(params[:subject_id])
    @page.destroy
    flash[:notice] = "Delete Operation on '#{@page.name}' is Successful"
    redirect_to(:action=>'index',:subject_id=>@subject_id.id)
  end

  def update
    @subject_id = Subject.find(params[:subject_id])
    @page = Page.find(params[:id])
    if @edit = @page.update_attributes(post_params)
      flash[:notice] = "Operation Edit '#{@page.name}' successful";
      redirect_to(:action=>'show',:id=>@page.id,:subject_id=>@subject_id.id)
    else
       @page_count = Page.count
       @subjects = Subject.order("position ASC")
       render(:action=>'edit',:subject_id=>@subject_id)
    end
  end


  private
  def post_params
    params.require(:page).permit(:name,:position,:visible,:permalink,:subject_id)
  end

end

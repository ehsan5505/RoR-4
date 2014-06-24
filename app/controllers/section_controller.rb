class SectionController < ApplicationController
  
    layout 'admin'

    before_action :confirm_login

  def new
    @form = true
    @section =  Section.new
    @page    =  Page.find(params[:page_id])
    @subject =  Subject.find(params[:subject_id])
    @sections= Page.where(:id => @page.id).order("position ASC")
    @section_count = Section.count + 1
    @pages = Page.order("position ASC")
  end

  def delete
    @section  = Section.find(params[:id])
    @page     = Page.find(params[:page_id])
    @subject  = Subject.find(params[:subject_id])
  end

  def show
    @section  =  Section.find(params[:id])
    @page     =  Page.find(params[:page_id])
    @subject  =  Subject.find(params[:subject_id])
  end

  def edit
    @form = false
    @section = Section.find(params[:id])
    @page = Page.find(params[:page_id])
    @subject = Subject.find(params[:subject_id])
    @section_count = Section.count
    #@sections = Section.where(:id => @section.id)
    @sections = Page.where(:id => @page.id) 
  end

  def index
    @page = Page.find(params[:id])
    @subject = Subject.find(params[:subject_id])
    @sections= Section.where(:page_id => @page.id ).order("position ASC")
    #@sections = Section.where(:page_id => @page.id)order("position ASC")
  end

  # large program script are here
  def create
    @subject  = Subject.find(params[:subject_id])
    @page     = Page.find(params[:page_id])
    @data = Section.new(post_params)
    if @data.save
      #success strike
      flash[:notice] =  "Add '#{@data.name}' is Successful"
      redirect_to(:action=>'show',:id=>@data.id,:page_id=>@page.id,:subject_id=>@subject.id)
    else
      #failure occur
      flash[:notice] = "Failed to create new Section"
      redirect_to(:action=>'new',:page_id=>@page.id,:subject_id=>@subject_id)
    end
  end

  def update
    @page = Page.find(params[:page_id])
    @subject = Subject.find(params[:subject_id])
    @section = Section.find(params[:id])
    if @section.update_attributes(post_params)
      flash[:notice] = "Update Operation on '#{@section.name}' is Successful"
      redirect_to(:action=>'show',:id=>@section.id,:subject_id=>@subject.id,:page_id=>@page.id)
    else
      @section_count = Section.count
      @pages = Page.order("position ASC")
      flash[:notice] = "Failed To Update Operation on Section #{@section.name}"
      render(:action=>'edit',:id=>@section.id,:page_id=>@page.id,:subject_id=>@subject.id)
    end
  end

  def destroy
    @subject = Subject.find(params[:subject_id])
    @page = Page.find(params[:page_id])
    @data = Section.find(params[:id])
    if @data.destroy
      flash[:notice] = "Delete Operation on '#{@data.name}' is Successful"
      redirect_to(:action=>'index',:id => @page.id,:subject_id=>@subject_id )
    else
      flash[:notice] = "Delete Operation failed on '#{@data.name}'"
      render('delete',:id=>params[:id],:page_id=>@page.id,:subject_id=>@subject.id)
    end
  end


  private
  def post_params
    params.require(:section).permit(:name,:position,:visible,:page_id,:content_type,:content)
  end

end

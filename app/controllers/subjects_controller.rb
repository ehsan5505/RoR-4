class SubjectsController < ApplicationController
    
    layout 'admin'

    before_action :confirm_login

  def show
     @subject = Subject.find(params[:id])
  end

  def index
    @subjects = Subject.sorted
  end

  def edit
    @subject = Subject.find(params[:id])
    @subject_count = Subject.count
  end

  def new
    @subject = Subject.new({:name => "Enter Name..."})
    @subject_count = Subject.count + 1
  end
  
  def create
    # Initialize the new form
    
    @subject = Subject.new(subject_param)
    # save the subject
    if @subject.save
      #suceess will redirect to index page
      flash[:notice] = "Subject '#{@subject.name}' Created Successfully"
      redirect_to(:action=>'index')
    else
      #while failure goes to same page
      @subject_count = Subject.count + 1
      render('new')
    end
  end

  def update
    @subject = Subject.find(params[:id])
    if @subject.update_attributes(subject_param)
      flash[:notice] = "Subject '#{@subject.name}' Updated Successfully"
      redirect_to(:action=>'show',:id=>@subject.id)
    else
      @subject_count = Subject.count
      render('edit')
    end
  end

  def delete
    @subject = Subject.find(params[:id])
  end

  def destroy
    @subject = Subject.find(params[:id])
    @subject.destroy
      flash[:notice] = "Subject '#{@subject.name}' Deleted Successfully"
    redirect_to(:action=>'index')
  end

  private
  def subject_param
    params.require(:subject).permit(:name,:position,:visible)
  end
end
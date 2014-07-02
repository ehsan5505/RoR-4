class AdminUserController < ApplicationController

	# confirm the loogin
  before_action	:confirm_login

  #there is missing link between user and Section
  # I have not configure it out

  # latout
  layout	'admin'

  def index
  	@admins = AdminUser.sorted
  end

  def edit
    @admin = AdminUser.find(params[:id])
  end

  def update
    @data = AdminUser.find(params[:id])
    if @admin = @data.update_attributes(post_param)
      flash[:notice] = "Update to Admin User is Successfull"
      redirect_to(:action=>'index',:controller=>'admin_user')
    else
      flash[:notice] = "Failed to Update the Admin User"
      redirect_to(:action=>"edit",:controller=>'admin_user')
    end

  end

  def new
  	@admin = AdminUser.new
  end

  def create
  	@admin = AdminUser.new(post_param)
  	if @admin.save
  		flash[:notice] = "Another Admin User is added Successfully"
  		redirect_to(:action=>'index',:controller=>'admin_user')
  	else
  		flash[:notice] = "Unsuccessful in creating Admin User"
  		redirect_to(:controller=>'admin_user',:action=>'new')
  	end
  end

  def delete
    @admin = AdminUser.find(params[:id])
  end

  def destroyed
      AdminUser.find(params[:id]).destroy
      flash[:notice] = "Profile Deleted Successfully"
      redirect_to(:controller=>'admin_user',:action=>'index')
    
  end


	private 

	def post_param
		params.require(:admin).permit(:username,:password,:first_name,:last_name,:email)
	end
end

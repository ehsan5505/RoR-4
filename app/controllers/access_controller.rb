class AccessController < ApplicationController
  layout 'admin'

  before_action :confirm_login, :except=>[:login,:attempt_login,:logout]
  def index
  end

  def login
  end

  def attempt_login
  	if params[:username].present? && params[:password].present?
  		user = AdminUser.where(:username => params[:username]).first
  		if user
  			authorized = user.authenticate(params[:password])
  		end
  	end
  	if authorized
	  	session[:user_id] = authorized.id
	  	session[:username] = authorized.username
	  	flash[:notice] = "Welcome to the Board Mr. #{authorized.username}"
  		redirect_to(:action=>"index")
  	else
  		flash[:notice] = "Username And Password combination is invalid"
  		redirect_to(:action=>"login")
  	end
  end

  def logout
  	session[:user_id] = nil
  	session[:username] = nil
  	flash[:notice] = "You are logout successfully"
  	redirect_to(:action=>'login',:controller=>'access')
  end
end

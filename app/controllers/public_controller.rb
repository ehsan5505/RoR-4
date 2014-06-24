class PublicController < ApplicationController
  
  layout 'public'

  before_action   :setup_nav

  def index
  	# intro text
  end

  def show
  	@page = Page.where(:permalink => params[:permalink], :visible => true).order("position ASC").first
    	if @page.nil?
    		redirect_to(:action=>"index")
    	else
    		# no page error
    	end
  end

  
  private 
  def setup_nav
    @subject = Subject.where(:visible => true).order("position ASC")
  end

  
end

class AdminUser < ActiveRecord::Base

	has_secure_password

	has_and_belongs_to_many		:pages
	has_many		:section_edits
	has_many 		:sections, 	:through => :section_edits

	  # form validation condes
	validates_presence_of 	:username
	validates_presence_of	:password
	validates_presence_of	:email
	
	scope :sorted, lambda { order("last_name ASC").order("first_name ASC")  }  
	#scope :sorted,		lambda	{  order("subjects.position ASC")  }
	

	def name
		@admin.first_name+" "+@admin.last_name
	end
	

end

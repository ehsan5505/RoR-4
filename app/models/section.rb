class Section < ActiveRecord::Base
	has_many 	:section_edits
	has_many	:sections,	:through => :section_edits
	belongs_to	:page

	#form Validates take place
	validates_presence_of 	:name
	validates_presence_of	:position
	validates_presence_of	:visible
	validates_presence_of 	:page_id
	validates_presence_of	:content_type
	# update the time for the creation of page
	after_save				:touch_page


	private
	def touch_page
		page.touch
	end

end

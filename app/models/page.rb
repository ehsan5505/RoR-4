class Page < ActiveRecord::Base
	belongs_to	:subject
	has_and_belongs_to_many	:editors ,:class_name=>"AdminUser" ,:join_table => "admin_user_pages"
	has_many :section

	# form validation take place
	validates_presence_of	:name
	validates_presence_of 	:position
	validates_presence_of	:visible
	validates_presence_of 	:subject_id
	validates_uniqueness_of	:permalink
	validates_length_of		:permalink,	:within  => 3..255
	# Adding the default permalnk
	before_validation		:add_default_permalink
	# Update the subjec time
	after_save				:subject_touch


	scope	:sorted,	lambda	{  order("position ASC") }
	scope	:visible,	lambda	{  where(:visible => :true) }
	scope 	:invisible,	lambda 	{  where(:visible => :false) }
	scope 	:newest,	lambda	{  order("created_at DESC" ).first }	


	private
	def subject_touch
		subject.touch
	end

	def add_default_permalink
		if self.permalink.blank?
			self.permalink = "#{subject_id}-#{name.parameterize}"
		end
	end

end

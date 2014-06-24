class Subject < ActiveRecord::Base
	has_many	:page
	
	validates_presence_of 	:name
	validates_presence_of	:position
	validates_presence_of	:visible

	scope :visible,		lambda	{  where(:visible => true) }
	scope :invisible,	lambda	{  where(:visible => false)	}
	scope :sorted,		lambda	{  order("subjects.position ASC")  }
	scope :desorted,	lambda 	{  order("subjects.position DESC") }
	scope :newest,		lambda 	{  order("subjects.created_at DESC").limit(1)	}
	scope :search,		lambda	{ |quert| where(["name LIKE ?","%#{quert}%"]) }

end

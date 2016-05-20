class Post < ActiveRecord::Base
	belongs_to :user
	default_scope {order('date DESC')}
	self.per_page = 10
	validates :title, :presence => true,
                    :length => { :minimum => 5 }
 
  	has_many :comments
end

module User < ActiveRecord::Base
  belongs_to :group
end

module Group < ActiveRecord::Base
  has_many :users
end

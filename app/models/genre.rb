class Genre < ApplicationRecord

  has_many :infos, dependent: :destroy

  validates :name,presence:true

end

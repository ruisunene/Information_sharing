class Genre < ApplicationRecord

  has_many :infos, dependent: :destroy

  validates :name,length: { minimum: 2, maximum: 20 }, uniqueness: true
#presence:true

end

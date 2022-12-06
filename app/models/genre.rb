class Genre < ApplicationRecord

  has_many :infos, dependent: :destroy

end

class Memo < ApplicationRecord
  belongs_to :user
  belongs_to :info

  validates :memo, presence: true
end

class Memo < ApplicationRecord
  belongs_to :user
  belongs_to :info

   validates :comment, presence: true
end

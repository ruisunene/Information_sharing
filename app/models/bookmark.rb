class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :info
  validates :user_id, uniqueness: { scope: :info_id }
end

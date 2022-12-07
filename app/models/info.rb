class Info < ApplicationRecord
  belongs_to :genre
  belongs_to :user

  has_many :info_comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy

  def bookmarked_by?(user)
    bookmarks.where(user_id: user).exists?
  end
end

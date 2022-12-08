class Info < ApplicationRecord
  belongs_to :genre
  belongs_to :user

  has_many :info_comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :memos, dependent: :destroy

  def bookmarked_by?(user)
    bookmarks.where(user_id: user).exists?
  end

  def self.search_for(content, method)
    if method == 'perfect'
      Info.where(title: content)
    elsif method == 'forward'
      Info.where('title LIKE ?', content+'%')
    elsif method == 'backward'
      Info.where('title LIKE ?', '%'+content)
    else
      Info.where('title LIKE ?', '%'+content+'%')
    end
  end
end

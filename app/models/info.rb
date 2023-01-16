class Info < ApplicationRecord
  belongs_to :genre
  belongs_to :user

  has_many :info_comments, dependent: :destroy #コメント機能
  has_many :bookmarks, dependent: :destroy #ブックマーク機能
  has_many :memos, dependent: :destroy #メモ機能

  validates :title,presence:true,length:{maximum:30}
  validates :body,presence:true,length:{maximum:500}
#ブックマーク
  def bookmarked_by?(user)#既にブックマークが存在しているかを確認
    bookmarks.where(user_id: user).exists?
  end
#検索機能
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

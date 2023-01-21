class TagMap < ApplicationRecord
  # tag_mapsテーブルは、postsテーブルとtagsテーブルに属している
  belongs_to :info
  belongs_to :tag

  # 念のためのバリデーション
  validates :info_id, presence: true
  validates :tag_id, presence: true
end

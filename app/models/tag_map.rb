class TagMap < ApplicationRecord
  # tag_mapsテーブルは、infosテーブルとtagsテーブルに属している
  belongs_to :info
  belongs_to :tag

  validates :info_id, presence: true
  validates :tag_id, presence: true
end

class Tag < ApplicationRecord
  # tag_mapsと関連付けを行い、tag_mapsのテーブルを通しinfotsテーブルと関連づけ
  #   dependent: :destroyをつけることで、タグが削除された時にタグの関連付けを削除する
  has_many :tag_maps, dependent: :destroy, foreign_key: 'tag_id'

  # infosのアソシエーション
  #   Tag.infosとすれば、タグに紐付けられたInfoを取得可能になる
  has_many :infos, through: :tag_maps
end

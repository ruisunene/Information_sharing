class Info < ApplicationRecord
  belongs_to :genre
  belongs_to :user

  has_many :info_comments, dependent: :destroy #コメント機能
  has_many :bookmarks, dependent: :destroy #ブックマーク機能
  has_many :memos, dependent: :destroy #メモ機能
  has_many :tag_maps, dependent: :destroy #タグ機能
  has_many :tags, through: :tag_maps #タグ機能

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

  def save_tags(tags)

    # タグをスペース区切りで分割し配列にする
    #   連続した空白も対応するので、最後の“+”がポイント
    tag_list = tags.split(/[[:blank:]]+/)

    # 自分自身に関連づいたタグを取得する
    current_tags = self.tags.pluck(:name)

    # (1) 元々自分に紐付いていたタグと投稿されたタグの差分を抽出
    #   -- 記事更新時に削除されたタグ
    old_tags = current_tags - tag_list

    # (2) 投稿されたタグと元々自分に紐付いていたタグの差分を抽出
    #   -- 新規に追加されたタグ
    new_tags = tag_list - current_tags

    p current_tags

    # tag_mapsテーブルから、(1)のタグを削除
    #   tagsテーブルから該当のタグを探し出して削除する
    old_tags.each do |old|
      # tag_mapsテーブルにあるpost_idとtag_idを削除
      #   後続のfind_byでtag_idを検索
      self.tags.delete Tag.find_by(name: old)
    end

    # tagsテーブルから(2)のタグを探して、tag_mapsテーブルにtag_idを追加する
    new_tags.each do |new|
      # 条件のレコードを初めの1件を取得し1件もなければ作成する
      # find_or_create_by : https://railsdoc.com/page/find_or_create_by
      new_post_tag = Tag.find_or_create_by(name: new)

      # tag_mapsテーブルにpost_idとtag_idを保存
      #   配列追加のようにレコードを渡すことで新規レコード作成が可能
      self.tags << new_post_tag
    end
  end

end

class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :info
  validates :user_id, uniqueness: { scope: :info_id }
  #uniqueness 重複してブックマークする事を防ぐ
  #scope 1投稿に対して1ユーザーが1ブックマークをするため。無いと1ユーザーが1ブックマークすると他のユーザーがブックマークできなくなる
end

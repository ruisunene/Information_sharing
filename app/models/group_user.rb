#グループの中間テーブル
class GroupUser < ApplicationRecord
  belongs_to :user
  belongs_to :group
end

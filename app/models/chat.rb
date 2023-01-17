class Chat < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :message, presence:true
  #空白でチャットを送ることを防ぐ
end

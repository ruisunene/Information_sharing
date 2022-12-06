class Info < ApplicationRecord
  belongs_to :genre
  belongs_to :user

  has_many :info_comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
end

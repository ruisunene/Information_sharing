class Group < ApplicationRecord
  has_many :group_users, dependent: :destroy
  has_many :users, through: :group_users, dependent: :destroy

  validates :name, presence: true
  validates :introduction, presence: true

  #グループの検索
  def self.search_for(content, method)
    if method == 'perfect'
      Group.where(name: content)
    elsif method == 'forward'
      Group.where('name LIKE ?', content + '%')
    elsif method == 'backward'
      Group.where('name LIKE ?', '%' + content)
    else
      Group.where('name LIKE ?', '%' + content + '%')
    end
  end

end

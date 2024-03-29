class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :infos #情報の投稿
  has_many :info_comments, dependent: :destroy #コメント機能
  has_many :bookmarks, dependent: :destroy #ブックマーク機能
  has_many :memos, dependent: :destroy #コメント機能
  has_many :user_rooms, dependent: :destroy#チャット機能の中間テーブル
  has_many :chats, dependent: :destroy#チャット機能
  # 自分がフォローされる（被フォロー）側の関係性
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # 被フォロー関係を通じて参照→自分をフォローしている人
  has_many :followers, through: :reverse_of_relationships, source: :follower

  # 自分がフォローする（与フォロー）側の関係性
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  # 与フォロー関係を通じて参照→自分がフォローしている人
  has_many :followings, through: :relationships, source: :followed
  
  has_many :group_users, dependent: :destroy#グループ機能の中間テーブル
  has_many :groups, through: :group_users, dependent: :destroy#グループ機能

  has_one_attached :profile_image#ユーザーのプロフィール画像

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true

  def self.guest#ゲストログインに関する設定
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64#パスワードは自動で設定される
      user.name = "ゲスト"
      # user.confirmed_at = Time.now  # Confirmable を使用している場合は必要
      # 例えば name を入力必須としているならば， user.name = "ゲスト" なども必要
    end
  end
  #検索機能
  def self.search_for(content, method)
    if method == 'perfect'
      User.where(name: content)
    elsif method == 'forward'
      User.where('name LIKE ?', content + '%')
    elsif method == 'backward'
      User.where('name LIKE ?', '%' + content)
    else
      User.where('name LIKE ?', '%' + content + '%')
    end
  end

  #退会機能
  def active_for_authentication?
    super && (is_deleted == false)
  end
  
#フォロー・フォロワー機能
  def follow(user)
    relationships.create(followed_id: user.id)
  end

  def unfollow(user)
    relationships.find_by(followed_id: user.id).destroy
  end

  def following?(user)
    followings.include?(user)
  end

  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end

end

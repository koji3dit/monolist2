class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  
  has_many :following_relationships, class_name:  "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :following_users, through: :following_relationships, source: :followed
  has_many :followed_relationships, class_name:  "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followed_users, through: :followed_relationships, source: :follower

  has_many :ownerships , foreign_key: "user_id", dependent: :destroy
  has_many :items ,through: :ownerships
  has_many :wants, class_name: "Want", foreign_key: "user_id", dependent: :destroy
  has_many :want_items , through: :wants, source: :item
  has_many :haves, class_name: "Have", foreign_key: "user_id", dependent: :destroy
  has_many :have_items , through: :haves, source: :item


  # 他のユーザーをフォローする
  def follow(other_user)
    following_relationships.create(followed_id: other_user.id)
  end

  def unfollow(other_user)
    following_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    following_users.include?(other_user)
  end

  ## TODO 実装
  def have(item)
  end

  def unhave(item)
  end

  def have?(item)
  end

  def want(item)
  end

  def unwant(item)
  end

  def want?(item)
  end
  
  #want メソッド
  def want(want_item)
    wants.find_or_create_by(item_id: want_item.id)
  end
  def want?(want_item)
    item_id.include?(want_item)
  end
  def unwant(want_item)
    want_item=find_by(item_id: want_item.id)
    want_item.destroy if want_item
  end
  
  #have method
  
  def have(have_item)
    haves.find_or_create_by(item_id: have_item.id)
  end
  def have?(have_item)
    item_id.include?(have_item)
  end
  def unhave(have_item)
    have_item=find_by(item_id: have_item.id)
    have_item.destroy if have_item
  end
  
end

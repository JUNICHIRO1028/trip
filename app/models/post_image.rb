class PostImage < ApplicationRecord

  has_one_attached :image
  belongs_to :user
  has_many :post_comments, dependent: :destroy
  has_many :post_image_tags, dependent: :destroy
  has_many :tags, through: :post_image_tags, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true
  validates :image, presence: true
  validates :address, presence: true

  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end

  def self.looks(search, word)
    if search == "perfect_match"
      @post_image = PostImage.where("title LIKE?","#{word}")
    elsif search == "forward_match"
      @post_image = PostImage.where("title LIKE?","#{word}%")
    elsif search == "backward_match"
      @post_image = PostImage.where("title LIKE?","%#{word}")
    elsif search == "partial_match"
      @post_image = PostImage.where("title LIKE?","%#{word}%")
    else
      @post_image = PostImage.all
    end
  end

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
  
end

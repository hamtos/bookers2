class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

has_many :books, dependent: :destroy

has_one_attached :profile_image

validates :name, length: {in: 2..20}, uniqueness: true
validates :introduction, length: {maximum: 50}

 # 画像ファイルが見つからない場合、特定の画像ファイルを表示する
  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/142_refileDownloadImage.png')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
      profile_image.variant(resize_to_limit: [width, height]).processed
  end
end

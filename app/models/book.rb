class Book < ApplicationRecord

 has_one_attached :book_image
 belongs_to :user

 validates :title, presence: true
 validates :body, length: {maximum: 200} ,presence: true

 def get_book_image(width, height)
   unless book_image.attached?
     file_path = Rails.root.join('app/assets/images/142_refileDownloadImage.png')
     book_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
   end
     book_image.variant(resize_to_limit: [width, height]).processed
 end

end

class Question < ApplicationRecord
    has_many :answer, dependent: :destroy
    belongs_to :user

    mount_uploader :image, ImageUploader

    validates :title, presence: true, length: { maximum: 100 }
    validates :body, length: { maximum: 3000 }

    is_impressionable
end

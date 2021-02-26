class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question
  has_many :likes
  has_many :liked_users, through: :likes, source: :user

  validates :body, presence: true, length: { maximum: 1000 }

  # リッチテキストの設定
  has_rich_text :body
end

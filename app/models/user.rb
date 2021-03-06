class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_many :question, dependent: :destroy
  has_many :answer, dependent: :destroy
  has_many :likes
  has_many :liked_posts, through: :likes, source: :post

  def already_liked?(answer)
    self.likes.exists?(answer_id: answer.id)
  end

end

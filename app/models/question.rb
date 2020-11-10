class Question < ApplicationRecord
    has_many :answer, dependent: :destroy
    belongs_to :user

    # 画像投稿機能を追加gem
    mount_uploader :image, ImageUploader

    # タイトルと本文に制約を追加
    validates :title, presence: true, length: { maximum: 100 }
    validates :body, length: { maximum: 3000 }

    # PV(閲覧数)をカウントするgem
    is_impressionable

    # tagを追加gem
    acts_as_taggable 
    
end

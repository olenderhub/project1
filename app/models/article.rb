class Article < ActiveRecord::Base
  belongs_to :user

  mount_uploader :photo, PhotoUploader

  has_many :comments, dependent: :destroy
  has_many :commments, through: :comments
  validates :title, presence: true,
                    length: { minimum: 5 }
end

class Article < ActiveRecord::Base
  validates :title, length: { maximum: 20 }, presence: true
  validates :text, length: { maximum: 500 }, presence: true

  belongs_to :user

  mount_uploader :photo, PhotoUploader

  has_many :comments, dependent: :destroy
  has_many :commments, through: :comments

end

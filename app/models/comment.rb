class Comment < ActiveRecord::Base
  validates :body, length: { maximum: 500 }, presence: true

  belongs_to :article
  belongs_to :user
  has_many :commments
end

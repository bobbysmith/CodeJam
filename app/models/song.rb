class Song < ActiveRecord::Base
  belongs_to :user
  validates :url, presence: true
  acts_as_votable
end

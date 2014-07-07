class Song < ActiveRecord::Base
  belongs_to :user
  validates :url, presence: true

  has_reputation :votes,
    :source => :user,
    :aggregated_by => :sum
end

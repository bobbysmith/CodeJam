class User < ActiveRecord::Base
  has_many :songs

  has_reputation :votes, source: {reputation: :votes, of: :songs}, aggregated_by: :sum

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["name"]
    end
  end

end

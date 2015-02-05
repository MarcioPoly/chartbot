class Artist < ActiveRecord::Base
  has_many :albums
  has_many :tracks, :through => :albums
  has_many :plays

  validates_uniqueness_of :name

  def self.top_five
    order('plays_count DESC').limit(5)
  end

end


# analyze plays between date(now) and specific date in the past (e.g. yesterday, one week ago, one month ago.)
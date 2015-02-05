class Album < ActiveRecord::Base
  belongs_to :artist
  has_many :tracks
  has_many :plays

  validates :artist_id, presence: true


  validates_uniqueness_of :name, :scope => :artist_id
end

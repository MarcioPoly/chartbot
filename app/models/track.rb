class Track < ActiveRecord::Base
  belongs_to :artist
  belongs_to :album
  has_many :plays

  validates :album_id, :presence => true
  validates :name, :uniqueness => {:scope => :album_id}
end

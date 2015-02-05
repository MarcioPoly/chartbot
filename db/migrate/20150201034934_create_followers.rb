class CreateFollowers < ActiveRecord::Migration
  def change
    create_table :followers do |t|
      t.string :follower
      t.datetime :tweet_date

      t.timestamps
    end
  end
end

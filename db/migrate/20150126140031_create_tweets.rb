class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :description
      t.string :query
      t.datetime :next_tweet

      t.timestamps
    end
  end
end

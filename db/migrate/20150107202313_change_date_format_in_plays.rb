class ChangeDateFormatInPlays < ActiveRecord::Migration
  def change
    def up
      change_column :plays, :playdate, :datetime
    end

    def down
      change_column :plays, :playdate, :date
    end
  end
end

class AddTimestamps < ActiveRecord::Migration
  def change
    change_table :songs do |t|
      t.remove :timestamps
      t.timestamps
    end
  end 
end
